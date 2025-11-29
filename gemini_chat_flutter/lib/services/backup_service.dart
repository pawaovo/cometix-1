import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

import '../models/backup.dart';
import '../models/chat_session.dart';

/// 备份服务：WebDAV 客户端、本地备份导出、恢复功能
class BackupService {
  BackupService({http.Client? httpClient})
      : _client = httpClient ?? http.Client();

  final http.Client _client;

  void dispose() {
    _client.close();
  }

  /// 测试 WebDAV 连接
  Future<void> testConnection(WebDavConfig config) async {
    _ensureConfigValid(config);
    final request = http.Request('PROPFIND', _collectionUri(config));
    request.headers.addAll({
      'Depth': '1',
      'Content-Type': 'application/xml; charset=utf-8',
      ..._authHeaders(config),
    });
    request.body = '''<?xml version="1.0" encoding="utf-8"?>
<d:propfind xmlns:d="DAV:">
  <d:prop>
    <d:displayname/>
  </d:prop>
</d:propfind>''';

    final response =
        await _client.send(request).then(http.Response.fromStream);
    if (response.statusCode != 207 &&
        (response.statusCode < 200 || response.statusCode >= 300)) {
      throw Exception('WebDAV 测试失败：${response.statusCode}');
    }
  }

  /// 准备备份文件（打包为 ZIP）
  Future<File> prepareBackupFile(WebDavConfig config) async {
    final tempDir = await _ensureTempDir();
    final timestamp =
        DateTime.now().toIso8601String().replaceAll(':', '-');
    final output =
        File(p.join(tempDir.path, 'cometix_backup_$timestamp.zip'));
    if (await output.exists()) {
      await output.delete();
    }

    final archive = Archive();

    // 添加 settings.json
    final settingsBytes = utf8.encode(await _exportSettingsJson());
    archive.addFile(
      ArchiveFile('settings.json', settingsBytes.length, settingsBytes),
    );

    // 添加 chats.json
    if (config.includeChats) {
      final chatsBytes = utf8.encode(await _exportChatsJson());
      archive.addFile(
        ArchiveFile('chats.json', chatsBytes.length, chatsBytes),
      );
    }

    // 添加文件目录
    if (config.includeFiles) {
      final filesDir = await _filesDirectory();
      if (await filesDir.exists()) {
        for (final entity
            in filesDir.listSync(recursive: true, followLinks: false)) {
          if (entity is! File) continue;
          final rel =
              p.relative(entity.path, from: filesDir.path).replaceAll('\\', '/');
          final fileBytes = await entity.readAsBytes();
          archive.addFile(
            ArchiveFile('files/$rel', fileBytes.length, fileBytes),
          );
        }
      }
    }

    final encoder = ZipEncoder();
    final zipBytes = encoder.encode(archive);
    if (zipBytes == null) {
      throw Exception('生成备份压缩包失败');
    }
    await output.writeAsBytes(zipBytes);
    return output;
  }

  /// 备份到 WebDAV
  Future<void> backupToWebDav(WebDavConfig config) async {
    _ensureConfigValid(config);
    final file = await prepareBackupFile(config);
    await _ensureCollection(config);
    final target = _fileUri(config, p.basename(file.path));
    final response = await _client.put(
      target,
      headers: {
        'Content-Type': 'application/zip',
        ..._authHeaders(config),
      },
      body: await file.readAsBytes(),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('上传备份失败：${response.statusCode}');
    }
  }

  /// 列出远程备份文件
  Future<List<BackupFileItem>> listRemoteFiles(WebDavConfig config) async {
    _ensureConfigValid(config);
    await _ensureCollection(config);
    final collection = _collectionUri(config);
    final request = http.Request('PROPFIND', collection);
    request.headers.addAll({
      'Depth': '1',
      'Content-Type': 'application/xml; charset=utf-8',
      ..._authHeaders(config),
    });
    request.body = '''<?xml version="1.0" encoding="utf-8"?>
<d:propfind xmlns:d="DAV:">
  <d:prop>
    <d:displayname/>
    <d:getcontentlength/>
    <d:getlastmodified/>
  </d:prop>
</d:propfind>''';

    final response =
        await _client.send(request).then(http.Response.fromStream);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('获取远端备份列表失败：${response.statusCode}');
    }

