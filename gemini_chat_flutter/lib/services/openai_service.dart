import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message.dart';
import 'ai_service.dart';

/// OpenAI API 服务实现
class OpenAIService implements AIService {
  final String apiKey;
  final String baseUrl;
  final String model;

  OpenAIService({
    required this.apiKey,
    required this.model,
    this.baseUrl = 'https://api.openai.com/v1',
  });

  @override
  String get providerId => 'openai';

  @override
  String get providerName => 'OpenAI';

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
      final messages = _buildMessages(history, newMessage, systemPrompt);
      final requestBody = {
        'model': model,
        'messages': messages,
        'stream': true,
        if (temperature != null) 'temperature': temperature,
        if (topP != null) 'top_p': topP,
        if (maxTokens != null) 'max_tokens': maxTokens,
      };

      final request = http.Request('POST', Uri.parse('$baseUrl/chat/completions'));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      });
      request.body = jsonEncode(requestBody);

      final streamedResponse = await request.send();

      if (streamedResponse.statusCode != 200) {
        final errorBody = await streamedResponse.stream.bytesToString();
        throw AIServiceException(
          '请求失败: ${streamedResponse.statusCode}',
          code: streamedResponse.statusCode.toString(),
          originalError: errorBody,
        );
      }

      await for (final chunk in streamedResponse.stream.transform(utf8.decoder)) {
        final lines = chunk.split('\n');
        for (final line in lines) {
          if (line.startsWith('data: ')) {
            final data = line.substring(6).trim();
            if (data == '[DONE]') continue;
            if (data.isEmpty) continue;

            try {
              final json = jsonDecode(data);
              final delta = json['choices']?[0]?['delta'];
              final content = delta?['content'];
              if (content != null && content is String && content.isNotEmpty) {
                yield content;
              }
            } catch (e) {
              // 忽略解析错误的行
              continue;
            }
          }
        }
      }
    } catch (e) {
      if (e is AIServiceException) rethrow;
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
      final messages = _buildMessages(history, newMessage, systemPrompt);
      final requestBody = {
        'model': model,
        'messages': messages,
        'stream': false,
        if (temperature != null) 'temperature': temperature,
        if (topP != null) 'top_p': topP,
        if (maxTokens != null) 'max_tokens': maxTokens,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode != 200) {
        throw AIServiceException(
          '请求失败: ${response.statusCode}',
          code: response.statusCode.toString(),
          originalError: response.body,
        );
      }

      final json = jsonDecode(response.body);
      final content = json['choices']?[0]?['message']?['content'];
      return content ?? '无响应';
    } catch (e) {
      if (e is AIServiceException) rethrow;
      return '抱歉，处理您的请求时遇到错误：$e';
    }
  }

  @override
  Future<bool> validateApiKey(String apiKey) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/models'),
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<String>> getAvailableModels() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/models'),
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      );

      if (response.statusCode != 200) {
        throw AIServiceException('获取模型列表失败: ${response.statusCode}');
      }

      final json = jsonDecode(response.body);
      final data = json['data'] as List?;
      if (data == null) return [];

      return data
          .map((model) => model['id'] as String?)
          .where((id) => id != null && id.startsWith('gpt-'))
          .cast<String>()
          .toList();
    } catch (e) {
      if (e is AIServiceException) rethrow;
      throw AIServiceException('获取模型列表失败: $e');
    }
  }

  /// 构建 OpenAI 格式的消息列表
  List<Map<String, String>> _buildMessages(
    List<Message> history,
    String newMessage,
    String? systemPrompt,
  ) {
    final messages = <Map<String, String>>[];

    // 添加系统提示词
    if (systemPrompt != null && systemPrompt.isNotEmpty) {
      messages.add({
        'role': 'system',
        'content': systemPrompt,
      });
    }

    // 添加历史消息
    for (final msg in history) {
      messages.add({
        'role': msg.role == 'user' ? 'user' : 'assistant',
        'content': msg.text,
      });
    }

    // 添加新消息
    messages.add({
      'role': 'user',
      'content': newMessage,
    });

    return messages;
  }
}
