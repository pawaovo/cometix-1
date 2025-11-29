import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/search_service.dart';
import '../models/provider_config.dart';
import '../models/mcp_config.dart';
import '../models/proxy_config.dart';

/// 设置提供者 - 管理应用全局设置
class SettingsProvider extends ChangeNotifier {
  // ===== SharedPreferences 键名 =====
  static const String _themeModeKey = 'theme_mode_v1';
  static const String _appLocaleKey = 'app_locale_v1';
  static const String _chatFontScaleKey = 'chat_font_scale_v1';
  static const String _showUserAvatarKey = 'show_user_avatar_v1';
  static const String _showModelIconKey = 'show_model_icon_v1';
  static const String _showTimestampKey = 'show_timestamp_v1';
  static const String _enableMarkdownKey = 'enable_markdown_v1';
  static const String _autoScrollKey = 'auto_scroll_v1';

  // 模型相关
  static const String _selectedModelKey = 'selected_model_v1';
  static const String _titleModelKey = 'title_model_v1';
  static const String _titlePromptKey = 'title_prompt_v1';
  static const String _ocrModelKey = 'ocr_model_v1';
  static const String _ocrPromptKey = 'ocr_prompt_v1';
  static const String _translateModelKey = 'translate_model_v1';
  static const String _translatePromptKey = 'translate_prompt_v1';

  // 服务商相关
  static const String _providerConfigsKey = 'provider_configs_v1';
  static const String _providersOrderKey = 'providers_order_v1';

  // 搜索服务相关
  static const String _searchServicesKey = 'search_services_v1';
  static const String _searchCommonKey = 'search_common_v1';
  static const String _searchSelectedKey = 'search_selected_v1';
  static const String _searchEnabledKey = 'search_enabled_v1';

  // MCP 相关
  static const String _mcpServersKey = 'mcp_servers_v1';

  // 代理相关
  static const String _proxyConfigKey = 'proxy_config_v1';

  // ===== 基础设置字段 =====
  ThemeMode _themeMode = ThemeMode.system;
  String? _appLocale;
  double _chatFontScale = 1.0;
  bool _showUserAvatar = true;
  bool _showModelIcon = true;
  bool _showTimestamp = true;
  bool _enableMarkdown = true;
  bool _autoScroll = true;

  // ===== 模型设置字段 =====
  String? _currentModelProvider;
  String? _currentModelId;
  String? _titleModelProvider;
  String? _titleModelId;
  String _titlePrompt = defaultTitlePrompt;
  String? _ocrModelProvider;
  String? _ocrModelId;
  String _ocrPrompt = defaultOcrPrompt;
  String? _translateModelProvider;
  String? _translateModelId;
  String _translatePrompt = defaultTranslatePrompt;

  // ===== 服务商设置字段 =====
  Map<String, ProviderConfig> _providerConfigs = {};
  List<String> _providersOrder = [];

  // ===== 搜索服务设置字段 =====
  List<SearchServiceOptions> _searchServices = [SearchServiceOptions.defaultOption];
  SearchCommonOptions _searchCommonOptions = const SearchCommonOptions();
  int _searchServiceSelected = 0;
  bool _searchEnabled = false;
  final Map<String, bool?> _searchConnection = {};

  // ===== MCP 设置字段 =====
  List<MCPServerConfig> _mcpServers = [];

  // ===== 代理设置字段 =====
  ProxyConfig _proxyConfig = const ProxyConfig();

  // ===== Getters - 基础设置 =====
  ThemeMode get themeMode => _themeMode;
  String? get appLocale => _appLocale;
  double get chatFontScale => _chatFontScale;
  bool get showUserAvatar => _showUserAvatar;
  bool get showModelIcon => _showModelIcon;
  bool get showTimestamp => _showTimestamp;
  bool get enableMarkdown => _enableMarkdown;
  bool get autoScroll => _autoScroll;