    final doc = XmlDocument.parse(response.body);
    final items = <BackupFileItem>[];
    final baseHref = collection.toString();

    for (final node in doc.findAllElements('response', namespace: '*')) {
      final rawHref =
          node.getElement('href', namespace: '*')?.innerText ?? '';
      if (rawHref.isEmpty) continue;
      final resolvedStr = Uri.parse(rawHref).isAbsolute
          ? Uri.parse(rawHref).toString()
          : collection.resolve(rawHref).toString();
      if (resolvedStr == baseHref || resolvedStr.endsWith('/')) {
        continue;
      }

      final nameCandidates = node
          .findAllElements('displayname', namespace: '*')
          .map((e) => e.innerText)
          .toList();
      final sizeCandidates = node
          .findAllElements('getcontentlength', namespace: '*')
          .map((e) => e.innerText)
          .toList();
      final mtimeCandidates = node
          .findAllElements('getlastmodified', namespace: '*')
          .map((e) => e.innerText)
          .toList();

      final uri = Uri.parse(resolvedStr);
      final displayName = nameCandidates.isNotEmpty &&
              nameCandidates.first.trim().isNotEmpty
          ? nameCandidates.first.trim()
          : (uri.pathSegments.isNotEmpty ? uri.pathSegments.last : uri.toString());
      final size =
          sizeCandidates.isNotEmpty ? int.tryParse(sizeCandidates.first) ?? 0 : 0;

      DateTime? lastModified;
      if (mtimeCandidates.isNotEmpty) {
        lastModified = _parseDavDate(mtimeCandidates.first);
      }
      lastModified ??= _timestampFromName(displayName);

      items.add(
        BackupFileItem(
          href: uri,
          displayName: displayName,
          size: size,
          lastModified: lastModified,
        ),
      );
    }

