import 'package:freezed_annotation/freezed_annotation.dart';

part 'assistant.freezed.dart';
part 'assistant.g.dart';

@freezed
class Assistant with _$Assistant {
  const factory Assistant({
    required String id,
    required String name,
    required String avatar, // letter
    String? description,
    @Default(false) bool isDefault,

    // Basic Settings
    @Default(0.7) double temperature,
    @Default(0.95) double topP,
    @Default(10) int contextMessageCount,
    int? thinkingBudget,
    @Default('unlimited') dynamic maxOutputTokens, // 'unlimited' or number
    @Default(true) bool useAvatar,
    @Default(true) bool streamOutput,
    @Default('gemini-2.0-flash-exp') String chatModel,

    // Prompt Settings
    @Default('') String systemPrompt,

    // Memory Settings
    @Default(false) bool enableMemory,
    @Default(false) bool enableHistoryReference,
    @Default([]) List<String> memories,

    // Quick Phrases
    @Default([]) List<String> quickPhrases,
  }) = _Assistant;

  factory Assistant.fromJson(Map<String, dynamic> json) => _$AssistantFromJson(json);
}
