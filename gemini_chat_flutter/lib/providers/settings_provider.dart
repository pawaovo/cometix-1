import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 设置提供者 - 管理应用全局设置
class SettingsProvider extends ChangeNotifier {
  // SharedPreferences 键名
  static const String _themeModeKey = 'theme_mode_v1';
  static const String _appLocaleKey = 'app_locale_v1';
  static const String _chatFontScaleKey = 'chat_font_scale_v1';
  static const String _showUserAvatarKey = 'show_user_avatar_v1';
  static const String _showModelIconKey = 'show_model_icon_v1';
  static const String _showTimestampKey = 'show_timestamp_v1';
  static const String _enableMarkdownKey = 'enable_markdown_v1';
  static const String _autoScrollKey = 'auto_scroll_v1';

  // 私有字段
  ThemeMode _themeMode = ThemeMode.system;
  String? _appLocale; // null 表示跟随系统
  double _chatFontScale = 1.0;
  bool _showUserAvatar = true;
  bool _showModelIcon = true;
  bool _showTimestamp = true;
  bool _enableMarkdown = true;
  bool _autoScroll = true;

  // Getters
  ThemeMode get themeMode => _themeMode;
  String? get appLocale => _appLocale;
  double get chatFontScale => _chatFontScale;
  bool get showUserAvatar => _showUserAvatar;
  bool get showModelIcon => _showModelIcon;
  bool get showTimestamp => _showTimestamp;
  bool get enableMarkdown => _enableMarkdown;
  bool get autoScroll => _autoScroll;

  SettingsProvider() {
    _load();
  }

  /// 从 SharedPreferences 加载设置
  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 加载主题模式
      final themeModeIndex = prefs.getInt(_themeModeKey);
      if (themeModeIndex != null && themeModeIndex < ThemeMode.values.length) {
        _themeMode = ThemeMode.values[themeModeIndex];
      }

      // 加载语言设置
      _appLocale = prefs.getString(_appLocaleKey);

      // 加载字体缩放
      _chatFontScale = prefs.getDouble(_chatFontScaleKey) ?? 1.0;

      // 加载显示选项
      _showUserAvatar = prefs.getBool(_showUserAvatarKey) ?? true;
      _showModelIcon = prefs.getBool(_showModelIconKey) ?? true;
      _showTimestamp = prefs.getBool(_showTimestampKey) ?? true;
      _enableMarkdown = prefs.getBool(_enableMarkdownKey) ?? true;
      _autoScroll = prefs.getBool(_autoScrollKey) ?? true;

      notifyListeners();
    } catch (e) {
      debugPrint('加载设置失败: $e');
    }
  }

  /// 保存设置到 SharedPreferences
  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeModeKey, _themeMode.index);

      if (_appLocale != null) {
        await prefs.setString(_appLocaleKey, _appLocale!);
      } else {
        await prefs.remove(_appLocaleKey);
      }

      await prefs.setDouble(_chatFontScaleKey, _chatFontScale);
      await prefs.setBool(_showUserAvatarKey, _showUserAvatar);
      await prefs.setBool(_showModelIconKey, _showModelIcon);
      await prefs.setBool(_showTimestampKey, _showTimestamp);
      await prefs.setBool(_enableMarkdownKey, _enableMarkdown);
      await prefs.setBool(_autoScrollKey, _autoScroll);
    } catch (e) {
      debugPrint('保存设置失败: $e');
    }
  }

  /// 设置主题模式
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    await _save();
  }

  /// 设置应用语言
  Future<void> setAppLocale(String? locale) async {
    if (_appLocale == locale) return;
    _appLocale = locale;
    notifyListeners();
    await _save();
  }

  /// 设置字体缩放
  Future<void> setChatFontScale(double scale) async {
    if (_chatFontScale == scale) return;
    _chatFontScale = scale.clamp(0.8, 1.5);
    notifyListeners();
    await _save();
  }

  /// 设置显示用户头像
  Future<void> setShowUserAvatar(bool show) async {
    if (_showUserAvatar == show) return;
    _showUserAvatar = show;
    notifyListeners();
    await _save();
  }

  /// 设置显示模型图标
  Future<void> setShowModelIcon(bool show) async {
    if (_showModelIcon == show) return;
    _showModelIcon = show;
    notifyListeners();
    await _save();
  }

  /// 设置显示时间戳
  Future<void> setShowTimestamp(bool show) async {
    if (_showTimestamp == show) return;
    _showTimestamp = show;
    notifyListeners();
    await _save();
  }

  /// 设置启用 Markdown
  Future<void> setEnableMarkdown(bool enable) async {
    if (_enableMarkdown == enable) return;
    _enableMarkdown = enable;
    notifyListeners();
    await _save();
  }

  /// 设置自动滚动
  Future<void> setAutoScroll(bool enable) async {
    if (_autoScroll == enable) return;
    _autoScroll = enable;
    notifyListeners();
    await _save();
  }
}
