import 'package:freezed_annotation/freezed_annotation.dart';

part 'assistant.freezed.dart';
part 'assistant.g.dart';

@freezed
class Assistant with _$Assistant {
  const factory Assistant({
    required String id,
    required String name,
    String? description,
    @Default('') String systemPrompt,
    @Default(true) bool enabled,

    // 模型配置
    String? modelProvider,
    String? modelId,

    // 参数配置
    @Default(0.7) double temperature,
    @Default(1.0) double topP,
    @Default(10) int contextMessageCount,

    // 输出配置
    @Default(true) bool streamOutput,

    // 记忆配置
    @Default(false) bool enableMemory,
    @Default(false) bool useHistoryChat,
    @Default([]) List<String> memories,

    // 助手专属快捷短语
    @Default([]) List<String> quickPhrases,
  }) = _Assistant;

  factory Assistant.fromJson(Map<String, dynamic> json) => _$AssistantFromJson(json);
}
