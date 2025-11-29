import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_widgets.dart';
import '../models/provider_config.dart';

/// 服务商管理页面
class ProvidersPage extends StatelessWidget {
  final VoidCallback onBack;

  const ProvidersPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = provider.Provider.of<SettingsProvider>(context);
    final configs = settings.providerConfigs;
    final order = settings.providersOrder;

    // 按顺序获取服务商列表
    final orderedProviders = order.where((key) => configs.containsKey(key)).map((key) => configs[key]!).toList();

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '服务商', onBack: onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 添加按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '服务商列表',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Symbols.add, size: 20),
                        onPressed: () => _showAddProviderDialog(context, settings),
                        tooltip: '添加服务商',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 服务商列表
                  if (orderedProviders.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          '暂无服务商\n点击右上角添加',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppTheme.gray500 : AppTheme.gray400,
                          ),
                        ),
                      ),
                    )
                  else
                    ...orderedProviders.map((config) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _ProviderCard(
                          config: config,
                          onEdit: () => _showEditProviderDialog(context, settings, config),
                          onDelete: () => _deleteProvider(context, settings, config.key),
                          onToggle: (enabled) {
                            final updated = config.copyWith(enabled: enabled);
                            settings.setProviderConfig(config.key, updated);
                          },
                        ),
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteProvider(BuildContext context, SettingsProvider settings, String key) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除此服务商吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              settings.removeProviderConfig(key);
              Navigator.pop(ctx);
            },
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  void _showAddProviderDialog(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (ctx) => _AddProviderDialog(
        onAdd: (key, config) {
          settings.setProviderConfig(key, config);
        },
      ),
    );
  }

  void _showEditProviderDialog(BuildContext context, SettingsProvider settings, ProviderConfig config) {
    showDialog(
      context: context,
      builder: (ctx) => _EditProviderDialog(
        config: config,
        onSave: (updated) {
          settings.setProviderConfig(config.key, updated);
        },
      ),
    );
  }
}

/// 服务商卡片
class _ProviderCard extends StatelessWidget {
  final ProviderConfig config;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(bool) onToggle;

  const _ProviderCard({
    required this.config,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return shadcn.Card(
      filled: true,
      fillColor: isDark ? AppTheme.gray900.withOpacity(0.3) : Colors.white,
      borderRadius: BorderRadius.circular(16),
      borderColor: isDark ? AppTheme.gray800 : AppTheme.gray200,
      borderWidth: 1,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 图标
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    config.name.isNotEmpty ? config.name[0].toUpperCase() : '?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // 名称和状态
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      config.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${config.apiKeys.length} 个 API Key · ${config.models.length} 个模型',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                      ),
                    ),
                  ],
                ),
              ),

              // 开关
              shadcn.Switch(
                value: config.enabled,
                onChanged: onToggle,
              ),
            ],
          ),

          if (config.baseUrl.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.gray800.withOpacity(0.5) : AppTheme.gray100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Symbols.link,
                    size: 14,
                    color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      config.baseUrl,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 12),

          // 操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: onEdit,
                icon: const Icon(Symbols.edit, size: 16),
                label: const Text('编辑'),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: onDelete,
                icon: const Icon(Symbols.delete, size: 16),
                label: const Text('删除'),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 添加服务商对话框
class _AddProviderDialog extends StatefulWidget {
  final Function(String, ProviderConfig) onAdd;

  const _AddProviderDialog({required this.onAdd});

  @override
  State<_AddProviderDialog> createState() => _AddProviderDialogState();
}

class _AddProviderDialogState extends State<_AddProviderDialog> {
  String _selectedProvider = 'openai';
  final _apiKeyController = TextEditingController();
  final _baseUrlController = TextEditingController();

  final Map<String, String> _providers = {
    'openai': 'OpenAI',
    'anthropic': 'Anthropic',
    'google': 'Google',
    'gemini': 'Gemini',
    'groq': 'Groq',
    'deepseek': 'DeepSeek',
    'moonshot': 'Moonshot',
    'zhipu': 'Zhipu AI',
  };

  @override
  void dispose() {
    _apiKeyController.dispose();
    _baseUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('添加服务商'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedProvider,
              decoration: const InputDecoration(labelText: '服务商'),
              items: _providers.entries
                  .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedProvider = value!),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _apiKeyController,
              decoration: const InputDecoration(
                labelText: 'API Key',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _baseUrlController,
              decoration: const InputDecoration(
                labelText: 'Base URL (可选)',
                border: OutlineInputBorder(),
                hintText: '留空使用默认地址',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            final apiKey = _apiKeyController.text.trim();
            if (apiKey.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('请输入 API Key')),
              );
              return;
            }

            final config = ProviderConfig.defaultsFor(_selectedProvider).copyWith(
              apiKeys: [apiKey],
              baseUrl: _baseUrlController.text.trim(),
            );

            widget.onAdd(_selectedProvider, config);
            Navigator.pop(context);
          },
          child: const Text('添加'),
        ),
      ],
    );
  }
}

/// 编辑服务商对话框
class _EditProviderDialog extends StatefulWidget {
  final ProviderConfig config;
  final Function(ProviderConfig) onSave;

  const _EditProviderDialog({required this.config, required this.onSave});

  @override
  State<_EditProviderDialog> createState() => _EditProviderDialogState();
}

class _EditProviderDialogState extends State<_EditProviderDialog> {
  late TextEditingController _nameController;
  late TextEditingController _baseUrlController;
  late List<TextEditingController> _apiKeyControllers;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.config.name);
    _baseUrlController = TextEditingController(text: widget.config.baseUrl);
    _apiKeyControllers = widget.config.apiKeys.map((key) => TextEditingController(text: key)).toList();
    if (_apiKeyControllers.isEmpty) {
      _apiKeyControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _baseUrlController.dispose();
    for (final controller in _apiKeyControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('编辑 ${widget.config.name}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '显示名称',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _baseUrlController,
              decoration: const InputDecoration(
                labelText: 'Base URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('API Keys', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ..._apiKeyControllers.asMap().entries.map((entry) {
              final index = entry.key;
              final controller = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: 'API Key ${index + 1}',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    if (_apiKeyControllers.length > 1)
                      IconButton(
                        icon: const Icon(Symbols.delete, size: 18),
                        onPressed: () {
                          setState(() {
                            controller.dispose();
                            _apiKeyControllers.removeAt(index);
                          });
                        },
                      ),
                  ],
                ),
              );
            }),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _apiKeyControllers.add(TextEditingController());
                });
              },
              icon: const Icon(Symbols.add, size: 16),
              label: const Text('添加 API Key'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            final apiKeys = _apiKeyControllers.map((c) => c.text.trim()).where((k) => k.isNotEmpty).toList();

            if (apiKeys.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('至少需要一个 API Key')),
              );
              return;
            }

            final updated = widget.config.copyWith(
              name: _nameController.text.trim(),
              baseUrl: _baseUrlController.text.trim(),
              apiKeys: apiKeys,
            );

            widget.onSave(updated);
            Navigator.pop(context);
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
