import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

import '../theme/app_theme.dart';
import '../widgets/settings_widgets.dart';
import '../providers/settings_provider.dart';
import '../providers/backup_provider.dart';
import '../models/backup.dart';

/// 备份与恢复设置页面
class BackupSettingsPage extends ConsumerStatefulWidget {
  final VoidCallback onBack;

  const BackupSettingsPage({super.key, required this.onBack});

  @override
  ConsumerState<BackupSettingsPage> createState() => _BackupSettingsPageState();
}

class _BackupSettingsPageState extends ConsumerState<BackupSettingsPage> {
  late TextEditingController _urlController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _pathController;

  @override
  void initState() {
    super.initState();
    final config = ref.read(backupProvider).config;
    _urlController = TextEditingController(text: config.url);
    _usernameController = TextEditingController(text: config.username);
    _passwordController = TextEditingController(text: config.password);
    _pathController = TextEditingController(text: config.path);
  }

  @override
  void dispose() {
    _urlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _pathController.dispose();
    super.dispose();
  }

  /// 保存配置
  Future<void> _saveConfig() async {
    final config = WebDavConfig(
      url: _urlController.text.trim(),
      username: _usernameController.text.trim(),
      password: _passwordController.text,
      path: _pathController.text.trim().isEmpty
          ? 'cometix_backups'
          : _pathController.text.trim(),
      includeChats: ref.read(backupProvider).config.includeChats,
      includeFiles: ref.read(backupProvider).config.includeFiles,
    );
    await context.read<SettingsProvider>().setWebDavConfig(config);
    ref.read(backupProvider.notifier).updateConfig(config);
  }