  // ===== Getters - 模型设置 =====
  String? get currentModelProvider => _currentModelProvider;
  String? get currentModelId => _currentModelId;
  String? get titleModelProvider => _titleModelProvider;
  String? get titleModelId => _titleModelId;
  String get titlePrompt => _titlePrompt;
  String? get ocrModelProvider => _ocrModelProvider;
  String? get ocrModelId => _ocrModelId;
  String get ocrPrompt => _ocrPrompt;
  String? get translateModelProvider => _translateModelProvider;
  String? get translateModelId => _translateModelId;
  String get translatePrompt => _translatePrompt;

  // ===== Getters - 服务商设置 =====
  Map<String, ProviderConfig> get providerConfigs => Map.unmodifiable(_providerConfigs);
  List<String> get providersOrder => List.unmodifiable(_providersOrder);
  bool get hasAnyActiveModel => _providerConfigs.values.any((c) => c.enabled && c.models.isNotEmpty);

  ProviderConfig getProviderConfig(String key, {String? defaultName}) {
    final existed = _providerConfigs[key];
    if (existed != null) return existed;
    return ProviderConfig.defaultsFor(key, displayName: defaultName);
  }

  ProviderConfig ensureProviderConfig(String key, {String? defaultName}) {
    final existed = _providerConfigs[key];
    if (existed != null) return existed;
    final cfg = ProviderConfig.defaultsFor(key, displayName: defaultName);
    _providerConfigs[key] = cfg;
    return cfg;
  }

  // ===== Getters - 搜索服务设置 =====
  List<SearchServiceOptions> get searchServices => List.unmodifiable(_searchServices);
  SearchCommonOptions get searchCommonOptions => _searchCommonOptions;
  int get searchServiceSelected => _searchServiceSelected;
  bool get searchEnabled => _searchEnabled;
  Map<String, bool?> get searchConnection => Map.unmodifiable(_searchConnection);

  // ===== Getters - MCP 设置 =====
  List<MCPServerConfig> get mcpServers => List.unmodifiable(_mcpServers);

  // ===== Getters - 代理设置 =====
  ProxyConfig get proxyConfig => _proxyConfig;

  // ===== 默认 Prompt =====
  static const String defaultTitlePrompt = '''请为以下对话生成一个简短的标题（不超过20个字）：

{content}

语言：{locale}''';

  static const String defaultOcrPrompt = '''请识别图片中的文字内容，并按原格式输出。''';

  static const String defaultTranslatePrompt = '''请将以下文本翻译成{target_lang}：

{source_text}''';

  SettingsProvider() {
    _load();
  }

  /// 从 SharedPreferences 加载设置
  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 加载基础设置
      final themeModeIndex = prefs.getInt(_themeModeKey);
      if (themeModeIndex != null && themeModeIndex < ThemeMode.values.length) {
        _themeMode = ThemeMode.values[themeModeIndex];
      }
      _appLocale = prefs.getString(_appLocaleKey);
      _chatFontScale = prefs.getDouble(_chatFontScaleKey) ?? 1.0;
      _showUserAvatar = prefs.getBool(_showUserAvatarKey) ?? true;
      _showModelIcon = prefs.getBool(_showModelIconKey) ?? true;
      _showTimestamp = prefs.getBool(_showTimestampKey) ?? true;
      _enableMarkdown = prefs.getBool(_enableMarkdownKey) ?? true;
      _autoScroll = prefs.getBool(_autoScrollKey) ?? true;

      // 加载模型设置
      final sel = prefs.getString(_selectedModelKey);
      if (sel != null && sel.contains('::')) {
        final parts = sel.split('::');
        if (parts.length >= 2) {
          _currentModelProvider = parts[0];
          _currentModelId = parts.sublist(1).join('::');
        }
      }

      final titleSel = prefs.getString(_titleModelKey);
      if (titleSel != null && titleSel.contains('::')) {
        final parts = titleSel.split('::');
        if (parts.length >= 2) {
          _titleModelProvider = parts[0];
          _titleModelId = parts.sublist(1).join('::');
        }
      }
      final tp = prefs.getString(_titlePromptKey);
      _titlePrompt = (tp == null || tp.trim().isEmpty) ? defaultTitlePrompt : tp;

