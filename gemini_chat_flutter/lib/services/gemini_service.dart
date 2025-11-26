import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/message.dart';

class GeminiService {
  final String apiKey;
  late final GenerativeModel _model;

  GeminiService({required this.apiKey}) {
    _model = GenerativeModel(
      model: 'gemini-2.0-flash-exp',
      apiKey: apiKey,
    );
  }

  Stream<String> sendMessageStream({
    required List<Message> history,
    required String newMessage,
  }) async* {
    try {
      // Convert history to Gemini format
      final chatHistory = history.map((msg) {
        return Content(
          msg.role == 'user' ? 'user' : 'model',
          [TextPart(msg.text)],
        );
      }).toList();

      // Create chat session with history
      final chat = _model.startChat(history: chatHistory);

      // Send message and stream response
      final response = chat.sendMessageStream(
        Content.text(newMessage),
      );

      await for (final chunk in response) {
        final text = chunk.text;
        if (text != null && text.isNotEmpty) {
          yield text;
        }
      }
    } catch (e) {
      yield '抱歉，处理您的请求时遇到错误：$e';
    }
  }

  Future<String> sendMessage({
    required List<Message> history,
    required String newMessage,
  }) async {
    try {
      final chatHistory = history.map((msg) {
        return Content(
          msg.role == 'user' ? 'user' : 'model',
          [TextPart(msg.text)],
        );
      }).toList();

      final chat = _model.startChat(history: chatHistory);
      final response = await chat.sendMessage(Content.text(newMessage));

      return response.text ?? '无响应';
    } catch (e) {
      return '抱歉，处理您的请求时遇到错误：$e';
    }
  }
}
