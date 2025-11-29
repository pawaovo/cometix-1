import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/assistant.dart';

/// 助手提供者 - 管理 AI 助手配置
class AssistantProvider extends ChangeNotifier {
  static const String _assistantsKey = 'assistants_v1';
  static const String _currentAssistantKey = 'current_assistant_id_v1';

  final List<Assistant> _assistants = [];
  String? _currentAssistantId;

  List<Assistant> get assistants => List.unmodifiable(_assistants);
  String? get currentAssistantId => _currentAssistantId;

  Assistant? get currentAssistant {
    if (_currentAssistantId != null) {
      try {
        return _assistants.firstWhere((a) => a.id == _currentAssistantId);
      } catch (e) {
        // 如果找不到，返回第一个
        return _assistants.isNotEmpty ? _assistants.first : null;
      }
    }
    return _assistants.isNotEmpty ? _assistants.first : null;
  }

  AssistantProvider() {
    _load();
  }

  /// 从 SharedPreferences 加载助手列表
  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_assistantsKey);

      if (raw != null && raw.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(raw);
        _assistants.clear();
        _assistants.addAll(
          jsonList.map((json) => Assistant.fromJson(json)).toList(),
        );
      } else {
        // 创建默认助手
        _createDefaults();
      }

      // 恢复当前助手
      _currentAssistantId = prefs.getString(_currentAssistantKey);
      if (_currentAssistantId != null &&
          !_assistants.any((a) => a.id == _currentAssistantId)) {
        _currentAssistantId = null;
      }

      notifyListeners();
    } catch (e) {
      debugPrint('加载助手失败: $e');
      _createDefaults();
    }
  }

  /// 创建默认助手
  void _createDefaults() {
    _assistants.addAll([
      Assistant(
        id: 'default',
        name: '默认助手',
        description: '通用AI助手，适用于各种场景',
        systemPrompt: '',
        enabled: true,
      ),
      Assistant(
        id: 'code',
        name: '代码助手',
        description: '专注于编程和代码相关的任务',
        systemPrompt: '你是一个专业的编程助手，擅长各种编程语言和技术栈。',
        enabled: true,
      ),
      Assistant(
        id: 'writer',
        name: '写作助手',
        description: '帮助你进行创意写作和文案创作',
        systemPrompt: '你是一个专业的写作助手，擅长创意写作、文案创作和内容优化。',
        enabled: false,
      ),
    ]);
    _persist();
  }

  /// 保存到 SharedPreferences
  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _assistants.map((a) => a.toJson()).toList();
      await prefs.setString(_assistantsKey, json.encode(jsonList));
    } catch (e) {
      debugPrint('保存助手失败: $e');
    }
  }

  /// 设置当前助手
  Future<void> setCurrentAssistant(String id) async {
    if (_currentAssistantId == id) return;
    _currentAssistantId = id;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_currentAssistantKey, id);
    } catch (e) {
      debugPrint('保存当前助手失败: $e');
    }
  }

  /// 根据 ID 获取助手
  Assistant? getById(String id) {
    try {
      return _assistants.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  /// 添加助手
  Future<void> addAssistant(Assistant assistant) async {
    _assistants.add(assistant);
    notifyListeners();
    await _persist();
  }

  /// 更新助手
  Future<void> updateAssistant(Assistant assistant) async {
    final index = _assistants.indexWhere((a) => a.id == assistant.id);
    if (index != -1) {
      _assistants[index] = assistant;
      notifyListeners();
      await _persist();
    }
  }

  /// 删除助手
  Future<void> deleteAssistant(String id) async {
    _assistants.removeWhere((a) => a.id == id);
    if (_currentAssistantId == id) {
      _currentAssistantId = _assistants.isNotEmpty ? _assistants.first.id : null;
      if (_currentAssistantId != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_currentAssistantKey, _currentAssistantId!);
      }
    }
    notifyListeners();
    await _persist();
  }

  /// 切换助手启用状态
  Future<void> toggleAssistant(String id) async {
    final index = _assistants.indexWhere((a) => a.id == id);
    if (index != -1) {
      _assistants[index] = _assistants[index].copyWith(
        enabled: !_assistants[index].enabled,
      );
      notifyListeners();
      await _persist();
    }
  }
}
