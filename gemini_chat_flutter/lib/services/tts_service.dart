import 'package:flutter_tts/flutter_tts.dart';

/// TTS (Text-to-Speech) 语音服务
class TTSService {
  static final TTSService _instance = TTSService._internal();
  factory TTSService() => _instance;

  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;
  bool _isSpeaking = false;

  TTSService._internal();

  /// 初始化 TTS 服务
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // 设置默认语言为中文
      await _flutterTts.setLanguage('zh-CN');

      // 设置默认语速（0.0-1.0，默认 0.5）
      await _flutterTts.setSpeechRate(0.5);

      // 设置默认音量（0.0-1.0，默认 1.0）
      await _flutterTts.setVolume(1.0);

      // 设置默认音调（0.5-2.0，默认 1.0）
      await _flutterTts.setPitch(1.0);

      // 监听播放状态
      _flutterTts.setStartHandler(() {
        _isSpeaking = true;
      });

      _flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
      });

      _flutterTts.setErrorHandler((msg) {
        _isSpeaking = false;
      });

      _isInitialized = true;
    } catch (e) {
      throw TTSException('TTS 初始化失败: $e');
    }
  }

  /// 朗读文本
  Future<void> speak(String text) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (text.trim().isEmpty) {
      throw TTSException('朗读文本不能为空');
    }

    try {
      await _flutterTts.speak(text);
    } catch (e) {
      throw TTSException('朗读失败: $e');
    }
  }

  /// 停止朗读
  Future<void> stop() async {
    if (!_isInitialized) return;

    try {
      await _flutterTts.stop();
      _isSpeaking = false;
    } catch (e) {
      throw TTSException('停止朗读失败: $e');
    }
  }

  /// 暂停朗读
  Future<void> pause() async {
    if (!_isInitialized) return;

    try {
      await _flutterTts.pause();
    } catch (e) {
      throw TTSException('暂停朗读失败: $e');
    }
  }

  /// 设置语言
  Future<void> setLanguage(String language) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      await _flutterTts.setLanguage(language);
    } catch (e) {
      throw TTSException('设置语言失败: $e');
    }
  }

  /// 设置语速（0.1-2.0）
  /// 内部会映射到 flutter_tts 的 0.0-1.0 范围
  Future<void> setSpeechRate(double rate) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (rate < 0.1 || rate > 2.0) {
      throw TTSException('语速必须在 0.1-2.0 之间');
    }

    try {
      // 将用户友好的 0.1-2.0 范围映射到 flutter_tts 的 0.0-1.0 范围
      // 0.1 -> 0.0, 1.0 -> 0.5, 2.0 -> 1.0
      final mappedRate = (rate - 0.1) / 1.9;
      await _flutterTts.setSpeechRate(mappedRate.clamp(0.0, 1.0));
    } catch (e) {
      throw TTSException('设置语速失败: $e');
    }
  }

  /// 设置音量（0.0-1.0）
  Future<void> setVolume(double volume) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (volume < 0.0 || volume > 1.0) {
      throw TTSException('音量必须在 0.0-1.0 之间');
    }

    try {
      await _flutterTts.setVolume(volume);
    } catch (e) {
      throw TTSException('设置音量失败: $e');
    }
  }

  /// 设置音调（0.5-2.0）
  Future<void> setPitch(double pitch) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (pitch < 0.5 || pitch > 2.0) {
      throw TTSException('音调必须在 0.5-2.0 之间');
    }

    try {
      await _flutterTts.setPitch(pitch);
    } catch (e) {
      throw TTSException('设置音调失败: $e');
    }
  }

  /// 获取可用语言列表
  Future<List<String>> getLanguages() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final languages = await _flutterTts.getLanguages;
      if (languages is List) {
        return languages.cast<String>();
      }
      return [];
    } catch (e) {
      throw TTSException('获取语言列表失败: $e');
    }
  }

  /// 获取可用语音列表
  Future<List<Map<String, String>>> getVoices() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final voices = await _flutterTts.getVoices;
      if (voices is List) {
        return voices.map((v) => Map<String, String>.from(v as Map)).toList();
      }
      return [];
    } catch (e) {
      throw TTSException('获取语音列表失败: $e');
    }
  }

  /// 是否正在朗读
  bool get isSpeaking => _isSpeaking;

  /// 是否已初始化
  bool get isInitialized => _isInitialized;

  /// 释放资源
  Future<void> dispose() async {
    if (!_isInitialized) return;

    try {
      await _flutterTts.stop();
      _isInitialized = false;
      _isSpeaking = false;
    } catch (e) {
      // 忽略释放错误
    }
  }
}

/// TTS 异常
class TTSException implements Exception {
  final String message;

  TTSException(this.message);

  @override
  String toString() => 'TTSException: $message';
}

/// TTS 语言枚举
enum TTSLanguage {
  chinese('中文', 'zh-CN'),
  english('English', 'en-US');

  final String label;
  final String code;

  const TTSLanguage(this.label, this.code);

  /// 从代码获取枚举
  static TTSLanguage fromCode(String code) {
    return TTSLanguage.values.firstWhere(
      (e) => e.code == code,
      orElse: () => TTSLanguage.chinese,
    );
  }
}
