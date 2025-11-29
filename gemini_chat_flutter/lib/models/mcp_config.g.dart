// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MCPServerConfigImpl _$$MCPServerConfigImplFromJson(
  Map<String, dynamic> json,
) => _$MCPServerConfigImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  command: json['command'] as String,
  args:
      (json['args'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  env:
      (json['env'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  enabled: json['enabled'] as bool? ?? false,
  description: json['description'] as String? ?? '',
  tools:
      (json['tools'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  status: json['status'] as String? ?? 'stopped',
);

Map<String, dynamic> _$$MCPServerConfigImplToJson(
  _$MCPServerConfigImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'command': instance.command,
  'args': instance.args,
  'env': instance.env,
  'enabled': instance.enabled,
  'description': instance.description,
  'tools': instance.tools,
  'status': instance.status,
};
