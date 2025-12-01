import 'package:flutter/services.dart';

/// 触感反馈服务
/// 提供统一的触感反馈接口
class HapticService {
  /// 轻触反馈（适用于按钮点击）
  static Future<void> light() async {
    await HapticFeedback.lightImpact();
  }

  /// 中等反馈（适用于重要操作）
  static Future<void> medium() async {
    await HapticFeedback.mediumImpact();
  }

  /// 重触反馈（适用于关键操作）
  static Future<void> heavy() async {
    await HapticFeedback.heavyImpact();
  }

  /// 选择反馈（适用于滑动选择）
  static Future<void> selection() async {
    await HapticFeedback.selectionClick();
  }

  /// 振动反馈（通用振动）
  static Future<void> vibrate() async {
    await HapticFeedback.vibrate();
  }

  /// 成功反馈（自定义：中等强度）
  static Future<void> success() async {
    await medium();
  }

  /// 错误反馈（自定义：重触）
  static Future<void> error() async {
    await heavy();
  }

  /// 警告反馈（自定义：轻触）
  static Future<void> warning() async {
    await light();
  }
}

/// 触感反馈强度枚举
enum HapticIntensity {
  light('轻触', 'light'),
  medium('中等', 'medium'),
  heavy('重触', 'heavy'),
  off('关闭', 'off');

  final String label;
  final String value;

  const HapticIntensity(this.label, this.value);

  /// 从字符串值获取枚举
  static HapticIntensity fromValue(String value) {
    return HapticIntensity.values.firstWhere(
      (e) => e.value == value,
      orElse: () => HapticIntensity.medium,
    );
  }

  /// 执行对应强度的反馈
  Future<void> perform() async {
    switch (this) {
      case HapticIntensity.light:
        await HapticService.light();
        break;
      case HapticIntensity.medium:
        await HapticService.medium();
        break;
      case HapticIntensity.heavy:
        await HapticService.heavy();
        break;
      case HapticIntensity.off:
        // 不执行任何反馈
        break;
    }
  }
}
