import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message.dart';
import 'ai_service.dart';

/// Anthropic (Claude) API 服务实现
class AnthropicService implements AIService {
  final String apiKey;
  final String baseUrl;
  final String model;

  AnthropicService({
    required this.apiKey,
    required this.model,
    this.baseUrl = 'https://api.anthropic.com',
  });

  @override
  String get providerId => 'anthropic';

  @override
  String get providerName => 'Anthropic';

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
      final messages = _buildMessages(history, newMessage);
      final requestBody = {
        'model': model,
        'messages': messages,
        'max_tokens': maxTokens ?? 4096,
        'stream': true,
        if (systemPrompt != null && systemPrompt.isNotEmpty) 'system': systemPrompt,
        if (temperature != null) 'temperature': temperature,
        if (topP != null) 'top_p': topP,
      };

      final request = http.Request('POST', Uri.parse('$baseUrl/v1/messages'));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01',
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
            if (data.isEmpty) continue;

            try {
              final json = jsonDecode(data);
              final type = json['type'];

              // 处理内容块增量
              if (type == 'content_block_delta') {
                final delta = json['delta'];
                if (delta?['type'] == 'text_delta') {
                  final text = delta['text'];
                  if (text != null && text is String && text.isNotEmpty) {
                    yield text;
                  }
                }
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
      final messages = _buildMessages(history, newMessage);
      final requestBody = {
        'model': model,
        'messages': messages,
        'max_tokens': maxTokens ?? 4096,
        'stream': false,
        if (systemPrompt != null && systemPrompt.isNotEmpty) 'system': systemPrompt,
        if (temperature != null) 'temperature': temperature,
        if (topP != null) 'top_p': topP,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/v1/messages'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
          'anthropic-version': '2023-06-01',
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
      final content = json['content'];
      if (content is List && content.isNotEmpty) {
        final firstBlock = content[0];
        if (firstBlock['type'] == 'text') {
          return firstBlock['text'] ?? '无响应';
        }
      }
      return '无响应';
    } catch (e) {
      if (e is AIServiceException) rethrow;
      return '抱歉，处理您的请求时遇到错误：$e';
    }
  }

  @override
  Future<bool> validateApiKey(String apiKey) async {
    try {
      // Anthropic 没有专门的验证端点，尝试发送一个最小请求
      final response = await http.post(
        Uri.parse('$baseUrl/v1/messages'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
          'anthropic-version': '2023-06-01',
        },
        body: jsonEncode({
          'model': model,
          'messages': [
            {'role': 'user', 'content': 'Hi'}
          ],
          'max_tokens': 10,
        }),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<String>> getAvailableModels() async {
    // Anthropic 不提供模型列表 API，返回已知模型
    return [
      'claude-3-5-sonnet-20241022',
      'claude-3-5-haiku-20241022',
      'claude-3-opus-20240229',
      'claude-3-sonnet-20240229',
      'claude-3-haiku-20240307',
    ];
  }

  /// 构建 Anthropic 格式的消息列表
  List<Map<String, dynamic>> _buildMessages(
    List<Message> history,
    String newMessage,
  ) {
    final messages = <Map<String, dynamic>>[];

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
