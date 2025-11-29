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
  }) = _Assistant;

  factory Assistant.fromJson(Map<String, dynamic> json) => _$AssistantFromJson(json);
}