  /// 显示消息
  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// 选择恢复模式并执行操作
  Future<void> _chooseRestoreModeAndRun(
      Future<void> Function(RestoreMode) action) async {
    final mode = await showDialog<RestoreMode>(
      context: context,
      builder: (ctx) => const _RestoreModeDialog(),
    );
    if (mode == null) return;
    try {
      await action(mode);
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('需要重启'),
          content: const Text('恢复完成，请重启应用以使更改生效。'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('确定'),
            ),
          ],
        ),
      );
    } catch (e) {
      _showMessage('恢复失败：$e', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backupState = ref.watch(backupProvider);
    final busy = backupState.busy;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '备份与恢复', onBack: widget.onBack),
            if (busy)
              const LinearProgressIndicator(minHeight: 2),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // WebDAV 服务器设置
                  _buildWebDavSection(isDark, busy),
                  const SizedBox(height: 16),

                  // 本地备份
                  _buildLocalBackupSection(isDark, busy),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// WebDAV 设置区域
  Widget _buildWebDavSection(bool isDark, bool busy) {
    final config = ref.watch(backupProvider).config;

    return SectionGroup(
      title: 'WebDAV 备份',
      children: [
        // URL
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WebDAV 服务器地址',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                ),
              ),
              const SizedBox(height: 8),
              shadcn.TextField(
                controller: _urlController,
                enabled: !busy,
                placeholder: const Text('https://dav.example.com/remote.php/webdav/'),
                style: const TextStyle(fontSize: 14),
                border: shadcn.Border.fromBorderSide(BorderSide.none),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                onChanged: (_) => _saveConfig(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // 用户名
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '用户名',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                ),
              ),
              const SizedBox(height: 8),
              shadcn.TextField(
                controller: _usernameController,
                enabled: !busy,
                placeholder: const Text('用户名'),
                style: const TextStyle(fontSize: 14),
                border: shadcn.Border.fromBorderSide(BorderSide.none),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                onChanged: (_) => _saveConfig(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // 密码
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '密码',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                ),
              ),
              const SizedBox(height: 8),
              shadcn.TextField(
                controller: _passwordController,
                enabled: !busy,
                obscureText: true,
                placeholder: const Text('••••••••'),
                style: const TextStyle(fontSize: 14),
                border: shadcn.Border.fromBorderSide(BorderSide.none),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                onChanged: (_) => _saveConfig(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // 路径
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '备份路径',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                ),
              ),
              const SizedBox(height: 8),
              shadcn.TextField(
                controller: _pathController,
                enabled: !busy,
                placeholder: const Text('cometix_backups'),
                style: const TextStyle(fontSize: 14),
                border: shadcn.Border.fromBorderSide(BorderSide.none),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                onChanged: (_) => _saveConfig(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // 包含聊天记录
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '包含聊天记录',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppTheme.gray200 : AppTheme.gray800,
                ),
              ),
              shadcn.Switch(
                value: config.includeChats,
                onChanged: busy
                    ? null
                    : (value) async {
                        final newConfig = config.copyWith(includeChats: value);
                        await context.read<SettingsProvider>().setWebDavConfig(newConfig);
                        ref.read(backupProvider.notifier).updateConfig(newConfig);
                      },
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // 包含文件
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '包含文件',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppTheme.gray200 : AppTheme.gray800,
                ),
              ),
              shadcn.Switch(
                value: config.includeFiles,
                onChanged: busy
                    ? null
                    : (value) async {
                        final newConfig = config.copyWith(includeFiles: value);
                        await context.read<SettingsProvider>().setWebDavConfig(newConfig);
                        ref.read(backupProvider.notifier).updateConfig(newConfig);
                      },
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // 操作按钮
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildActionButton(
                label: '测试连接',
                onTap: busy
                    ? null
                    : () async {
                        await _saveConfig();
                        try {
                          await ref.read(backupProvider.notifier).test();
                          _showMessage('WebDAV 连接测试成功');
                        } catch (e) {
                          _showMessage('连接失败：$e', isError: true);
                        }
                      },
              ),
              _buildActionButton(
                label: '恢复',
                onTap: busy
                    ? null
                    : () async {
                        await _saveConfig();
                        await _showRemoteBackupsDialog();
                      },
              ),
              _buildActionButton(
                label: '立即备份',
                filled: true,
                onTap: busy
                    ? null
                    : () async {
                        await _saveConfig();
                        try {
                          await ref.read(backupProvider.notifier).backup();
                          _showMessage('备份已上传到 WebDAV');
                        } catch (e) {
                          _showMessage('备份失败：$e', isError: true);
                        }
                      },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 本地备份区域
  Widget _buildLocalBackupSection(bool isDark, bool busy) {
    return SectionGroup(
      title: '本地备份',
      children: [
        ValueItem(
          label: '导出为文件',
          icon: Symbols.file_upload,
          onTap: busy
              ? null
              : () {
                  _exportBackup();
                },
        ),
        ValueItem(
          label: '备份文件导入',
          icon: Symbols.file_download,
          onTap: busy
              ? null
              : () {
                  _importBackup();
                },
        ),
      ],
    );
  }

  /// 导出备份
  Future<void> _exportBackup() async {
    await _saveConfig();
    try {
      final file = await ref.read(backupProvider.notifier).exportToFile();
      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: '导出备份文件',
        fileName: file.uri.pathSegments.last,
        type: FileType.custom,
        allowedExtensions: ['zip'],
      );
      if (savePath != null) {
        await File(savePath).parent.create(recursive: true);
        await file.copy(savePath);
        _showMessage('备份已导出到：$savePath');
      }
    } catch (e) {
      _showMessage('导出失败：$e', isError: true);
    }
  }

  /// 导入备份
  Future<void> _importBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    final path = result?.files.single.path;
    if (path == null) return;
    final file = File(path);
    await _chooseRestoreModeAndRun((mode) async {
      await ref
          .read(backupProvider.notifier)
          .restoreFromLocalFile(file, mode: mode);
    });
  }

  /// 构建操作按钮
  Widget _buildActionButton({
    required String label,
    required VoidCallback? onTap,
    bool filled = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: filled ? AppTheme.primaryColor : Colors.transparent,
          border: Border.all(
            color: filled ? AppTheme.primaryColor : AppTheme.gray300,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: filled ? Colors.white : AppTheme.gray700,
          ),
        ),
      ),
    );
  }

  /// 显示远程备份列表对话框
  Future<void> _showRemoteBackupsDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) => _RemoteBackupsDialog(
        onRestore: (item, mode) async {
          try {
            await ref.read(backupProvider.notifier).restore(item, mode: mode);
            if (!mounted) return;
            await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('需要重启'),
                content: const Text('恢复完成，请重启应用以使更改生效。'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('确定'),
                  ),
                ],
              ),
            );
          } catch (e) {
            _showMessage('恢复失败：$e', isError: true);
          }
        },
      ),
    );
  }
}

