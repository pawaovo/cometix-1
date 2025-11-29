import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider_config.freezed.dart';
part 'provider_config.g.dart';

/// 服务商配置
@freezed
class ProviderConfig with _$ProviderConfig {
  const factory ProviderConfig({
    required String key, // 服务商唯一标识（如 'openai', 'anthropic'）
    required String name, // 显示名称
    @Default([]) List<String> apiKeys, // API Keys 列表
    @Default('') String baseUrl, // 自定义 Base URL
    @Default([]) List<String> models, // 可用模型列表
    @Default({}) Map<String, dynamic> modelOverrides, // 模型覆盖配置
    @Default(true) bool enabled, // 是否启用
    @Default(0) int selectedKeyIndex, // 当前使用的 Key 索引
  }) = _ProviderConfig;

  factory ProviderConfig.fromJson(Map<String, dynamic> json) =>
      _$ProviderConfigFromJson(json);

  /// 为指定 key 创建默认配置
  static ProviderConfig defaultsFor(String key, {String? displayName}) {
    return ProviderConfig(
      key: key,
      name: displayName ?? _getDefaultName(key),
      apiKeys: [],
      baseUrl: _getDefaultBaseUrl(key),
      models: [],
      enabled: true,
    );
  }

  static String _getDefaultName(String key) {
    const names = {
      'openai': 'OpenAI',
      'anthropic': 'Anthropic',
      'google': 'Google',
      'gemini': 'Gemini',
      'azure': 'Azure OpenAI',
      'cohere': 'Cohere',
      'mistral': 'Mistral AI',
      'groq': 'Groq',
      'together': 'Together AI',
      'deepseek': 'DeepSeek',
      'moonshot': 'Moonshot AI',
      'zhipu': 'Zhipu AI',
      'baichuan': 'Baichuan AI',
      'minimax': 'MiniMax',
      'doubao': 'Doubao',
    };
    return names[key] ?? key;
  }

  static String _getDefaultBaseUrl(String key) {
    const urls = {
      'openai': 'https://api.openai.com/v1',
      'anthropic': 'https://api.anthropic.com',
      'google': 'https://generativelanguage.googleapis.com/v1beta',
      'gemini': 'https://generativelanguage.googleapis.com/v1beta',
      'groq': 'https://api.groq.com/openai/v1',
      'together': 'https://api.together.xyz/v1',
      'deepseek': 'https://api.deepseek.com/v1',
      'moonshot': 'https://api.moonshot.cn/v1',
      'zhipu': 'https://open.bigmodel.cn/api/paas/v4',
    };
    return urls[key] ?? '';
  }
}
