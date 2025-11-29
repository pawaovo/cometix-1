import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup.freezed.dart';
part 'backup.g.dart';

/// 还原模式
enum RestoreMode {
  overwrite, // 完全覆盖：清空本地后恢复
  merge,     // 增量合并：智能去重
}

/// WebDAV 连接配置
@freezed
class WebDavConfig with _$WebDavConfig {
  const factory WebDavConfig({
    @Default('') String url,
    @Default('') String username,
    @Default('') String password,
    @Default('cometix_backups') String path,
    @Default(true) bool includeChats,
    @Default(true) bool includeFiles,
  }) = _WebDavConfig;

  factory WebDavConfig.fromJson(Map<String, dynamic> json) =>
      _$WebDavConfigFromJson(json);
}

/// WebDAV 文件条目
@freezed
class BackupFileItem with _$BackupFileItem {
  const factory BackupFileItem({
    @UriConverter() required Uri href,
    @Default('') String displayName,
    @Default(0) int size,
    DateTime? lastModified,
  }) = _BackupFileItem;

  factory BackupFileItem.fromJson(Map<String, dynamic> json) =>
      _$BackupFileItemFromJson(json);
}

/// Uri <-> 字符串转换
class UriConverter extends JsonConverter<Uri, String> {
  const UriConverter();

  @override
  Uri fromJson(String json) => json.isEmpty ? Uri() : Uri.parse(json);

  @override
  String toJson(Uri object) => object.toString();
}
