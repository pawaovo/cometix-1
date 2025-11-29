import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_widgets.dart';

/// 默认模型设置页面
class DefaultModelPage extends StatelessWidget {
  final VoidCallback onBack;

  const DefaultModelPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = provider.Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '默认模型', onBack: onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 对话模型
                  _ModelCard(
                    icon: Symbols.chat,
                    title: '对话模型',
                    subtitle: '用于日常对话的默认模型',
                    modelProvider: settings.currentModelProvider,
                    modelId: settings.currentModelId,
                    onReset: () => settings.resetCurrentModel(),
                    onPick: () => _showModelPicker(context, settings, 'current'),
                  ),
                  const SizedBox(height: 16),

                  // 标题生成模型
                  _ModelCard(
                    icon: Symbols.title,
                    title: '标题生成模型',
                    subtitle: '用于自动生成对话标题',
                    modelProvider: settings.titleModelProvider,
                    modelId: settings.titleModelId,
                    fallbackProvider: settings.currentModelProvider,
                    fallbackModelId: settings.currentModelId,
                    onReset: () => settings.resetTitleModel(),
                    onPick: () => _showModelPicker(context, settings, 'title'),
                    onConfig: () => _showPromptDialog(
                      context,
                      settings,
                      'title',
                      '标题生成提示词',
                      settings.titlePrompt,
                      '请为以下对话生成一个简短的标题...',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // OCR 模型
                  _ModelCard(
                    icon: Symbols.image_search,
                    title: 'OCR 模型',
                    subtitle: '用于图片文字识别',
                    modelProvider: settings.ocrModelProvider,
                    modelId: settings.ocrModelId,
                    fallbackProvider: settings.currentModelProvider,
                    fallbackModelId: settings.currentModelId,
                    onReset: () => settings.resetOcrModel(),
                    onPick: () => _showModelPicker(context, settings, 'ocr'),
                    onConfig: () => _showPromptDialog(
                      context,
                      settings,
                      'ocr',
                      'OCR 提示词',
                      settings.ocrPrompt,
                      '请识别图片中的文字内容...',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 翻译模型
                  _ModelCard(
                    icon: Symbols.translate,
                    title: '翻译模型',
                    subtitle: '用于文本翻译',
                    modelProvider: settings.translateModelProvider,
                    modelId: settings.translateModelId,
                    fallbackProvider: settings.currentModelProvider,
                    fallbackModelId: settings.currentModelId,
                    onReset: () => settings.resetTranslateModel(),
                    onPick: () => _showModelPicker(context, settings, 'translate'),
                    onConfig: () => _showPromptDialog(
                      context,
                      settings,
                      'translate',
                      '翻译提示词',
                      settings.translatePrompt,
                      '请将以下文本翻译成...',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 显示模型选择器（简化版，实际应该显示所有可用模型）
  void _showModelPicker(BuildContext context, SettingsProvider settings, String type) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('选择模型'),
        content: const Text('模型选择功能待实现\n需要从服务商配置中获取可用模型列表'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  // 显示 Prompt 编辑对话框
  void _showPromptDialog(
    BuildContext context,
    SettingsProvider settings,
    String type,
    String title,
    String currentPrompt,
    String hint,
  ) {
    final controller = TextEditingController(text: currentPrompt);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: controller,
            maxLines: 8,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // 重置为默认值
              switch (type) {
                case 'title':
                  settings.resetTitlePrompt();
                  break;
                case 'ocr':
                  settings.resetOcrPrompt();
                  break;
                case 'translate':
                  settings.resetTranslatePrompt();
                  break;
              }
              Navigator.pop(ctx);
            },
            child: const Text('重置'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              // 保存
              final newPrompt = controller.text.trim();
              if (newPrompt.isNotEmpty) {
                switch (type) {
                  case 'title':
                    settings.setTitlePrompt(newPrompt);
                    break;
                  case 'ocr':
                    settings.setOcrPrompt(newPrompt);
                    break;
                  case 'translate':
                    settings.setTranslatePrompt(newPrompt);
                    break;
                }
              }
              Navigator.pop(ctx);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
}

/// 模型卡片组件
class _ModelCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? modelProvider;
  final String? modelId;
  final String? fallbackProvider;
  final String? fallbackModelId;
  final VoidCallback onReset;
  final VoidCallback onPick;
  final VoidCallback? onConfig;

  const _ModelCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.modelProvider,
    required this.modelId,
    this.fallbackProvider,
    this.fallbackModelId,
    required this.onReset,
    required this.onPick,
    this.onConfig,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final usingFallback = modelProvider == null || modelId == null;
    final effectiveModelId = modelId ?? fallbackModelId;

    String displayText;
    if (usingFallback) {
      displayText = '使用对话模型';
    } else {
      displayText = effectiveModelId ?? '未设置';
    }

    return shadcn.Card(
      filled: true,
      fillColor: isDark ? AppTheme.gray900.withValues(alpha: 0.3) : Colors.white,
      borderRadius: BorderRadius.circular(16),
      borderColor: isDark ? AppTheme.gray800 : AppTheme.gray200,
      borderWidth: 1,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题行
          Row(
            children: [
              Icon(icon, size: 20, color: isDark ? AppTheme.gray100 : AppTheme.gray900),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                  ),
                ),
              ),
              if (!usingFallback)
                IconButton(
                  icon: const Icon(Symbols.refresh, size: 18),
                  onPressed: onReset,
                  tooltip: '重置',
                ),
              if (onConfig != null)
                IconButton(
                  icon: const Icon(Symbols.settings, size: 18),
                  onPressed: onConfig,
                  tooltip: '配置',
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppTheme.gray400 : AppTheme.gray600,
            ),
          ),
          const SizedBox(height: 12),

          // 模型选择按钮
          InkWell(
            onTap: onPick,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.gray800.withValues(alpha: 0.5) : AppTheme.gray100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        displayText.isNotEmpty ? displayText[0].toUpperCase() : '?',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      displayText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                      ),
                    ),
                  ),
                  Icon(
                    Symbols.chevron_right,
                    size: 18,
                    color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
