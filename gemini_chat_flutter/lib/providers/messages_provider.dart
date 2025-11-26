import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/message.dart';

final messagesProvider = StateNotifierProvider<MessagesNotifier, List<Message>>((ref) {
  return MessagesNotifier();
});

class MessagesNotifier extends StateNotifier<List<Message>> {
  MessagesNotifier() : super([]);

  void addMessage(Message message) {
    state = [...state, message];
  }

  void updateLastMessage(String text) {
    if (state.isEmpty) return;

    final updatedMessages = [...state];
    final lastIndex = updatedMessages.length - 1;
    updatedMessages[lastIndex] = Message(
      role: updatedMessages[lastIndex].role,
      text: text,
    );
    state = updatedMessages;
  }

  void clearMessages() {
    state = [];
  }
}
