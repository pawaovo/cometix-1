import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/backup.dart';

/// 全局设置 Provider
class SettingsProvider extends ChangeNotifier {
  SettingsProvider() {
    _loadSettings();
  }

  // 主题设置
  ThemeMode _themeMode = ThemeMode.system;
  String? _appLocale;
  double _fontSize = 16.0;

  // WebDAV 配置
  WebDavConfig _webDavConfig = const WebDavConfig();

  ThemeMode get themeMode => _themeMode;
  String? get appLocale => _appLocale;
  double get fontSize => _fontSize;
  WebDavConfig get webDavConfig => _webDavConfig;

  /// 加载设置
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // 加载主题模式
    final themeModeStr = prefs.getString('theme_mode');
    if (themeModeStr != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == themeModeStr,
        orElse: () => ThemeMode.system,
      );
    }

    // 加载语言
    _appLocale = prefs.getString('app_locale');

    // 加载字体大小
    _fontSize = prefs.getDouble('font_size') ?? 16.0;

    // 加载 WebDAV 配置
    final webDavConfigStr = prefs.getString('webdav_config');
    if (webDavConfigStr != null && webDavConfigStr.isNotEmpty) {
      try {
        final json = jsonDecode(webDavConfigStr) as Map<String, dynamic>;
        _webDavConfig = WebDavConfig.fromJson(json);
      } catch (_) {}
    }

    notifyListeners();
  }

  /// 设置主题模式
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.toString());
  }

  /// 设置语言
  Future<void> setAppLocale(String? locale) async {
    _appLocale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove('app_locale');
    } else {
      await prefs.setString('app_locale', locale);
    }
  }

  /// 设置字体大小
  Future<void> setFontSize(double size) async {
    _fontSize = size;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('font_size', size);
  }

  /// 设置 WebDAV 配置
  Future<void> setWebDavConfig(WebDavConfig config) async {
    _webDavConfig = config;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('webdav_config', jsonEncode(config.toJson()));
  }
}
