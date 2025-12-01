import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_palette.freezed.dart';
part 'theme_palette.g.dart';

/// 主题色板
@freezed
class ThemePalette with _$ThemePalette {
  const factory ThemePalette({
    required String id, // 色板唯一标识
    required String name, // 色板名称
    required int primaryColor, // 主色（存储为 int，方便序列化）
    required int accentColor, // 强调色
    @Default(false) bool isCustom, // 是否为自定义色板
  }) = _ThemePalette;

  factory ThemePalette.fromJson(Map<String, dynamic> json) =>
      _$ThemePaletteFromJson(json);

  /// 预设色板列表
  static List<ThemePalette> get presets => [
        // 默认色板（当前使用的）
        const ThemePalette(
          id: 'default',
          name: '默认',
          primaryColor: 0xFFE4D5D5,
          accentColor: 0xFF8B5E3C,
        ),

        // 蓝色系
        const ThemePalette(
          id: 'blue',
          name: '海洋蓝',
          primaryColor: 0xFF3B82F6,
          accentColor: 0xFF1E40AF,
        ),

        // 紫色系
        const ThemePalette(
          id: 'purple',
          name: '薰衣草',
          primaryColor: 0xFFA855F7,
          accentColor: 0xFF7C3AED,
        ),

        // 绿色系
        const ThemePalette(
          id: 'green',
          name: '森林绿',
          primaryColor: 0xFF10B981,
          accentColor: 0xFF059669,
        ),

        // 橙色系
        const ThemePalette(
          id: 'orange',
          name: '日落橙',
          primaryColor: 0xFFF97316,
          accentColor: 0xFFEA580C,
        ),

        // 粉色系
        const ThemePalette(
          id: 'pink',
          name: '樱花粉',
          primaryColor: 0xFFEC4899,
          accentColor: 0xFFDB2777,
        ),

        // 青色系
        const ThemePalette(
          id: 'cyan',
          name: '天空青',
          primaryColor: 0xFF06B6D4,
          accentColor: 0xFF0891B2,
        ),

        // 红色系
        const ThemePalette(
          id: 'red',
          name: '玫瑰红',
          primaryColor: 0xFFEF4444,
          accentColor: 0xFFDC2626,
        ),

        // 黄色系
        const ThemePalette(
          id: 'yellow',
          name: '向日葵',
          primaryColor: 0xFFF59E0B,
          accentColor: 0xFFD97706,
        ),

        // 靛蓝系
        const ThemePalette(
          id: 'indigo',
          name: '深海靛',
          primaryColor: 0xFF6366F1,
          accentColor: 0xFF4F46E5,
        ),

        // 灰色系
        const ThemePalette(
          id: 'gray',
          name: '极简灰',
          primaryColor: 0xFF6B7280,
          accentColor: 0xFF4B5563,
        ),
      ];

  /// 根据 ID 获取预设色板
  static ThemePalette? getPresetById(String id) {
    try {
      return presets.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// 创建自定义色板
  static ThemePalette custom({
    required String name,
    required Color primaryColor,
    required Color accentColor,
  }) {
    return ThemePalette(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      primaryColor: primaryColor.value,
      accentColor: accentColor.value,
      isCustom: true,
    );
  }
}

/// ThemePalette 扩展方法
extension ThemePaletteExtension on ThemePalette {
  /// 获取主色 Color 对象
  Color get primary => Color(primaryColor);

  /// 获取强调色 Color 对象
  Color get accent => Color(accentColor);

  /// 生成浅色主题的 ColorScheme
  ColorScheme toLightColorScheme() {
    return ColorScheme.light(
      primary: primary,
      secondary: accent,
      surface: Colors.white,
      onSurface: const Color(0xFF111827),
      surfaceContainerHighest: const Color(0xFFF3F4F6),
    );
  }

  /// 生成深色主题的 ColorScheme
  ColorScheme toDarkColorScheme() {
    return ColorScheme.dark(
      primary: primary,
      secondary: accent,
      surface: const Color(0xFF121212),
      onSurface: const Color(0xFFF3F4F6),
      surfaceContainerHighest: const Color(0xFF1E1E1E),
    );
  }
}
