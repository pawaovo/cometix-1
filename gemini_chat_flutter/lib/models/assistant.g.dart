// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssistantImpl _$$AssistantImplFromJson(Map<String, dynamic> json) =>
    _$AssistantImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      description: json['description'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.7,
      topP: (json['topP'] as num?)?.toDouble() ?? 0.95,
      contextMessageCount: (json['contextMessageCount'] as num?)?.toInt() ?? 10,
      thinkingBudget: (json['thinkingBudget'] as num?)?.toInt(),
      maxOutputTokens: json['maxOutputTokens'] ?? 'unlimited',
      useAvatar: json['useAvatar'] as bool? ?? true,
      streamOutput: json['streamOutput'] as bool? ?? true,
      chatModel: json['chatModel'] as String? ?? 'gemini-2.0-flash-exp',
      systemPrompt: json['systemPrompt'] as String? ?? '',
      enableMemory: json['enableMemory'] as bool? ?? false,
      enableHistoryReference: json['enableHistoryReference'] as bool? ?? false,
      memories:
          (json['memories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      quickPhrases:
          (json['quickPhrases'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AssistantImplToJson(_$AssistantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'description': instance.description,
      'isDefault': instance.isDefault,
      'temperature': instance.temperature,
      'topP': instance.topP,
      'contextMessageCount': instance.contextMessageCount,
      'thinkingBudget': instance.thinkingBudget,
      'maxOutputTokens': instance.maxOutputTokens,
      'useAvatar': instance.useAvatar,
      'streamOutput': instance.streamOutput,
      'chatModel': instance.chatModel,
      'systemPrompt': instance.systemPrompt,
      'enableMemory': instance.enableMemory,
      'enableHistoryReference': instance.enableHistoryReference,
      'memories': instance.memories,
      'quickPhrases': instance.quickPhrases,
    };
