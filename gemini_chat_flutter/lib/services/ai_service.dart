import '../models/message.dart';

/// AI 服务统一接口
/// 所有 AI 服务商（OpenAI、Anthropic、Gemini 等）都需要实现此接口
abstract class AIService {
  /// 服务商标识（如 'openai', 'anthropic', 'gemini'）
  String get providerId;

  /// 服务商显示名称
  String get providerName;

  /// 流式发送消息
  ///
  /// [history] 历史消息列表
  /// [newMessage] 新消息内容
  /// [systemPrompt] 系统提示词（可选）
  /// [temperature] 温度参数（0.0-2.0）
  /// [topP] Top-P 参数（0.0-1.0）
  /// [maxTokens] 最大 token 数（可选）
  ///
  /// 返回流式响应的 Stream
  Stream<String> sendMessageStream({
    required List<Message> history,
    required String newMessage,
    String? systemPrompt,
    double? temperature,
    double? topP,
    int? maxTokens,
  });

  /// 非流式发送消息
  ///
  /// 参数同 [sendMessageStream]
  /// 返回完整响应文本
  Future<String> sendMessage({
    required List<Message> history,
    required String newMessage,
    String? systemPrompt,
    double? temperature,
    double? topP,
    int? maxTokens,
  });

  /// 验证 API Key 是否有效
  Future<bool> validateApiKey(String apiKey);

  /// 获取可用模型列表
  Future<List<String>> getAvailableModels();
}

/// AI 服务异常
class AIServiceException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  AIServiceException(this.message, {this.code, this.originalError});

  @override
  String toString() => 'AIServiceException: $message${code != null ? ' (code: $code)' : ''}';
}
