import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../providers/assistant_provider.dart';
import '../models/assistant.dart';

/// 助手详情编辑页面 - 包含4个Tab：基础、提示词、记忆、快捷短语
class AssistantEditPage extends StatefulWidget {
  final String assistantId;

  const AssistantEditPage({super.key, required this.assistantId});

  @override
  State<AssistantEditPage> createState() => _AssistantEditPageState();
}

class _AssistantEditPageState extends State<AssistantEditPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 基础信息
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  // 提示词
  late TextEditingController _systemPromptController;

  // 参数配置
  late double _temperature;
  late double _topP;
  late int _contextMessageCount;
  late bool _streamOutput;

  // 记忆配置
  late bool _enableMemory;
  late bool _useHistoryChat;
  late List<String> _memories;

  // 快捷短语
  late List<String> _quickPhrases;

  // 防抖计时器
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    final assistantProvider =
        provider.Provider.of<AssistantProvider>(context, listen: false);
    final assistant = assistantProvider.getById(widget.assistantId);

    if (assistant != null) {
      _nameController = TextEditingController(text: assistant.name);
      _descriptionController =
          TextEditingController(text: assistant.description ?? '');
      _systemPromptController =
          TextEditingController(text: assistant.systemPrompt);
      _temperature = assistant.temperature;
      _topP = assistant.topP;
      _contextMessageCount = assistant.contextMessageCount;
      _streamOutput = assistant.streamOutput;
      _enableMemory = assistant.enableMemory;
      _useHistoryChat = assistant.useHistoryChat;
      _memories = List<String>.from(assistant.memories);
      _quickPhrases = List<String>.from(assistant.quickPhrases);
    } else {
      _nameController = TextEditingController();
      _descriptionController = TextEditingController();
      _systemPromptController = TextEditingController();
      _temperature = 0.7;
      _topP = 1.0;
      _contextMessageCount = 10;
      _streamOutput = true;
      _enableMemory = false;
      _useHistoryChat = false;
      _memories = [];
      _quickPhrases = [];
    }

    // 添加文本监听器实现实时保存（带防抖）
    _nameController.addListener(_onTextChanged);
    _descriptionController.addListener(_onTextChanged);
    _systemPromptController.addListener(_onTextChanged);
  }

  /// 文本变化时触发防抖保存
  void _onTextChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), _saveAssistant);
  }

  @override
  void dispose() {
    // 取消防抖计时器
    _debounceTimer?.cancel();

    // 移除监听器
    _nameController.removeListener(_onTextChanged);
    _descriptionController.removeListener(_onTextChanged);
    _systemPromptController.removeListener(_onTextChanged);

    _tabController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _systemPromptController.dispose();
    super.dispose();
  }

  /// 实时保存助手数据
  void _saveAssistant() {
    final assistantProvider =
        provider.Provider.of<AssistantProvider>(context, listen: false);
    final assistant = assistantProvider.getById(widget.assistantId);

    if (assistant != null) {
      final updatedAssistant = assistant.copyWith(
        name: _nameController.text.trim().isEmpty
            ? '未命名助手'
            : _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        systemPrompt: _systemPromptController.text,
        temperature: _temperature,
        topP: _topP,
        contextMessageCount: _contextMessageCount,
        streamOutput: _streamOutput,
        enableMemory: _enableMemory,
        useHistoryChat: _useHistoryChat,
        memories: _memories,
        quickPhrases: _quickPhrases,
      );

      assistantProvider.updateAssistant(updatedAssistant);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final assistantProvider = provider.Provider.of<AssistantProvider>(context);
    final assistant = assistantProvider.getById(widget.assistantId);

    if (assistant == null) {
      return Scaffold(
        backgroundColor:
            isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
        appBar: AppBar(
          backgroundColor:
              isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Symbols.arrow_back,
                color: isDark ? AppTheme.gray100 : AppTheme.gray900),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            '助手编辑',
            style: TextStyle(
              color: isDark ? AppTheme.gray100 : AppTheme.gray900,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Center(
          child: Text(
            '助手不存在',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.gray500,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor:
            isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Symbols.arrow_back,
              color: isDark ? AppTheme.gray100 : AppTheme.gray900),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '编辑助手',
          style: TextStyle(
            color: isDark ? AppTheme.gray100 : AppTheme.gray900,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.gray500,
          indicatorColor: AppTheme.primaryColor,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: '基础'),
            Tab(text: '提示词'),
            Tab(text: '记忆'),
            Tab(text: '快捷短语'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBasicTab(isDark),
          _buildPromptTab(isDark),
          _buildMemoryTab(isDark),
          _buildQuickPhrasesTab(isDark),
        ],
      ),
    );
  }

  /// 基础Tab - 名称、描述、参数配置、输出配置
  Widget _buildBasicTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 基础信息
        _buildSectionCard(
          isDark: isDark,
          title: '基础信息',
          children: [
            _buildTextField(
              isDark: isDark,
              label: '名称',
              controller: _nameController,
              hint: '输入助手名称',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              isDark: isDark,
              label: '描述',
              controller: _descriptionController,
              hint: '输入助手描述（可选）',
              maxLines: 2,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 参数配置
        _buildSectionCard(
          isDark: isDark,
          title: '参数配置',
          children: [
            _buildSlider(
              isDark: isDark,
              label: '温度 (Temperature)',
              value: _temperature,
              min: 0.0,
              max: 2.0,
              divisions: 20,
              onChanged: (value) {
                setState(() => _temperature = value);
                _saveAssistant();
              },
              description: '控制输出的随机性，值越高越随机',
            ),
            const SizedBox(height: 20),
            _buildSlider(
              isDark: isDark,
              label: 'Top P',
              value: _topP,
              min: 0.0,
              max: 1.0,
              divisions: 20,
              onChanged: (value) {
                setState(() => _topP = value);
                _saveAssistant();
              },
              description: '控制输出的多样性，值越高越多样',
            ),
            const SizedBox(height: 20),
            _buildIntSlider(
              isDark: isDark,
              label: '上下文消息数量',
              value: _contextMessageCount,
              min: 1,
              max: 50,
              onChanged: (value) {
                setState(() => _contextMessageCount = value.toInt());
                _saveAssistant();
              },
              description: '对话历史中包含的消息数量',
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 输出配置
        _buildSectionCard(
          isDark: isDark,
          title: '输出配置',
          children: [
            _buildSwitch(
              isDark: isDark,
              label: '流式输出',
              value: _streamOutput,
              onChanged: (value) {
                setState(() => _streamOutput = value);
                _saveAssistant();
              },
              description: '启用后将实时显示生成的内容',
            ),
          ],
        ),
      ],
    );
  }

  /// 提示词Tab - 系统提示词
  Widget _buildPromptTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionCard(
          isDark: isDark,
          title: '系统提示词',
          children: [
            Text(
              '定义助手的行为和角色',
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.gray500,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _systemPromptController,
              maxLines: 15,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? AppTheme.gray100 : AppTheme.gray900,
              ),
              decoration: InputDecoration(
                hintText: '输入系统提示词...\n\n例如：你是一个专业的编程助手，擅长各种编程语言。',
                hintStyle: TextStyle(color: AppTheme.gray500),
                filled: true,
                fillColor: isDark
                    ? AppTheme.gray800.withValues(alpha: 0.3)
                    : AppTheme.gray100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 记忆Tab - 启用记忆、参考历史聊天、管理记忆
  Widget _buildMemoryTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 记忆开关
        _buildSectionCard(
          isDark: isDark,
          title: '记忆设置',
          children: [
            _buildSwitch(
              isDark: isDark,
              label: '启用记忆',
              value: _enableMemory,
              onChanged: (value) {
                setState(() => _enableMemory = value);
                _saveAssistant();
              },
              description: '允许助手记住重要信息',
            ),
            const SizedBox(height: 16),
            _buildSwitch(
              isDark: isDark,
              label: '参考历史聊天记录',
              value: _useHistoryChat,
              onChanged: (value) {
                setState(() => _useHistoryChat = value);
                _saveAssistant();
              },
              description: '在生成回复时参考历史对话',
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 管理记忆
        _buildSectionCard(
          isDark: isDark,
          title: '管理记忆',
          children: [
            if (_memories.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    '暂无记忆内容',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.gray500,
                    ),
                  ),
                ),
              )
            else
              ..._memories.asMap().entries.map((entry) {
                final index = entry.key;
                final memory = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppTheme.gray800.withValues(alpha: 0.3)
                        : AppTheme.gray100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          memory,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppTheme.gray200 : AppTheme.gray800,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _memories.removeAt(index);
                          });
                          _saveAssistant();
                        },
                        icon: Icon(
                          Symbols.delete,
                          size: 20,
                          color: AppTheme.gray500,
                        ),
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(4),
                      ),
                    ],
                  ),
                );
              }),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showAddMemoryDialog(isDark),
                icon: const Icon(Symbols.add, size: 20),
                label: const Text('添加记忆'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryColor,
                  side: BorderSide(color: AppTheme.primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 快捷短语Tab
  Widget _buildQuickPhrasesTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionCard(
          isDark: isDark,
          title: '助手专属快捷短语',
          children: [
            Text(
              '为该助手创建专属的快捷短语',
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.gray500,
              ),
            ),
            const SizedBox(height: 12),
            if (_quickPhrases.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    '暂无快捷短语',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.gray500,
                    ),
                  ),
                ),
              )
            else
              ..._quickPhrases.asMap().entries.map((entry) {
                final index = entry.key;
                final phrase = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppTheme.gray800.withValues(alpha: 0.3)
                        : AppTheme.gray100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          phrase,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppTheme.gray200 : AppTheme.gray800,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _showEditPhraseDialog(isDark, index),
                        icon: Icon(
                          Symbols.edit,
                          size: 20,
                          color: AppTheme.gray500,
                        ),
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(4),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _quickPhrases.removeAt(index);
                          });
                          _saveAssistant();
                        },
                        icon: Icon(
                          Symbols.delete,
                          size: 20,
                          color: AppTheme.gray500,
                        ),
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(4),
                      ),
                    ],
                  ),
                );
              }),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showAddPhraseDialog(isDark),
                icon: const Icon(Symbols.add, size: 20),
                label: const Text('添加快捷短语'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryColor,
                  side: BorderSide(color: AppTheme.primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 通用输入对话框
  void _showInputDialog({
    required bool isDark,
    required String title,
    required String hint,
    required String confirmText,
    String initialValue = '',
    required void Function(String value) onConfirm,
  }) {
    final controller = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? AppTheme.cardDark : AppTheme.cardLight,
        title: Text(
          title,
          style: TextStyle(color: isDark ? AppTheme.gray100 : AppTheme.gray900),
        ),
        content: TextField(
          controller: controller,
          maxLines: 3,
          autofocus: true,
          style: TextStyle(color: isDark ? AppTheme.gray100 : AppTheme.gray900),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppTheme.gray500),
            filled: true,
            fillColor: isDark
                ? AppTheme.gray800.withValues(alpha: 0.3)
                : AppTheme.gray100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('取消', style: TextStyle(color: AppTheme.gray500)),
          ),
          TextButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                onConfirm(text);
              }
              Navigator.pop(ctx);
            },
            child: Text(confirmText, style: TextStyle(color: AppTheme.primaryColor)),
          ),
        ],
      ),
    );
  }

  void _showAddMemoryDialog(bool isDark) => _showInputDialog(
        isDark: isDark,
        title: '添加记忆',
        hint: '输入要记住的内容...',
        confirmText: '添加',
        onConfirm: (value) {
          setState(() => _memories.add(value));
          _saveAssistant();
        },
      );

  void _showAddPhraseDialog(bool isDark) => _showInputDialog(
        isDark: isDark,
        title: '添加快捷短语',
        hint: '输入快捷短语内容...',
        confirmText: '添加',
        onConfirm: (value) {
          setState(() => _quickPhrases.add(value));
          _saveAssistant();
        },
      );

  void _showEditPhraseDialog(bool isDark, int index) => _showInputDialog(
        isDark: isDark,
        title: '编辑快捷短语',
        hint: '输入快捷短语内容...',
        confirmText: '保存',
        initialValue: _quickPhrases[index],
        onConfirm: (value) {
          setState(() => _quickPhrases[index] = value);
          _saveAssistant();
        },
      );

  // ============ 公共组件 ============

  Widget _buildSectionCard({
    required bool isDark,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : AppTheme.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              isDark ? AppTheme.gray800.withValues(alpha: 0.3) : AppTheme.gray200,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? AppTheme.gray100 : AppTheme.gray900,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required bool isDark,
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? AppTheme.gray300 : AppTheme.gray700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? AppTheme.gray100 : AppTheme.gray900,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppTheme.gray500),
            filled: true,
            fillColor: isDark
                ? AppTheme.gray800.withValues(alpha: 0.3)
                : AppTheme.gray100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildSlider({
    required bool isDark,
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? AppTheme.gray300 : AppTheme.gray700,
              ),
            ),
            Text(
              value.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          activeColor: AppTheme.primaryColor,
          onChanged: onChanged,
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.gray500,
          ),
        ),
      ],
    );
  }

  Widget _buildIntSlider({
    required bool isDark,
    required String label,
    required int value,
    required int min,
    required int max,
    required ValueChanged<double> onChanged,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? AppTheme.gray300 : AppTheme.gray700,
              ),
            ),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: value.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: max - min,
          activeColor: AppTheme.primaryColor,
          onChanged: onChanged,
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.gray500,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch({
    required bool isDark,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    required String description,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.gray500,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          activeColor: AppTheme.primaryColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