/// 远程备份列表对话框
class _RemoteBackupsDialog extends ConsumerStatefulWidget {
  final Future<void> Function(BackupFileItem, RestoreMode) onRestore;

  const _RemoteBackupsDialog({required this.onRestore});

  @override
  ConsumerState<_RemoteBackupsDialog> createState() =>
      _RemoteBackupsDialogState();
}

class _RemoteBackupsDialogState extends ConsumerState<_RemoteBackupsDialog> {
  List<BackupFileItem> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final items = await ref.read(backupProvider.notifier).listRemote();
      if (mounted) {
        setState(() {
          _items = items;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _items = [];
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载失败：$e')),
        );
      }
    }
  }

  String _prettySize(int size) {
    const units = ['B', 'KB', 'MB', 'GB'];
    double s = size.toDouble();
    int u = 0;
    while (s >= 1024 && u < units.length - 1) {
      s /= 1024;
      u++;
    }
    return '${s.toStringAsFixed(s >= 10 || u == 0 ? 0 : 1)} ${units[u]}';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 500),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    '远程备份',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Symbols.refresh),
                  onPressed: _loading ? null : _load,
                ),
                IconButton(
                  icon: const Icon(Symbols.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _items.isEmpty
                      ? const Center(child: Text('没有找到备份文件'))
                      : ListView.separated(
                          itemCount: _items.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemBuilder: (context, i) {
                            final item = _items[i];
                            final dateStr = item.lastModified
                                    ?.toLocal()
                                    .toString()
                                    .split('.')
                                    .first ??
                                '';
                            return Card(
                              child: ListTile(
                                leading: const Icon(Symbols.folder_zip),
                                title: Text(
                                  item.displayName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  '${_prettySize(item.size)}${dateStr.isNotEmpty ? ' · $dateStr' : ''}',
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Symbols.download),
                                      tooltip: '恢复',
                                      onPressed: () async {
                                        final mode = await showDialog<RestoreMode>(
                                          context: context,
                                          builder: (context) => const _RestoreModeDialog(),
                                        );
                                        if (mode != null && mounted) {
                                          await widget.onRestore(item, mode);
                                          if (mounted) Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Symbols.delete),
                                      tooltip: '删除',
                                      onPressed: () async {
                                        try {
                                          final next = await ref
                                              .read(backupProvider.notifier)
                                              .deleteAndReload(item);
                                          if (mounted) {
                                            setState(() => _items = next);
                                          }
                                        } catch (e) {
                                          if (mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('删除失败：$e')),
                                            );
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 恢复模式选择对话框
class _RestoreModeDialog extends StatelessWidget {
  const _RestoreModeDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('选择导入模式'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('请选择如何处理现有数据：'),
          const SizedBox(height: 16),
          _buildModeOption(
            context,
            title: '覆盖模式',
            subtitle: '清空本地数据后恢复备份',
            mode: RestoreMode.overwrite,
          ),
          const SizedBox(height: 8),
          _buildModeOption(
            context,
            title: '合并模式',
            subtitle: '智能合并，保留本地数据',
            mode: RestoreMode.merge,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
      ],
    );
  }

  Widget _buildModeOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required RestoreMode mode,
  }) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(mode),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
