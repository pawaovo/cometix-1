import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/message.dart';
import 'ai_service.dart';

/// Gemini API 服务实现
class GeminiService implements AIService {
  final String apiKey;
  final String model;

  GeminiService({
    required this.apiKey,
    this.model = 'gemini-2.0-flash-exp',
  });

  @override
  String get providerId => 'gemini';

  @override
  String get providerName => 'Gemini';

  @override
  Stream<String> sendMessageStream({
    required List<Message> history,
    required String newMessage,
    String? systemPrompt,
    double? temperature,
    double? topP,
    int? maxTokens,
  }) async* {
    try {
      // 创建带配置的模型实例
      final configuredModel = GenerativeModel(
        model: model,
        apiKey: apiKey,
        systemInstruction: systemPrompt != null && systemPrompt.isNotEmpty
            ? Content.text(systemPrompt)
            : null,
        generationConfig: GenerationConfig(
          temperature: temperature,
          topP: topP,
          maxOutputTokens: maxTokens,
        ),
      );

      // 转换历史消息为 Gemini 格式
      final chatHistory = history.map((msg) {
        return Content(
          msg.role == 'user' ? 'user' : 'model',
          [TextPart(msg.text)],
        );
      }).toList();

      // 创建聊天会话
      final chat = configuredModel.startChat(history: chatHistory);

      // 发送消息并流式返回
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
      if (e is GenerativeAIException) {
        throw AIServiceException(
          '请求失败: ${e.message}',
          originalError: e,
        );
      }
      yield '抱歉，处理您的请求时遇到错误：$e';
    }
  }

  @override
  Future<String> sendMessage({
    required List<Message> history,
    required String newMessage,
    String? systemPrompt,
    double? temperature,
    double? topP,
    int? maxTokens,
  }) async {
    try {
      // 创建带配置的模型实例
      final configuredModel = GenerativeModel(
        model: model,
        apiKey: apiKey,
        systemInstruction: systemPrompt != null && systemPrompt.isNotEmpty
            ? Content.text(systemPrompt)
            : null,
        generationConfig: GenerationConfig(
          temperature: temperature,
          topP: topP,
          maxOutputTokens: maxTokens,
        ),
      );

      final chatHistory = history.map((msg) {
        return Content(
          msg.role == 'user' ? 'user' : 'model',
          [TextPart(msg.text)],
        );
      }).toList();

      final chat = configuredModel.startChat(history: chatHistory);
      final response = await chat.sendMessage(Content.text(newMessage));

      return response.text ?? '无响应';
    } catch (e) {
      if (e is GenerativeAIException) {
        throw AIServiceException(
          '请求失败: ${e.message}',
          originalError: e,
        );
      }
      return '抱歉，处理您的请求时遇到错误：$e';
    }
  }

  @override
  Future<bool> validateApiKey(String apiKey) async {
    try {
      final testModel = GenerativeModel(
        model: 'gemini-pro',
        apiKey: apiKey,
      );
      await testModel.generateContent([Content.text('Hi')]);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<String>> getAvailableModels() async {
    // Gemini 不提供模型列表 API，返回已知模型
    return [
      'gemini-2.0-flash-exp',
      'gemini-1.5-pro',
      'gemini-1.5-flash',
      'gemini-pro',
    ];
  }
}
