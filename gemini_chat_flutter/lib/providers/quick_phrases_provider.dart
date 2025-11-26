import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quick_phrase.dart';

final quickPhrasesProvider = StateNotifierProvider<QuickPhrasesNotifier, List<QuickPhrase>>((ref) {
  return QuickPhrasesNotifier();
});

class QuickPhrasesNotifier extends StateNotifier<List<QuickPhrase>> {
  QuickPhrasesNotifier() : super(_initialQuickPhrases);

  static final List<QuickPhrase> _initialQuickPhrases = [
    const QuickPhrase(id: '1', phrase: '请帮我总结一下这段内容', shortcut: '总结'),
    const QuickPhrase(id: '2', phrase: '请把这段内容翻译成英文', shortcut: '翻译'),
    const QuickPhrase(id: '3', phrase: '请解释一下这段代码', shortcut: '解释'),
    const QuickPhrase(id: '4', phrase: '湖南省常德市', shortcut: '地址'),
  ];

  void addPhrase(QuickPhrase phrase) {
    state = [...state, phrase];
  }

  void updatePhrase(QuickPhrase phrase) {
    state = [
      for (final p in state)
        if (p.id == phrase.id) phrase else p,
    ];
  }

  void deletePhrase(String id) {
    state = state.where((p) => p.id != id).toList();
  }
}
