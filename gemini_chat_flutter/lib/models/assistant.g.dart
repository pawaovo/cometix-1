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
      modelProvider: json['modelProvider'] as String?,
      modelId: json['modelId'] as String?,
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.7,
      topP: (json['topP'] as num?)?.toDouble() ?? 1.0,
      contextMessageCount: (json['contextMessageCount'] as num?)?.toInt() ?? 10,
      streamOutput: json['streamOutput'] as bool? ?? true,
    );

Map<String, dynamic> _$$AssistantImplToJson(_$AssistantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'systemPrompt': instance.systemPrompt,
      'enabled': instance.enabled,
      'modelProvider': instance.modelProvider,
      'modelId': instance.modelId,
      'temperature': instance.temperature,
      'topP': instance.topP,
      'contextMessageCount': instance.contextMessageCount,
      'streamOutput': instance.streamOutput,
    };