      final ocrSel = prefs.getString(_ocrModelKey);
      if (ocrSel != null && ocrSel.contains('::')) {
        final parts = ocrSel.split('::');
        if (parts.length >= 2) {
          _ocrModelProvider = parts[0];
          _ocrModelId = parts.sublist(1).join('::');
        }
      }
      final ocrp = prefs.getString(_ocrPromptKey);
      _ocrPrompt = (ocrp == null || ocrp.trim().isEmpty) ? defaultOcrPrompt : ocrp;

      final translateSel = prefs.getString(_translateModelKey);
      if (translateSel != null && translateSel.contains('::')) {
        final parts = translateSel.split('::');
        if (parts.length >= 2) {
          _translateModelProvider = parts[0];
          _translateModelId = parts.sublist(1).join('::');
        }
      }
      final transp = prefs.getString(_translatePromptKey);
      _translatePrompt = (transp == null || transp.trim().isEmpty) ? defaultTranslatePrompt : transp;

      // 加载服务商配置
      final cfgStr = prefs.getString(_providerConfigsKey);
      if (cfgStr != null && cfgStr.isNotEmpty) {
        try {
          final raw = jsonDecode(cfgStr) as Map<String, dynamic>;
          _providerConfigs = raw.map((k, v) => MapEntry(k, ProviderConfig.fromJson(v as Map<String, dynamic>)));
        } catch (e) {
          debugPrint('加载服务商配置失败: $e');
        }
      }
      _providersOrder = prefs.getStringList(_providersOrderKey) ?? [];

      // 加载搜索服务配置
      final searchStr = prefs.getString(_searchServicesKey);
      if (searchStr != null && searchStr.isNotEmpty) {
        try {
          final raw = jsonDecode(searchStr) as List<dynamic>;
          _searchServices = raw.map((e) => SearchServiceOptions.fromJson(e as Map<String, dynamic>)).toList();
        } catch (e) {
          debugPrint('加载搜索服务配置失败: $e');
        }
      }
      final commonStr = prefs.getString(_searchCommonKey);
      if (commonStr != null && commonStr.isNotEmpty) {
        try {
          _searchCommonOptions = SearchCommonOptions.fromJson(jsonDecode(commonStr) as Map<String, dynamic>);
        } catch (e) {
          debugPrint('加载搜索通用配置失败: $e');
        }
      }
      _searchServiceSelected = prefs.getInt(_searchSelectedKey) ?? 0;
      _searchEnabled = prefs.getBool(_searchEnabledKey) ?? false;

      // 加载 MCP 配置
      final mcpStr = prefs.getString(_mcpServersKey);
      if (mcpStr != null && mcpStr.isNotEmpty) {
        try {
          final raw = jsonDecode(mcpStr) as List<dynamic>;
          _mcpServers = raw.map((e) => MCPServerConfig.fromJson(e as Map<String, dynamic>)).toList();
        } catch (e) {
          debugPrint('加载 MCP 配置失败: $e');
        }
      }

      // 加载代理配置
      final proxyStr = prefs.getString(_proxyConfigKey);
      if (proxyStr != null && proxyStr.isNotEmpty) {
        try {
          _proxyConfig = ProxyConfig.fromJson(jsonDecode(proxyStr) as Map<String, dynamic>);
        } catch (e) {
          debugPrint('加载代理配置失败: $e');
        }
      }

