import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart' as provider;
import '../providers/settings_provider.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';

/// TTS 语音设置页面
class TTSSettingsPage extends StatefulWidget {
  final VoidCallback? onBack;

  const TTSSettingsPage({super.key, this.onBack});

  @override
  State<TTSSettingsPage> createState() => _TTSSettingsPageState();
}

class _TTSSettingsPageState extends State<TTSSettingsPage> {
  final TTSService _tts = TTSService();
  bool _isTesting = false;

  @override
  void initState() {
    super.initState();
    _initTTS();
  }

  Future<void> _initTTS() async {
    try {
      await _tts.initialize();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('TTS 初始化失败: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settingsProvider = provider.Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('语音设置'),
        backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back),
          onPressed: widget.onBack ?? () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 说明文本
          shadcn.Card(
            filled: true,
            fillColor: isDark ? AppTheme.gray800 : AppTheme.gray100,
            borderRadius: BorderRadius.circular(12),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Symbols.info,
                  color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'TTS (Text-to-Speech) 可以将 AI 回复朗读出来',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 启用 TTS 开关
          shadcn.Card(
            filled: true,
            fillColor: isDark ? AppTheme.gray800 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Symbols.volume_up,
                  color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '启用语音朗读',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '自动朗读 AI 回复内容',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
                shadcn.Switch(
                  value: settingsProvider.ttsEnabled,
                  onChanged: (value) async {
                    await settingsProvider.setTtsEnabled(value);
                    // 立即生效，无需重启
                  },
                ),
              ],
            ),
          ),

          if (settingsProvider.ttsEnabled) ...[
            const SizedBox(height: 24),

            // 语言选择
            Text(
              '语言',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? AppTheme.gray100 : AppTheme.gray900,
              ),
            ),

            const SizedBox(height: 12),

            // 语言选择器 - 使用底表选择器（参考 kelivo）
            _buildSelectRow(
              context,
              label: '选择语言',
              value: TTSLanguage.fromCode(settingsProvider.ttsLanguage).label,
              onTap: () => _showLanguageBottomSheet(context, settingsProvider),
            ),

            const SizedBox(height: 24),

            // 语速调节
            _buildSectionHeader(context, '语速'),

            const SizedBox(height: 12),

            shadcn.Card(
              filled: true,
              fillColor: isDark ? AppTheme.gray800 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '慢',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                        ),
                      ),
                      Text(
                        '${settingsProvider.ttsSpeechRate.toStringAsFixed(2)}x',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      Text(
                        '快',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Slider(
                    value: settingsProvider.ttsSpeechRate,
                    min: 0.1,
                    max: 2.0,
                    divisions: 19,
                    activeColor: AppTheme.primaryColor,
                    inactiveColor: isDark ? AppTheme.gray700 : AppTheme.gray300,
                    onChanged: (value) async {
                      await settingsProvider.setTtsSpeechRate(value);
                      await _tts.setSpeechRate(value);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 音量调节
            _buildSectionHeader(context, '音量'),

            const SizedBox(height: 12),

            shadcn.Card(
              filled: true,
              fillColor: isDark ? AppTheme.gray800 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Symbols.volume_down,
                        size: 20,
                        color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                      ),
                      Text(
                        '${(settingsProvider.ttsVolume * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      Icon(
                        Symbols.volume_up,
                        size: 20,
                        color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Slider(
                    value: settingsProvider.ttsVolume,
                    min: 0.0,
                    max: 1.0,
                    divisions: 20,
                    activeColor: AppTheme.primaryColor,
                    inactiveColor: isDark ? AppTheme.gray700 : AppTheme.gray300,
                    onChanged: (value) async {
                      await settingsProvider.setTtsVolume(value);
                      await _tts.setVolume(value);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 音调调节
            _buildSectionHeader(context, '音调'),

            const SizedBox(height: 12),

            shadcn.Card(
              filled: true,
              fillColor: isDark ? AppTheme.gray800 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '低',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                        ),
                      ),
                      Text(
                        '${settingsProvider.ttsPitch.toStringAsFixed(2)}x',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      Text(
                        '高',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Slider(
                    value: settingsProvider.ttsPitch,
                    min: 0.5,
                    max: 2.0,
                    divisions: 30,
                    activeColor: AppTheme.primaryColor,
                    inactiveColor: isDark ? AppTheme.gray700 : AppTheme.gray300,
                    onChanged: (value) async {
                      await settingsProvider.setTtsPitch(value);
                      await _tts.setPitch(value);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 测试按钮
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isTesting
                    ? null
                    : () async {
                        setState(() => _isTesting = true);
                        try {
                          final lang = settingsProvider.ttsLanguage;
                          final testText = lang == 'zh-CN'
                              ? '你好，这是语音测试。当前语速为 ${settingsProvider.ttsSpeechRate.toStringAsFixed(1)} 倍，音调为 ${settingsProvider.ttsPitch.toStringAsFixed(1)} 倍。'
                              : 'Hello, this is a voice test. Speech rate is ${settingsProvider.ttsSpeechRate.toStringAsFixed(1)}x, pitch is ${settingsProvider.ttsPitch.toStringAsFixed(1)}x.';
                          await _tts.speak(testText);
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('测试失败: $e')),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() => _isTesting = false);
                          }
                        }
                      },
                icon: Icon(_isTesting ? Symbols.hourglass_empty : Symbols.volume_up),
                label: Text(_isTesting ? '测试中...' : '测试语音'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: AppTheme.gray900,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 停止按钮
            if (_tts.isSpeaking)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await _tts.stop();
                    setState(() => _isTesting = false);
                  },
                  icon: const Icon(Symbols.stop),
                  label: const Text('停止朗读'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? AppTheme.gray700 : AppTheme.gray200,
                    foregroundColor: isDark ? AppTheme.gray100 : AppTheme.gray900,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  /// 构建章节标题
  Widget _buildSectionHeader(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: isDark ? AppTheme.gray100 : AppTheme.gray900,
      ),
    );
  }

  /// 构建选择行（参考 kelivo 的 iOS 风格）
  Widget _buildSelectRow(
    BuildContext context, {
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return shadcn.Card(
      filled: true,
      fillColor: isDark ? AppTheme.gray800 : Colors.white,
      borderRadius: BorderRadius.circular(12),
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                  ),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Symbols.chevron_right,
                size: 18,
                color: isDark ? AppTheme.gray500 : AppTheme.gray400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 显示语言选择底表
  Future<void> _showLanguageBottomSheet(
    BuildContext context,
    SettingsProvider settingsProvider,
  ) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 拖动指示器
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.gray700 : AppTheme.gray300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // 标题
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  '选择语言',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                  ),
                ),
              ),
              // 语言选项
              ListView.separated(
                shrinkWrap: true,
                itemCount: TTSLanguage.values.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: isDark ? AppTheme.gray800 : AppTheme.gray200,
                ),
                itemBuilder: (context, index) {
                  final lang = TTSLanguage.values[index];
                  final isSelected = settingsProvider.ttsLanguage == lang.code;
                  return InkWell(
                    onTap: () => Navigator.of(ctx).pop(lang.code),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              lang.label,
                              style: TextStyle(
                                fontSize: 16,
                                color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Symbols.check,
                              size: 20,
                              color: AppTheme.primaryColor,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );

    // 应用选择的语言
    if (result != null && mounted) {
      await settingsProvider.setTtsLanguage(result);
      await _tts.setLanguage(result);
    }
  }

  @override
  void dispose() {
    // 不要 dispose TTSService，因为它是单例
    super.dispose();
  }
}
