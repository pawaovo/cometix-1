// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssistantImpl _$$AssistantImplFromJson(Map<String, dynamic> json) =>
    _$AssistantImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      systemPrompt: json['systemPrompt'] as String? ?? '',
      enabled: json['enabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$AssistantImplToJson(_$AssistantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'systemPrompt': instance.systemPrompt,
      'enabled': instance.enabled,
    };