      notifyListeners();
    } catch (e) {
      debugPrint('加载设置失败: $e');
    }
  }

  /// 保存设置到 SharedPreferences
  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 保存基础设置
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

      // 保存模型设置
      if (_currentModelProvider != null && _currentModelId != null) {
        await prefs.setString(_selectedModelKey, '$_currentModelProvider::$_currentModelId');
      }
      if (_titleModelProvider != null && _titleModelId != null) {
        await prefs.setString(_titleModelKey, '$_titleModelProvider::$_titleModelId');
      }
      await prefs.setString(_titlePromptKey, _titlePrompt);
      if (_ocrModelProvider != null && _ocrModelId != null) {
        await prefs.setString(_ocrModelKey, '$_ocrModelProvider::$_ocrModelId');
      }
      await prefs.setString(_ocrPromptKey, _ocrPrompt);
      if (_translateModelProvider != null && _translateModelId != null) {
        await prefs.setString(_translateModelKey, '$_translateModelProvider::$_translateModelId');
      }
      await prefs.setString(_translatePromptKey, _translatePrompt);

      // 保存服务商配置
      final cfgJson = jsonEncode(_providerConfigs.map((k, v) => MapEntry(k, v.toJson())));
      await prefs.setString(_providerConfigsKey, cfgJson);
      await prefs.setStringList(_providersOrderKey, _providersOrder);

      // 保存搜索服务配置
      final searchJson = jsonEncode(_searchServices.map((e) => e.toJson()).toList());
      await prefs.setString(_searchServicesKey, searchJson);
      final commonJson = jsonEncode(_searchCommonOptions.toJson());
      await prefs.setString(_searchCommonKey, commonJson);
      await prefs.setInt(_searchSelectedKey, _searchServiceSelected);
      await prefs.setBool(_searchEnabledKey, _searchEnabled);

      // 保存 MCP 配置
      final mcpJson = jsonEncode(_mcpServers.map((e) => e.toJson()).toList());
      await prefs.setString(_mcpServersKey, mcpJson);

      // 保存代理配置
      final proxyJson = jsonEncode(_proxyConfig.toJson());
      await prefs.setString(_proxyConfigKey, proxyJson);
    } catch (e) {
      debugPrint('保存设置失败: $e');
    }
  }

  // ===== 基础设置方法 =====
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    await _save();
  }

  Future<void> setAppLocale(String? locale) async {
    if (_appLocale == locale) return;
    _appLocale = locale;
    notifyListeners();
    await _save();
  }

  Future<void> setChatFontScale(double scale) async {
    if (_chatFontScale == scale) return;
    _chatFontScale = scale.clamp(0.8, 1.5);
    notifyListeners();
    await _save();
  }

  Future<void> setShowUserAvatar(bool show) async {
    if (_showUserAvatar == show) return;
    _showUserAvatar = show;
    notifyListeners();
    await _save();
  }

  Future<void> setShowModelIcon(bool show) async {
    if (_showModelIcon == show) return;
    _showModelIcon = show;
    notifyListeners();
    await _save();
  }

  Future<void> setShowTimestamp(bool show) async {
    if (_showTimestamp == show) return;
    _showTimestamp = show;
    notifyListeners();
    await _save();
  }

  Future<void> setEnableMarkdown(bool enable) async {
    if (_enableMarkdown == enable) return;
    _enableMarkdown = enable;
    notifyListeners();
    await _save();
  }

  Future<void> setAutoScroll(bool enable) async {
    if (_autoScroll == enable) return;
    _autoScroll = enable;
    notifyListeners();
    await _save();
  }

  // ===== 模型设置方法 =====
  Future<void> setCurrentModel(String provider, String modelId) async {
    _currentModelProvider = provider;
    _currentModelId = modelId;
    notifyListeners();
    await _save();
  }

  Future<void> resetCurrentModel() async {
    _currentModelProvider = null;
    _currentModelId = null;
    notifyListeners();
    await _save();
  }

  Future<void> setTitleModel(String provider, String modelId) async {
    _titleModelProvider = provider;
    _titleModelId = modelId;
    notifyListeners();
    await _save();
  }

  Future<void> resetTitleModel() async {
    _titleModelProvider = null;
    _titleModelId = null;
    notifyListeners();
    await _save();
  }

  Future<void> setTitlePrompt(String prompt) async {
    _titlePrompt = prompt;
    notifyListeners();
    await _save();
  }

  Future<void> resetTitlePrompt() async {
    _titlePrompt = defaultTitlePrompt;
    notifyListeners();
    await _save();
  }

  Future<void> setOcrModel(String provider, String modelId) async {
    _ocrModelProvider = provider;
    _ocrModelId = modelId;
    notifyListeners();
    await _save();
  }

  Future<void> resetOcrModel() async {
    _ocrModelProvider = null;
    _ocrModelId = null;
    notifyListeners();
    await _save();
  }

  Future<void> setOcrPrompt(String prompt) async {
    _ocrPrompt = prompt;
    notifyListeners();
    await _save();
  }

  Future<void> resetOcrPrompt() async {
    _ocrPrompt = defaultOcrPrompt;
    notifyListeners();
    await _save();
  }

  Future<void> setTranslateModel(String provider, String modelId) async {
    _translateModelProvider = provider;
    _translateModelId = modelId;
    notifyListeners();
    await _save();
  }

  Future<void> resetTranslateModel() async {
    _translateModelProvider = null;
    _translateModelId = null;
    notifyListeners();
    await _save();
  }

  Future<void> setTranslatePrompt(String prompt) async {
    _translatePrompt = prompt;
    notifyListeners();
    await _save();
  }

  Future<void> resetTranslatePrompt() async {
    _translatePrompt = defaultTranslatePrompt;
    notifyListeners();
    await _save();
  }

  // ===== 服务商管理方法 =====
  Future<void> setProviderConfig(String key, ProviderConfig config) async {
    _providerConfigs[key] = config;
    if (!_providersOrder.contains(key)) {
      _providersOrder.add(key);
    }
    notifyListeners();
    await _save();
  }

  Future<void> removeProviderConfig(String key) async {
    _providerConfigs.remove(key);
    _providersOrder.remove(key);
    notifyListeners();
    await _save();
  }

  Future<void> setProvidersOrder(List<String> order) async {
    _providersOrder = List.from(order);
    notifyListeners();
    await _save();
  }

  // ===== 搜索服务管理方法 =====
  Future<void> setSearchServices(List<SearchServiceOptions> services) async {
    _searchServices = List.from(services);
    notifyListeners();
    await _save();
  }

  Future<void> setSearchCommonOptions(SearchCommonOptions options) async {
    _searchCommonOptions = options;
    notifyListeners();
    await _save();
  }

  Future<void> setSearchServiceSelected(int index) async {
    _searchServiceSelected = index;
    notifyListeners();
    await _save();
  }

  Future<void> setSearchEnabled(bool enabled) async {
    _searchEnabled = enabled;
    notifyListeners();
    await _save();
  }

  void setSearchConnection(String serviceId, bool? connected) {
    _searchConnection[serviceId] = connected;
    notifyListeners();
  }

  // ===== MCP 管理方法 =====
  Future<void> setMcpServers(List<MCPServerConfig> servers) async {
    _mcpServers = List.from(servers);
    notifyListeners();
    await _save();
  }

  Future<void> addMcpServer(MCPServerConfig server) async {
    _mcpServers = [..._mcpServers, server];
    notifyListeners();
    await _save();
  }

  Future<void> updateMcpServer(int index, MCPServerConfig server) async {
    if (index >= 0 && index < _mcpServers.length) {
      _mcpServers = List.from(_mcpServers)..[index] = server;
      notifyListeners();
      await _save();
    }
  }

  Future<void> removeMcpServer(int index) async {
    if (index >= 0 && index < _mcpServers.length) {
      _mcpServers = List.from(_mcpServers)..removeAt(index);
      notifyListeners();
      await _save();
    }
  }

  // ===== 代理管理方法 =====
  Future<void> setProxyConfig(ProxyConfig config) async {
    _proxyConfig = config;
    notifyListeners();
    await _save();
  }
}
