import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:material_symbols_icons/symbols.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import '../theme/app_theme.dart';
import '../models/assistant.dart';
import '../providers/assistant_provider.dart';

/// 助手详情编辑页面
class AssistantEditPage extends StatefulWidget {
  final String assistantId;

  const AssistantEditPage({super.key, required this.assistantId});

  @override
  State<AssistantEditPage> createState() => _AssistantEditPageState();
}

class _AssistantEditPageState extends State<AssistantEditPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _systemPromptController;
  late double _temperature;
  late double _topP;
  late int _contextMessageCount;
  late bool _streamOutput;

  @override
  void initState() {
    super.initState();
    final assistantProvider = provider.Provider.of<AssistantProvider>(context, listen: false);
    final assistant = assistantProvider.getById(widget.assistantId);

    if (assistant != null) {
      _nameController = TextEditingController(text: assistant.name);
      _descriptionController = TextEditingController(text: assistant.description ?? '');
      _systemPromptController = TextEditingController(text: assistant.systemPrompt);
      _temperature = assistant.temperature;
      _topP = assistant.topP;
      _contextMessageCount = assistant.contextMessageCount;
      _streamOutput = assistant.streamOutput;
    } else {
      _nameController = TextEditingController();
      _descriptionController = TextEditingController();
      _systemPromptController = TextEditingController();
      _temperature = 0.7;
      _topP = 1.0;
      _contextMessageCount = 10;
      _streamOutput = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _systemPromptController.dispose();
    super.dispose();
  }

  void _saveAssistant() {
    final assistantProvider = provider.Provider.of<AssistantProvider>(context, listen: false);
    final assistant = assistantProvider.getById(widget.assistantId);

    if (assistant != null) {
      final updatedAssistant = assistant.copyWith(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        systemPrompt: _systemPromptController.text,
        temperature: _temperature,
        topP: _topP,
        contextMessageCount: _contextMessageCount,
        streamOutput: _streamOutput,
      );

      assistantProvider.updateAssistant(updatedAssistant);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final assistantProvider = provider.Provider.of<AssistantProvider>(context);
    final assistant = assistantProvider.getById(widget.assistantId);

    if (assistant == null) {
      return Scaffold(
        backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
        appBar: AppBar(
          backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Symbols.arrow_back, color: isDark ? AppTheme.gray100 : AppTheme.gray900),
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
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Symbols.arrow_back, color: isDark ? AppTheme.gray100 : AppTheme.gray900),
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
        actions: [
          TextButton(
            onPressed: _saveAssistant,
            child: Text(
              '保存',
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
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

          // 系统提示词
          _buildSectionCard(
            isDark: isDark,
            title: '系统提示词',
            children: [
              _buildTextField(
                isDark: isDark,
                label: '提示词',
                controller: _systemPromptController,
                hint: '输入系统提示词，定义助手的行为和角色',
                maxLines: 8,
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
                onChanged: (value) => setState(() => _temperature = value),
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
                onChanged: (value) => setState(() => _topP = value),
                description: '控制输出的多样性，值越高越多样',
              ),
              const SizedBox(height: 20),
              _buildIntSlider(
                isDark: isDark,
                label: '上下文消息数量',
                value: _contextMessageCount,
                min: 1,
                max: 50,
                onChanged: (value) => setState(() => _contextMessageCount = value.toInt()),
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
                onChanged: (value) => setState(() => _streamOutput = value),
                description: '启用后将实时显示生成的内容',
              ),
            ],
          ),
        ],
      ),
    );
  }

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
          color: isDark ? AppTheme.gray800.withValues(alpha: 0.3) : AppTheme.gray200,
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
            fillColor: isDark ? AppTheme.gray800.withValues(alpha: 0.3) : AppTheme.gray100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
