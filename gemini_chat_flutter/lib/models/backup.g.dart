// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebDavConfigImpl _$$WebDavConfigImplFromJson(Map<String, dynamic> json) =>
    _$WebDavConfigImpl(
      url: json['url'] as String? ?? '',
      username: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
      path: json['path'] as String? ?? 'cometix_backups',
      includeChats: json['includeChats'] as bool? ?? true,
      includeFiles: json['includeFiles'] as bool? ?? true,
    );

Map<String, dynamic> _$$WebDavConfigImplToJson(_$WebDavConfigImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'username': instance.username,
      'password': instance.password,
      'path': instance.path,
      'includeChats': instance.includeChats,
      'includeFiles': instance.includeFiles,
    };

_$BackupFileItemImpl _$$BackupFileItemImplFromJson(Map<String, dynamic> json) =>
    _$BackupFileItemImpl(
      href: const UriConverter().fromJson(json['href'] as String),
      displayName: json['displayName'] as String? ?? '',
      size: (json['size'] as num?)?.toInt() ?? 0,
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
    );

Map<String, dynamic> _$$BackupFileItemImplToJson(
  _$BackupFileItemImpl instance,
) => <String, dynamic>{
  'href': const UriConverter().toJson(instance.href),
  'displayName': instance.displayName,
  'size': instance.size,
  'lastModified': instance.lastModified?.toIso8601String(),
};
