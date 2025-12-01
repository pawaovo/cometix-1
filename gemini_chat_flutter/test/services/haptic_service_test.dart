import 'package:flutter_test/flutter_test.dart';
import 'package:gemini_chat_flutter/services/haptic_service.dart';

void main() {
  group('HapticIntensity', () {
    test('应包含所有强度级别', () {
      expect(HapticIntensity.values.length, 4);

      expect(HapticIntensity.light.value, 'light');
      expect(HapticIntensity.medium.value, 'medium');
      expect(HapticIntensity.heavy.value, 'heavy');
      expect(HapticIntensity.off.value, 'off');
    });

    test('fromValue 应正确转换', () {
      expect(HapticIntensity.fromValue('light'), HapticIntensity.light);
      expect(HapticIntensity.fromValue('medium'), HapticIntensity.medium);
      expect(HapticIntensity.fromValue('heavy'), HapticIntensity.heavy);
      expect(HapticIntensity.fromValue('off'), HapticIntensity.off);

      // 未知值应返回默认值
      expect(HapticIntensity.fromValue('unknown'), HapticIntensity.medium);
    });

    test('label 应该是可读的', () {
      expect(HapticIntensity.light.label, '轻触');
      expect(HapticIntensity.medium.label, '中等');
      expect(HapticIntensity.heavy.label, '重触');
      expect(HapticIntensity.off.label, '关闭');
    });

    test('perform 应该不抛出异常', () async {
      // 注意：在测试环境中，HapticFeedback 可能不可用
      // 这里只测试方法调用不会崩溃
      expect(
        () async => await HapticIntensity.light.perform(),
        returnsNormally,
      );

      expect(
        () async => await HapticIntensity.medium.perform(),
        returnsNormally,
      );

      expect(
        () async => await HapticIntensity.heavy.perform(),
        returnsNormally,
      );

      expect(
        () async => await HapticIntensity.off.perform(),
        returnsNormally,
      );
    });
  });

  group('HapticService', () {
    test('所有方法应该不抛出异常', () async {
      // 注意：在测试环境中，HapticFeedback 可能不可用
      // 这里只测试方法调用不会崩溃
      expect(() async => await HapticService.light(), returnsNormally);
      expect(() async => await HapticService.medium(), returnsNormally);
      expect(() async => await HapticService.heavy(), returnsNormally);
      expect(() async => await HapticService.selection(), returnsNormally);
      expect(() async => await HapticService.vibrate(), returnsNormally);
      expect(() async => await HapticService.success(), returnsNormally);
      expect(() async => await HapticService.error(), returnsNormally);
      expect(() async => await HapticService.warning(), returnsNormally);
    });
  });
}
