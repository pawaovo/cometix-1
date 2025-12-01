import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart' as provider_pkg;
import '../services/ai_service.dart';
import '../services/ai_service_factory.dart';
import '../services/gemini_service.dart';
import '../models/provider_config.dart';
import '../providers/settings_provider.dart';

/// AI 服务 Provider
/// 根据用户设置动态创建对应的 AI 服务实例
final aiServiceProvider = Provider<AIService>((ref) {
  // 尝试从 SettingsProvider 获取当前模型配置
  try {
    // 注意：这里需要通过 context 获取 SettingsProvider
    // 由于 Riverpod 和 Provider 混用，需要特殊处理
    // 暂时使用默认的 Gemini 服务
    final apiKey = dotenv.env['API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      throw AIServiceException('未配置 API Key，请在 .env 文件中设置 API_KEY');
    }

    return GeminiService(apiKey: apiKey);
  } catch (e) {
    throw AIServiceException('创建 AI 服务失败: $e');
  }
});

/// 根据服务商配置创建 AI 服务的 Provider Family
///
/// 使用方式：
/// ```dart
/// final service = ref.watch(aiServiceFromConfigProvider(providerConfig));
/// ```
final aiServiceFromConfigProvider = Provider.family<AIService, ProviderConfig>(
  (ref, config) {
    return AIServiceFactory.create(providerConfig: config);
  },
);

/// 当前选中的 AI 服务 Provider
///
/// 这个 Provider 会根据 SettingsProvider 中的当前模型配置
/// 动态创建对应的 AI 服务实例
class CurrentAIServiceNotifier extends StateNotifier<AIService?> {
  final SettingsProvider settingsProvider;

  CurrentAIServiceNotifier(this.settingsProvider) : super(null) {
    _initialize();
  }

  void _initialize() {
    try {
      // 获取当前选中的服务商和模型
      final providerKey = settingsProvider.currentModelProvider;
      final modelId = settingsProvider.currentModelId;

      if (providerKey == null || modelId == null) {
        // 如果没有配置，使用默认的 Gemini
        final apiKey = dotenv.env['API_KEY'] ?? '';
        if (apiKey.isNotEmpty) {
          state = GeminiService(apiKey: apiKey);
        }
        return;
      }

      // 获取服务商配置
      final config = settingsProvider.getProviderConfig(providerKey);

      // 创建服务实例
      state = AIServiceFactory.create(
        providerConfig: config,
        modelId: modelId,
      );
    } catch (e) {
      // 初始化失败，使用默认服务
      final apiKey = dotenv.env['API_KEY'] ?? '';
      if (apiKey.isNotEmpty) {
        state = GeminiService(apiKey: apiKey);
      }
    }
  }

  /// 切换到指定的服务商和模型
  void switchService(String providerKey, String modelId) {
    try {
      final config = settingsProvider.getProviderConfig(providerKey);
      state = AIServiceFactory.create(
        providerConfig: config,
        modelId: modelId,
      );
    } catch (e) {
      throw AIServiceException('切换服务失败: $e');
    }
  }

  /// 刷新当前服务（重新创建实例）
  void refresh() {
    _initialize();
  }
}

/// 创建 CurrentAIServiceNotifier 的辅助函数
///
/// 由于需要访问 SettingsProvider（使用 Provider 包），
/// 这个函数需要在 Widget 中通过 context 调用
CurrentAIServiceNotifier createCurrentAIServiceNotifier(
  BuildContext context,
) {
  final settingsProvider = provider_pkg.Provider.of<SettingsProvider>(
    context,
    listen: false,
  );
  return CurrentAIServiceNotifier(settingsProvider);
}
