import 'package:flutter_test/flutter_test.dart';
import 'package:gemini_chat_flutter/services/ai_service.dart';
import 'package:gemini_chat_flutter/services/ai_service_factory.dart';
import 'package:gemini_chat_flutter/models/provider_config.dart';

void main() {
  group('AIServiceFactory', () {
    test('支持的服务商列表应包含主要服务商', () {
      final providers = AIServiceFactory.getSupportedProviders();

      expect(providers, contains('openai'));
      expect(providers, contains('anthropic'));
      expect(providers, contains('gemini'));
      expect(providers, contains('azure'));
      expect(providers, contains('groq'));
    });

    test('检查服务商是否支持', () {
      expect(AIServiceFactory.isProviderSupported('openai'), true);
      expect(AIServiceFactory.isProviderSupported('anthropic'), true);
      expect(AIServiceFactory.isProviderSupported('gemini'), true);
      expect(AIServiceFactory.isProviderSupported('unknown'), false);
    });

    test('创建服务时应验证配置', () {
      // 未启用的服务商
      final disabledConfig = ProviderConfig(
        key: 'openai',
        name: 'OpenAI',
        apiKeys: ['test-key'],
        models: ['gpt-4'],
        enabled: false,
      );

      expect(
        () => AIServiceFactory.create(providerConfig: disabledConfig),
        throwsA(isA<AIServiceException>()),
      );

      // 没有 API Key
      final noKeyConfig = ProviderConfig(
        key: 'openai',
        name: 'OpenAI',
        apiKeys: [],
        models: ['gpt-4'],
        enabled: true,
      );

      expect(
        () => AIServiceFactory.create(providerConfig: noKeyConfig),
        throwsA(isA<AIServiceException>()),
      );

      // 没有模型
      final noModelConfig = ProviderConfig(
        key: 'openai',
        name: 'OpenAI',
        apiKeys: ['test-key'],
        models: [],
        enabled: true,
      );

      expect(
        () => AIServiceFactory.create(providerConfig: noModelConfig),
        throwsA(isA<AIServiceException>()),
      );
    });

    test('createSimple 应创建服务实例', () {
      final service = AIServiceFactory.createSimple(
        providerKey: 'openai',
        apiKey: 'test-key',
        modelId: 'gpt-4',
      );

      expect(service, isNotNull);
      expect(service.providerId, 'openai');
      expect(service.providerName, 'OpenAI');
    });
  });

  group('AIServiceException', () {
    test('应正确格式化错误消息', () {
      final exception = AIServiceException('测试错误');
      expect(exception.toString(), contains('测试错误'));

      final exceptionWithCode = AIServiceException(
        '测试错误',
        code: '500',
      );
      expect(exceptionWithCode.toString(), contains('测试错误'));
      expect(exceptionWithCode.toString(), contains('500'));
    });
  });

  group('ProviderConfig', () {
    test('defaultsFor 应返回正确的默认配置', () {
      final openaiConfig = ProviderConfig.defaultsFor('openai');
      expect(openaiConfig.key, 'openai');
      expect(openaiConfig.name, 'OpenAI');
      expect(openaiConfig.baseUrl, 'https://api.openai.com/v1');

      final anthropicConfig = ProviderConfig.defaultsFor('anthropic');
      expect(anthropicConfig.key, 'anthropic');
      expect(anthropicConfig.name, 'Anthropic');
      expect(anthropicConfig.baseUrl, 'https://api.anthropic.com');

      final geminiConfig = ProviderConfig.defaultsFor('gemini');
      expect(geminiConfig.key, 'gemini');
      expect(geminiConfig.name, 'Gemini');
    });

    test('未知服务商应返回默认名称', () {
      final unknownConfig = ProviderConfig.defaultsFor('unknown');
      expect(unknownConfig.key, 'unknown');
      expect(unknownConfig.name, 'unknown');
      expect(unknownConfig.baseUrl, '');
    });
  });
}
