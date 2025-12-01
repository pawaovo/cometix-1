import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import '../providers/settings_provider.dart';
import '../services/haptic_service.dart';

/// 触感反馈包装器
/// 为所有子组件的点击操作添加触感反馈
class HapticFeedbackWrapper extends StatelessWidget {
  final Widget child;

  const HapticFeedbackWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) => _performHaptic(context),
      child: child,
    );
  }

  Future<void> _performHaptic(BuildContext context) async {
    try {
      final settingsProvider = provider.Provider.of<SettingsProvider>(
        context,
        listen: false,
      );

      if (!settingsProvider.hapticEnabled) return;

      final intensity = HapticIntensity.fromValue(settingsProvider.hapticIntensity);
      await intensity.perform();
    } catch (e) {
      // 忽略触感反馈错误
    }
  }
}

/// 为 Widget 添加触感反馈的扩展方法
extension HapticFeedbackExtension on Widget {
  Widget withHapticFeedback() {
    return HapticFeedbackWrapper(child: this);
  }
}
