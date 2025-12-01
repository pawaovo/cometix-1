import 'package:flutter_test/flutter_test.dart';
import 'package:gemini_chat_flutter/services/tts_service.dart';

void main() {
  group('TTSService', () {
    test('应该是单例', () {
      final instance1 = TTSService();
      final instance2 = TTSService();

      expect(instance1, same(instance2));
    });

    test('初始状态应该正确', () {
      final tts = TTSService();

      expect(tts.isSpeaking, false);
      // 注意：isInitialized 可能为 true，因为是单例
    });
  });

  group('TTSException', () {
    test('应正确格式化错误消息', () {
      final exception = TTSException('测试错误');
      expect(exception.toString(), 'TTSException: 测试错误');
    });
  });

  group('TTSLanguage', () {
    test('应包含所有支持的语言', () {
      expect(TTSLanguage.values.length, 2);

      expect(TTSLanguage.chinese.code, 'zh-CN');
      expect(TTSLanguage.english.code, 'en-US');
    });

    test('fromCode 应正确转换', () {
      expect(TTSLanguage.fromCode('zh-CN'), TTSLanguage.chinese);
      expect(TTSLanguage.fromCode('en-US'), TTSLanguage.english);

      // 未知代码应返回默认值
      expect(TTSLanguage.fromCode('unknown'), TTSLanguage.chinese);
    });

    test('label 应该是可读的', () {
      expect(TTSLanguage.chinese.label, '中文');
      expect(TTSLanguage.english.label, 'English');
    });
  });
}