    items.sort(
      (a, b) =>
          (b.lastModified ?? DateTime.fromMillisecondsSinceEpoch(0))
              .compareTo(a.lastModified ?? DateTime.fromMillisecondsSinceEpoch(0)),
    );
    return items;
  }

  /// 删除远程备份文件
  Future<void> deleteRemoteFile(
      WebDavConfig config, BackupFileItem item) async {
    _ensureConfigValid(config);
    final request = http.Request('DELETE', item.href);
    request.headers.addAll(_authHeaders(config));
    final response =
        await _client.send(request).then(http.Response.fromStream);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('删除远端备份失败：${response.statusCode}');
    }
  }

  /// 从 WebDAV 恢复备份
  Future<void> restoreFromWebDav(
    WebDavConfig config,
    BackupFileItem item, {
    RestoreMode mode = RestoreMode.overwrite,
  }) async {
    _ensureConfigValid(config);
    final response =
        await _client.get(item.href, headers: _authHeaders(config));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('下载备份失败：${response.statusCode}');
    }
    final tempDir = await _ensureTempDir();
    final localFile = File(p.join(
      tempDir.path,
      item.displayName.isNotEmpty
          ? item.displayName
          : p.basename(item.href.path),
    ));
    await localFile.writeAsBytes(response.bodyBytes);
    try {
      await _restoreFromBackupFile(localFile, config, mode: mode);
    } finally {
      if (await localFile.exists()) {
        await localFile.delete();
      }
    }
  }

  /// 导出到本地文件
  Future<File> exportToFile(WebDavConfig config) => prepareBackupFile(config);

  /// 从本地文件恢复
  Future<void> restoreFromLocalFile(
    File file,
    WebDavConfig config, {
    RestoreMode mode = RestoreMode.overwrite,
  }) async {
    if (!await file.exists()) {
      throw Exception('本地备份文件不存在');
    }
    await _restoreFromBackupFile(file, config, mode: mode);
  }

  // ===== 私有辅助方法 =====

  void _ensureConfigValid(WebDavConfig config) {
    if (config.url.trim().isEmpty) {
      throw Exception('WebDAV 地址不能为空');
    }
  }

  Uri _collectionUri(WebDavConfig config) {
    var base = config.url.trim();
    if (base.endsWith('/')) {
      base = base.substring(0, base.length - 1);
    }
    final folder = config.path.trim();
    if (folder.isEmpty) {
      return Uri.parse('$base/');
    }
    final sanitized = folder.replaceAll(RegExp(r'^/+'), '');
    return Uri.parse('$base/$sanitized/');
  }

  Uri _fileUri(WebDavConfig config, String fileName) {
    final base = _collectionUri(config).toString();
    final sanitized = fileName.replaceAll(RegExp(r'^/+'), '');
    return Uri.parse('$base$sanitized');
  }

  Map<String, String> _authHeaders(WebDavConfig config) {
    if (config.username.trim().isEmpty) {
      return const {};
    }
    final token = base64Encode(
      utf8.encode('${config.username}:${config.password}'),
    );
    return {'Authorization': 'Basic $token'};
  }

  /// 确保 WebDAV 集合（目录）存在
  Future<void> _ensureCollection(WebDavConfig config) async {
    final trimmed = config.url.trim().replaceAll(RegExp(r'/+$'), '');
    if (trimmed.isEmpty) return;
    final segments = config.path
        .split('/')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    var current = trimmed;
    for (final segment in segments) {
      current = '$current/$segment';
      final uri = Uri.parse('$current/');
      final request = http.Request('PROPFIND', uri);
      request.headers.addAll({
        'Depth': '0',
        'Content-Type': 'application/xml; charset=utf-8',
        ..._authHeaders(config),
      });
      request.body =
          '<d:propfind xmlns:d="DAV:"><d:prop><d:displayname/></d:prop></d:propfind>';
      final response =
          await _client.send(request).then(http.Response.fromStream);
      if (response.statusCode == 404) {
        final create = await _client
            .send(
              http.Request('MKCOL', uri)..headers.addAll(_authHeaders(config)),
            )
            .then(http.Response.fromStream);
        if (create.statusCode >= 400 && create.statusCode != 405) {
          throw Exception('创建远端目录失败：${create.statusCode}');
        }
      } else if (response.statusCode == 401) {
        throw Exception('WebDAV 鉴权失败');
      }
    }
  }

  Future<Directory> _ensureTempDir() async {
    Directory dir = await getTemporaryDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<Directory> _dataRoot() async {
    final support = await getApplicationSupportDirectory();
    final dir = Directory(p.join(support.path, 'cometix_data'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<File> _settingsDataFile() async {
    final root = await _dataRoot();
    return File(p.join(root.path, 'settings.json'));
  }

  Future<File> _chatsDataFile() async {
    final root = await _dataRoot();
    return File(p.join(root.path, 'chats.json'));
  }

  Future<Directory> _filesDirectory() async {
    final root = await _dataRoot();
    return Directory(p.join(root.path, 'files'));
  }

  /// 导出设置为 JSON
  Future<String> _exportSettingsJson() async {
    final snapshot = await _readSettingsSnapshot();
    return jsonEncode(snapshot);
  }

  Future<Map<String, dynamic>> _readSettingsSnapshot() async {
    final file = await _settingsDataFile();
    if (await file.exists()) {
      try {
        final raw = await file.readAsString();
        if (raw.trim().isNotEmpty) {
          final decoded = jsonDecode(raw);
          if (decoded is Map) {
            return decoded.map(
              (key, value) => MapEntry(key.toString(), value),
            );
          }
        }
      } catch (_) {}
    }
    final prefs = await SharedPreferences.getInstance();
    final map = <String, dynamic>{};
    for (final key in prefs.getKeys()) {
      map[key] = prefs.get(key);
    }
    return map;
  }

  /// 从 JSON 恢复设置
  Future<void> _restoreSettingsFromJson(
    String raw,
    RestoreMode mode,
  ) async {
    if (raw.trim().isEmpty) return;
    final decoded = jsonDecode(raw);
    if (decoded is! Map) return;
    final incoming = decoded.map(
      (key, value) => MapEntry(key.toString(), value),
    );
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> fileMap;
    if (mode == RestoreMode.overwrite) {
      await prefs.clear();
      fileMap = Map<String, dynamic>.from(incoming);
      for (final entry in fileMap.entries) {
        await _writePreferenceValue(prefs, entry.key, entry.value);
      }
    } else {
      final existing = await _readSettingsSnapshot();
      fileMap = {...existing};
      for (final entry in incoming.entries) {
        if (!prefs.containsKey(entry.key)) {
          await _writePreferenceValue(prefs, entry.key, entry.value);
        }
        fileMap.putIfAbsent(entry.key, () => entry.value);
      }
    }
    final file = await _settingsDataFile();
    await file.parent.create(recursive: true);
    await file.writeAsString(jsonEncode(fileMap));
  }

  /// 导出聊天记录为 JSON
  Future<String> _exportChatsJson() async {
    final sessions = await _loadChatSessions();
    final payload = {
      'version': 1,
      'sessions': sessions.map((e) => e.toJson()).toList(),
    };
    return jsonEncode(payload);
  }

  Future<List<ChatSession>> _loadChatSessions() async {
    final file = await _chatsDataFile();
    if (!await file.exists()) {
      return const [];
    }
    final raw = await file.readAsString();
    if (raw.trim().isEmpty) return const [];
    final decoded = jsonDecode(raw);
    if (decoded is! Map) return const [];
    final sessions = (decoded['sessions'] as List?) ?? const [];
    return sessions
        .whereType<Map>()
        .map((item) => ChatSession.fromJson(
              item.cast<String, dynamic>(),
            ))
        .toList();
  }

  Future<void> _persistChatSessions(List<ChatSession> sessions) async {
    final file = await _chatsDataFile();
    await file.parent.create(recursive: true);
    final payload = {
      'version': 1,
      'sessions': sessions.map((e) => e.toJson()).toList(),
    };
    await file.writeAsString(jsonEncode(payload));
  }

  /// 从 JSON 恢复聊天记录
  Future<void> _restoreChatsFromJson(
    String raw,
    RestoreMode mode,
  ) async {
    if (raw.trim().isEmpty) return;
    final decoded = jsonDecode(raw);
    if (decoded is! Map) return;
    final list = (decoded['sessions'] as List?) ?? const [];
    final incoming = list
        .whereType<Map>()
        .map((item) => ChatSession.fromJson(
              item.cast<String, dynamic>(),
            ))
        .toList();
    if (mode == RestoreMode.overwrite) {
      await _persistChatSessions(incoming);
      return;
    }

    // Merge 模式：智能合并
    final existing = await _loadChatSessions();
    final byId = {for (final session in existing) session.id: session};
    for (final session in incoming) {
      final current = byId[session.id];
      if (current == null) {
        byId[session.id] = session;
        continue;
      }
      // 合并消息（去重）
      final seen = current.messages
          .map((msg) => '${msg.role}::${msg.text}')
          .toSet();
      final merged = [...current.messages];
      for (final msg in session.messages) {
        final signature = '${msg.role}::${msg.text}';
        if (seen.add(signature)) {
          merged.add(msg);
        }
      }
      byId[session.id] = current.copyWith(messages: merged);
    }
    await _persistChatSessions(byId.values.toList());
  }

  /// 恢复文件目录
  Future<void> _restoreFilesDirectory(
    Directory source,
    RestoreMode mode,
  ) async {
    final target = await _filesDirectory();
    if (mode == RestoreMode.overwrite && await target.exists()) {
      await target.delete(recursive: true);
    }
    await target.create(recursive: true);
    await for (final entity
        in source.list(recursive: true, followLinks: false)) {
      if (entity is! File) continue;
      final rel = p.relative(entity.path, from: source.path);
      final outFile = File(p.join(target.path, rel));
      if (mode == RestoreMode.merge && await outFile.exists()) {
        continue;
      }
      await outFile.parent.create(recursive: true);
      await entity.copy(outFile.path);
    }
  }

  /// 从备份文件恢复
  Future<void> _restoreFromBackupFile(
    File file,
    WebDavConfig config, {
    required RestoreMode mode,
  }) async {
    final tempDir = await _ensureTempDir();
    final restoreDir = Directory(
      p.join(
        tempDir.path,
        'cometix_restore_${DateTime.now().millisecondsSinceEpoch}',
      ),
    );
    if (await restoreDir.exists()) {
      await restoreDir.delete(recursive: true);
    }
    await restoreDir.create(recursive: true);

    try {
      final archive = ZipDecoder().decodeBytes(
        await file.readAsBytes(),
        verify: true,
      );
      for (final entry in archive) {
        final normalized = entry.name.replaceAll('\\', '/');
        final parts = normalized
            .split('/')
            .where((part) => part.isNotEmpty && part != '.' && part != '..')
            .toList();
        if (parts.isEmpty) continue;
        final targetPath = p.joinAll([restoreDir.path, ...parts]);
        if (entry.isFile) {
          final outFile = File(targetPath);
          await outFile.parent.create(recursive: true);
          await outFile.writeAsBytes(entry.content as List<int>);
        } else {
          await Directory(targetPath).create(recursive: true);
        }
      }

      // 恢复设置
      final settingsFile = File(p.join(restoreDir.path, 'settings.json'));
      if (await settingsFile.exists()) {
        await _restoreSettingsFromJson(
          await settingsFile.readAsString(),
          mode,
        );
      }

      // 恢复聊天记录
      if (config.includeChats) {
        final chatsFile = File(p.join(restoreDir.path, 'chats.json'));
        if (await chatsFile.exists()) {
          await _restoreChatsFromJson(
            await chatsFile.readAsString(),
            mode,
          );
        }
      }

      // 恢复文件
      if (config.includeFiles) {
        final filesDir = Directory(p.join(restoreDir.path, 'files'));
        if (await filesDir.exists()) {
          await _restoreFilesDirectory(filesDir, mode);
        }
      }
    } finally {
      if (await restoreDir.exists()) {
        await restoreDir.delete(recursive: true);
      }
    }
  }

  Future<void> _writePreferenceValue(
    SharedPreferences prefs,
    String key,
    dynamic value,
  ) async {
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is List) {
      final list = value.whereType<String>().toList();
      await prefs.setStringList(key, list);
    }
  }

  DateTime? _parseDavDate(String raw) {
    try {
      return DateTime.parse(raw);
    } catch (_) {
      try {
        return HttpDate.parse(raw);
      } catch (_) {
        return null;
      }
    }
  }

  DateTime? _timestampFromName(String name) {
    final match = RegExp(
      r'cometix_backup_(\d{4}-\d{2}-\d{2}T\d{2}-\d{2}-\d{2}\.\d+)',
    ).firstMatch(name);
    if (match == null) return null;
    final normalized = match
        .group(1)!
        .replaceFirstMapped(
          RegExp(r'T(\d{2})-(\d{2})-(\d{2})'),
          (m) => 'T${m[1]}:${m[2]}:${m[3]}',
        );
    try {
      return DateTime.parse(normalized);
    } catch (_) {
      return null;
    }
  }
}
