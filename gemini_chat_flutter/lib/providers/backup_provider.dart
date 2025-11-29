import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/backup.dart';
import '../services/backup_service.dart';

/// 备份状态管理 Provider
final backupProvider =
    StateNotifierProvider<BackupNotifier, BackupState>((ref) {
  final service = BackupService();
  ref.onDispose(service.dispose);
  return BackupNotifier(service: service);
});

/// 备份状态
@immutable
class BackupState {
  const BackupState({
    this.busy = false,
    this.message,
    this.config = const WebDavConfig(),
  });

  final bool busy;
  final String? message;
  final WebDavConfig config;

  BackupState copyWith({
    bool? busy,
    String? message,
    WebDavConfig? config,
    bool clearMessage = false,
  }) {
    return BackupState(
      busy: busy ?? this.busy,
      message: clearMessage ? null : (message ?? this.message),
      config: config ?? this.config,
    );
  }
}

/// 备份状态管理器
class BackupNotifier extends StateNotifier<BackupState> {
  BackupNotifier({required BackupService service})
      : _service = service,
        super(const BackupState());

  final BackupService _service;

  WebDavConfig get config => state.config;

  /// 更新配置
  void updateConfig(WebDavConfig config) {
    state = state.copyWith(config: config, clearMessage: true);
  }

  /// 测试 WebDAV 连接
  Future<void> test() => _runGuarded(
        () => _service.testConnection(state.config),
        successMessage: 'WebDAV 连接测试完成',
      );

  /// 备份到 WebDAV
  Future<void> backup() => _runGuarded(
        () => _service.backupToWebDav(state.config),
        successMessage: '远端备份已更新',
      );

  /// 从 WebDAV 恢复
  Future<void> restore(
    BackupFileItem item, {
    RestoreMode mode = RestoreMode.overwrite,
  }) =>
      _runGuarded(
        () => _service.restoreFromWebDav(state.config, item, mode: mode),
        successMessage: '远端备份已恢复',
      );

  /// 列出远程备份文件
  Future<List<BackupFileItem>> listRemote() {
    return _service.listRemoteFiles(state.config);
  }

  /// 删除远程备份并重新加载列表
  Future<List<BackupFileItem>> deleteAndReload(BackupFileItem item) async {
    state = state.copyWith(busy: true, clearMessage: true);
    try {
      await _service.deleteRemoteFile(state.config, item);
      final next = await _service.listRemoteFiles(state.config);
      state = state.copyWith(busy: false, message: '已删除所选备份');
      return next;
    } catch (error) {
      state = state.copyWith(busy: false, message: error.toString());
      rethrow;
    }
  }

  /// 导出到本地文件
  Future<File> exportToFile() async {
    state = state.copyWith(busy: true, clearMessage: true);
    try {
      final file = await _service.exportToFile(state.config);
      state = state.copyWith(busy: false, message: '本地备份已导出');
      return file;
    } catch (error) {
      state = state.copyWith(busy: false, message: error.toString());
      rethrow;
    }
  }

  /// 从本地文件恢复
  Future<void> restoreFromLocalFile(
    File file, {
    RestoreMode mode = RestoreMode.overwrite,
  }) =>
      _runGuarded(
        () => _service.restoreFromLocalFile(file, state.config, mode: mode),
        successMessage: '本地备份已恢复',
      );

  /// 执行操作并处理状态
  Future<void> _runGuarded(
    Future<void> Function() action, {
    String? successMessage,
  }) async {
    state = state.copyWith(busy: true, clearMessage: true);
    try {
      await action();
      state = state.copyWith(
        busy: false,
        message: successMessage ?? state.message,
      );
    } catch (error) {
      state = state.copyWith(busy: false, message: error.toString());
      rethrow;
    }
  }
}
