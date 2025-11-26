import 'package:freezed_annotation/freezed_annotation.dart';

part 'quick_phrase.freezed.dart';
part 'quick_phrase.g.dart';

@freezed
class QuickPhrase with _$QuickPhrase {
  const factory QuickPhrase({
    required String id,
    required String phrase,
    required String shortcut,
  }) = _QuickPhrase;

  factory QuickPhrase.fromJson(Map<String, dynamic> json) => _$QuickPhraseFromJson(json);
}
