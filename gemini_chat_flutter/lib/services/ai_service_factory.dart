import '../models/provider_config.dart';
import 'ai_service.dart';
import 'openai_service.dart';
import 'anthropic_service.dart';
import 'gemini_service.dart';

/// AI 服务工厂
/// 根据服务商配置动态创建对应的 AI 服务实例
class AIServiceFactory {
  /// 创建 AI 服务实例
  ///
  /// [providerConfig] 服务商配置
  /// [modelId] 模型 ID（可选，使用配置中的第一个模型）
  ///
  /// 返回对应的 AI 服务实例
  /// 如果配置无效或不支持该服务商，抛出 [AIServiceException]
  static AIService create({
    required ProviderConfig providerConfig,
    String? modelId,
  }) {
    // 验证配置
    if (!providerConfig.enabled) {
      throw AIServiceException('服务商 ${providerConfig.name} 未启用');
    }

    if (providerConfig.apiKeys.isEmpty) {
      throw AIServiceException('服务商 ${providerConfig.name} 未配置 API Key');
    }

    // 获取当前使用的 API Key
    final apiKey = providerConfig.apiKeys[providerConfig.selectedKeyIndex];
    if (apiKey.isEmpty) {
      throw AIServiceException('服务商 ${providerConfig.name} 的 API Key 为空');
    }

    // 获取模型 ID
    final model = modelId ??
        (providerConfig.models.isNotEmpty ? providerConfig.models.first : null);

    if (model == null || model.isEmpty) {
      throw AIServiceException('服务商 ${providerConfig.name} 未配置模型');
    }

    // 根据服务商类型创建对应的服务实例
    switch (providerConfig.key.toLowerCase()) {
      case 'openai':
        return OpenAIService(
          apiKey: apiKey,
          model: model,
          baseUrl: providerConfig.baseUrl.isNotEmpty
              ? providerConfig.baseUrl
              : 'https://api.openai.com/v1',
        );

      case 'anthropic':
      case 'claude':
        return AnthropicService(
          apiKey: apiKey,
          model: model,
          baseUrl: providerConfig.baseUrl.isNotEmpty
              ? providerConfig.baseUrl
              : 'https://api.anthropic.com',
        );

      case 'gemini':
      case 'google':
        return GeminiService(
          apiKey: apiKey,
          model: model,
        );

      case 'azure':
        // Azure OpenAI 使用 OpenAI 兼容接口
        if (providerConfig.baseUrl.isEmpty) {
          throw AIServiceException('Azure OpenAI 需要配置 Base URL');
        }
        return OpenAIService(
          apiKey: apiKey,
          model: model,
          baseUrl: providerConfig.baseUrl,
        );

      case 'groq':
      case 'together':
      case 'deepseek':
      case 'moonshot':
      case 'zhipu':
        // 这些服务商使用 OpenAI 兼容接口
        return OpenAIService(
          apiKey: apiKey,
          model: model,
          baseUrl: providerConfig.baseUrl.isNotEmpty
              ? providerConfig.baseUrl
              : ProviderConfig.defaultsFor(providerConfig.key).baseUrl,
        );

      default:
        throw AIServiceException('不支持的服务商: ${providerConfig.key}');
    }
  }

  /// 根据服务商 key 和模型 ID 创建服务
  ///
  /// [providerKey] 服务商标识（如 'openai', 'anthropic'）
  /// [apiKey] API Key
  /// [modelId] 模型 ID
  /// [baseUrl] 自定义 Base URL（可选）
  static AIService createSimple({
    required String providerKey,
    required String apiKey,
    required String modelId,
    String? baseUrl,
  }) {
    final config = ProviderConfig(
      key: providerKey,
      name: providerKey,
      apiKeys: [apiKey],
      baseUrl: baseUrl ?? '',
      models: [modelId],
      enabled: true,
    );

    return create(providerConfig: config, modelId: modelId);
  }

  /// 获取支持的服务商列表
  static List<String> getSupportedProviders() {
    return [
      'openai',
      'anthropic',
      'gemini',
      'azure',
      'groq',
      'together',
      'deepseek',
      'moonshot',
      'zhipu',
    ];
  }

  /// 检查服务商是否支持
  static bool isProviderSupported(String providerKey) {
    return getSupportedProviders().contains(providerKey.toLowerCase());
  }
}
