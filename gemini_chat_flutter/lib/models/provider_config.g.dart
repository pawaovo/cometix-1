// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProviderConfigImpl _$$ProviderConfigImplFromJson(
  Map<String, dynamic> json,
) => _$ProviderConfigImpl(
  key: json['key'] as String,
  name: json['name'] as String,
  apiKeys:
      (json['apiKeys'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  baseUrl: json['baseUrl'] as String? ?? '',
  models:
      (json['models'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  modelOverrides: json['modelOverrides'] as Map<String, dynamic>? ?? const {},
  enabled: json['enabled'] as bool? ?? true,
  selectedKeyIndex: (json['selectedKeyIndex'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$ProviderConfigImplToJson(
  _$ProviderConfigImpl instance,
) => <String, dynamic>{
  'key': instance.key,
  'name': instance.name,
  'apiKeys': instance.apiKeys,
  'baseUrl': instance.baseUrl,
  'models': instance.models,
  'modelOverrides': instance.modelOverrides,
  'enabled': instance.enabled,
  'selectedKeyIndex': instance.selectedKeyIndex,
};
