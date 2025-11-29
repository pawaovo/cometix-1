import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:path_provider/path_provider.dart';

import '../theme/app_theme.dart';
import '../widgets/settings_widgets.dart';

/// 聊天存储管理页面
class ChatStoragePage extends StatefulWidget {
  final VoidCallback onBack;

  const ChatStoragePage({super.key, required this.onBack});

  @override
  State<ChatStoragePage> createState() => _ChatStoragePageState();
}

class _ChatStoragePageState extends State<ChatStoragePage> {
  int _fileCount = 0;
  int _totalSize = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStorageInfo();
  }

  /// 加载存储信息
  Future<void> _loadStorageInfo() async {
    setState(() => _loading = true);
    try {
      final appDir = await getApplicationSupportDirectory();
      final dataDir = Directory('${appDir.path}/cometix_data');

      if (await dataDir.exists()) {
        int count = 0;
        int size = 0;

        await for (final entity in dataDir.list(recursive: true, followLinks: false)) {
          if (entity is File) {
            count++;
            try {
              size += await entity.length();
            } catch (_) {}
          }
        }

        if (mounted) {
          setState(() {
            _fileCount = count;
            _totalSize = size;
            _loading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _fileCount = 0;
            _totalSize = 0;
            _loading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _fileCount = 0;
          _totalSize = 0;
          _loading = false;
        });
      }
    }
  }

  /// 格式化文件大小
  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// 清理缓存
  Future<void> _clearCache() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认清理'),
        content: const Text('确定要清理所有缓存文件吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final appDir = await getApplicationSupportDirectory();
      final filesDir = Directory('${appDir.path}/cometix_data/files');

      if (await filesDir.exists()) {
        await filesDir.delete(recursive: true);
        await filesDir.create(recursive: true);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('缓存已清理')),
        );
        await _loadStorageInfo();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('清理失败：$e')),
        );
      }
    }
  }

  /// 清理所有数据
  Future<void> _clearAllData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认清理'),
        content: const Text('确定要清理所有数据吗？包括聊天记录和设置，此操作不可恢复！'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('确定清理'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final appDir = await getApplicationSupportDirectory();
      final dataDir = Directory('${appDir.path}/cometix_data');

      if (await dataDir.exists()) {
        await dataDir.delete(recursive: true);
        await dataDir.create(recursive: true);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('所有数据已清理，请重启应用')),
        );
        await _loadStorageInfo();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('清理失败：$e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '聊天存储', onBack: widget.onBack),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        // 存储统计
                        SectionGroup(
                          title: '存储统计',
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Icon(
                                    Symbols.folder_open,
                                    size: 64,
                                    color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '$_fileCount 个文件',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _formatSize(_totalSize),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // 存储管理
                        SectionGroup(
                          title: '存储管理',
                          children: [
                            ValueItem(
                              label: '刷新统计',
                              icon: Symbols.refresh,
                              onTap: _loadStorageInfo,
                            ),
                            ValueItem(
                              label: '清理缓存文件',
                              icon: Symbols.cleaning_services,
                              onTap: _clearCache,
                            ),
                            ValueItem(
                              label: '清理所有数据',
                              icon: Symbols.delete_forever,
                              onTap: _clearAllData,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // 说明
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '提示：清理缓存文件只会删除上传的文件，不会影响聊天记录。清理所有数据会删除所有内容，请谨慎操作。',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppTheme.gray500 : AppTheme.gray600,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
