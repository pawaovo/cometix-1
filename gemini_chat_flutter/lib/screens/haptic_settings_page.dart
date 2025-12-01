import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart' as provider;
import '../providers/settings_provider.dart';
import '../services/haptic_service.dart';
import '../theme/app_theme.dart';

/// 触感反馈设置页面
class HapticSettingsPage extends StatefulWidget {
  final VoidCallback? onBack;

  const HapticSettingsPage({super.key, this.onBack});

  @override
  State<HapticSettingsPage> createState() => _HapticSettingsPageState();
}

class _HapticSettingsPageState extends State<HapticSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settingsProvider = provider.Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('触感反馈'),
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
                    '触感反馈可以在您与应用交互时提供触觉响应',
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

          // 启用触感反馈开关
          shadcn.Card(
            filled: true,
            fillColor: isDark ? AppTheme.gray800 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Symbols.vibration,
                  color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '启用触感反馈',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '在按钮点击和操作时提供触觉响应',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
                shadcn.Switch(
                  value: settingsProvider.hapticEnabled,
                  onChanged: (value) async {
                    await settingsProvider.setHapticEnabled(value);
                    if (value) {
                      // 立即测试触感反馈
                      final intensity = HapticIntensity.fromValue(
                        settingsProvider.hapticIntensity,
                      );
                      await intensity.perform();
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 触感强度选择
          if (settingsProvider.hapticEnabled) ...[
            Text(
              '触感强度',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? AppTheme.gray100 : AppTheme.gray900,
              ),
            ),

            const SizedBox(height: 12),

            ...HapticIntensity.values.where((i) => i != HapticIntensity.off).map(
              (intensity) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildIntensityOption(
                  intensity: intensity,
                  isSelected: settingsProvider.hapticIntensity == intensity.value,
                  isDark: isDark,
                  onTap: () async {
                    await settingsProvider.setHapticIntensity(intensity.value);
                    // 立即测试新的触感强度
                    await intensity.perform();
                  },
                ),
              ),
            ),

          ],
        ],
      ),
    );
  }

  Widget _buildIntensityOption({
    required HapticIntensity intensity,
    required bool isSelected,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: shadcn.Card(
        filled: true,
        fillColor: isSelected
            ? (isDark ? AppTheme.gray700 : AppTheme.gray100)
            : (isDark ? AppTheme.gray800 : Colors.white),
        borderRadius: BorderRadius.circular(12),
        borderColor: isSelected
            ? AppTheme.primaryColor
            : (isDark ? AppTheme.gray700 : AppTheme.gray200),
        borderWidth: isSelected ? 2 : 1,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              isSelected ? Symbols.radio_button_checked : Symbols.radio_button_unchecked,
              color: isSelected
                  ? AppTheme.primaryColor
                  : (isDark ? AppTheme.gray500 : AppTheme.gray400),
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                intensity.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                  color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
