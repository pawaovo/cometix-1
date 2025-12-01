import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart' as provider;
import '../models/theme_palette.dart';
import '../providers/settings_provider.dart';
import '../theme/app_theme.dart';

/// 主题色板选择页面
class ThemePalettePage extends StatefulWidget {
  final VoidCallback? onBack;

  const ThemePalettePage({super.key, this.onBack});

  @override
  State<ThemePalettePage> createState() => _ThemePalettePageState();
}

class _ThemePalettePageState extends State<ThemePalettePage> {
  late String _selectedPaletteId;

  @override
  void initState() {
    super.initState();
    final settingsProvider = provider.Provider.of<SettingsProvider>(
      context,
      listen: false,
    );
    _selectedPaletteId = settingsProvider.themePaletteId;
  }

  void _selectPalette(String paletteId) {
    setState(() {
      _selectedPaletteId = paletteId;
    });

    final settingsProvider = provider.Provider.of<SettingsProvider>(
      context,
      listen: false,
    );
    settingsProvider.setThemePalette(paletteId);

    // 立即应用主题（通过重建 MaterialApp）
    // 注意：完整的主题切换需要在 main.dart 中监听 themePaletteId
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('主题色板'),
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
                    '选择您喜欢的主题色板，立即生效',
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

          // 预设色板列表
          ...ThemePalette.presets.map((palette) {
            final isSelected = _selectedPaletteId == palette.id;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildPaletteCard(
                palette: palette,
                isSelected: isSelected,
                isDark: isDark,
                onTap: () => _selectPalette(palette.id),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPaletteCard({
    required ThemePalette palette,
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
            ? palette.primary
            : (isDark ? AppTheme.gray700 : AppTheme.gray200),
        borderWidth: isSelected ? 2 : 1,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 圆形色板预览
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: palette.primary,
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(width: 16),

            // 色板名称
            Expanded(
              child: Text(
                palette.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                ),
              ),
            ),

            // 选中标记
            if (isSelected)
              Icon(
                Symbols.check_circle,
                size: 24,
                color: palette.primary,
              ),
          ],
        ),
      ),
    );
  }
}
