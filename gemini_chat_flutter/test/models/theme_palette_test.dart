import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gemini_chat_flutter/models/theme_palette.dart';

void main() {
  group('ThemePalette', () {
    test('预设色板应包含至少 10 个', () {
      expect(ThemePalette.presets.length, greaterThanOrEqualTo(10));
    });

    test('预设色板应包含默认色板', () {
      final defaultPalette = ThemePalette.presets.firstWhere(
        (p) => p.id == 'default',
      );

      expect(defaultPalette.name, '默认');
      expect(defaultPalette.isCustom, false);
    });

    test('getPresetById 应正确查找色板', () {
      final bluePalette = ThemePalette.getPresetById('blue');
      expect(bluePalette, isNotNull);
      expect(bluePalette!.id, 'blue');
      expect(bluePalette.name, '海洋蓝');

      final unknownPalette = ThemePalette.getPresetById('unknown');
      expect(unknownPalette, isNull);
    });

    test('custom 应创建自定义色板', () {
      final customPalette = ThemePalette.custom(
        name: '我的色板',
        primaryColor: Colors.red,
        accentColor: Colors.blue,
      );

      expect(customPalette.name, '我的色板');
      expect(customPalette.isCustom, true);
      expect(customPalette.id, startsWith('custom_'));
    });

    test('所有预设色板应有唯一 ID', () {
      final ids = ThemePalette.presets.map((p) => p.id).toSet();
      expect(ids.length, ThemePalette.presets.length);
    });

    test('所有预设色板应有有效的颜色值', () {
      for (final palette in ThemePalette.presets) {
        expect(palette.primaryColor, isNonZero);
        expect(palette.accentColor, isNonZero);
      }
    });
  });

  group('ThemePaletteExtension', () {
    test('primary 应返回正确的 Color 对象', () {
      const palette = ThemePalette(
        id: 'test',
        name: 'Test',
        primaryColor: 0xFFFF0000,
        accentColor: 0xFF0000FF,
      );

      expect(palette.primary, const Color(0xFFFF0000));
      expect(palette.accent, const Color(0xFF0000FF));
    });

    test('toLightColorScheme 应生成浅色主题', () {
      const palette = ThemePalette(
        id: 'test',
        name: 'Test',
        primaryColor: 0xFFFF0000,
        accentColor: 0xFF0000FF,
      );

      final colorScheme = palette.toLightColorScheme();

      expect(colorScheme.brightness, Brightness.light);
      expect(colorScheme.primary, const Color(0xFFFF0000));
      expect(colorScheme.secondary, const Color(0xFF0000FF));
      expect(colorScheme.surface, Colors.white);
    });

    test('toDarkColorScheme 应生成深色主题', () {
      const palette = ThemePalette(
        id: 'test',
        name: 'Test',
        primaryColor: 0xFFFF0000,
        accentColor: 0xFF0000FF,
      );

      final colorScheme = palette.toDarkColorScheme();

      expect(colorScheme.brightness, Brightness.dark);
      expect(colorScheme.primary, const Color(0xFFFF0000));
      expect(colorScheme.secondary, const Color(0xFF0000FF));
      expect(colorScheme.surface, const Color(0xFF121212));
    });
  });
}
