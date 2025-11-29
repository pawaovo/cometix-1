import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:material_symbols_icons/symbols.dart';
import 'package:uuid/uuid.dart';
import '../theme/app_theme.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_widgets.dart';
import '../models/mcp_config.dart';

/// MCP 设置页面
class MCPSettingsPage extends StatelessWidget {
  final VoidCallback onBack;

  const MCPSettingsPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = provider.Provider.of<SettingsProvider>(context);
    final servers = settings.mcpServers;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: 'MCP 服务器', onBack: onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 添加按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MCP 服务器列表',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Symbols.add, size: 20),
                        onPressed: () => _showAddServerDialog(context, settings),
                        tooltip: '添加 MCP 服务器',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 服务器列表
                  if (servers.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          '暂无 MCP 服务器\n点击右上角添加',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppTheme.gray500 : AppTheme.gray400,
                          ),
                        ),
                      ),
                    )
                  else
                    ...servers.asMap().entries.map((entry) {
                      final index = entry.key;
                      final server = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _MCPServerCard(
                          server: server,
                          onEdit: () => _showEditServerDialog(context, settings, server, index),
                          onDelete: () => _deleteServer(context, settings, index),
                          onToggle: (enabled) {
                            final updated = server.copyWith(enabled: enabled);
                            settings.updateMcpServer(index, updated);
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

  void _deleteServer(BuildContext context, SettingsProvider settings, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除此 MCP 服务器吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              settings.removeMcpServer(index);
              Navigator.pop(ctx);
            },
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  void _showAddServerDialog(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (ctx) => _AddMCPServerDialog(
        onAdd: (server) {
          settings.addMcpServer(server);
        },
      ),
    );
  }

  void _showEditServerDialog(BuildContext context, SettingsProvider settings, MCPServerConfig server, int index) {
    showDialog(
      context: context,
      builder: (ctx) => _EditMCPServerDialog(
        server: server,
        onSave: (updated) {
          settings.updateMcpServer(index, updated);
        },
      ),
    );
  }
}

/// MCP 服务器卡片
class _MCPServerCard extends StatelessWidget {
  final MCPServerConfig server;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(bool) onToggle;

  const _MCPServerCard({
    required this.server,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color statusColor;
    String statusText;
    switch (server.status) {
      case 'running':
        statusColor = Colors.green;
        statusText = '运行中';
        break;
      case 'error':
        statusColor = Colors.red;
        statusText = '错误';
        break;
      default:
        statusColor = isDark ? AppTheme.gray500 : AppTheme.gray400;
        statusText = '已停止';
    }

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
                child: const Center(
                  child: Icon(Symbols.hub, size: 18, color: AppTheme.primaryColor),
                ),
              ),
              const SizedBox(width: 12),

              // 名称和状态
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      server.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 12,
                            color: statusColor,
                          ),
                        ),
                        if (server.tools.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(
                            '· ${server.tools.length} 个工具',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // 开关
              shadcn.Switch(
                value: server.enabled,
                onChanged: onToggle,
              ),
            ],
          ),

          if (server.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              server.description,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? AppTheme.gray400 : AppTheme.gray600,
              ),
            ),
          ],

          if (server.command.isNotEmpty) ...[
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
                    Symbols.terminal,
                    size: 14,
                    color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '${server.command} ${server.args.join(' ')}',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
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

/// 添加 MCP 服务器对话框
class _AddMCPServerDialog extends StatefulWidget {
  final Function(MCPServerConfig) onAdd;

  const _AddMCPServerDialog({required this.onAdd});

  @override
  State<_AddMCPServerDialog> createState() => _AddMCPServerDialogState();
}

class _AddMCPServerDialogState extends State<_AddMCPServerDialog> {
  final _nameController = TextEditingController();
  final _commandController = TextEditingController();
  final _argsController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _commandController.dispose();
    _argsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('添加 MCP 服务器'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '服务器名称',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _commandController,
              decoration: const InputDecoration(
                labelText: '启动命令',
                border: OutlineInputBorder(),
                hintText: '例如: node',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _argsController,
              decoration: const InputDecoration(
                labelText: '命令参数（空格分隔）',
                border: OutlineInputBorder(),
                hintText: '例如: server.js --port 3000',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: '描述（可选）',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
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
            final name = _nameController.text.trim();
            final command = _commandController.text.trim();

            if (name.isEmpty || command.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('请填写服务器名称和启动命令')),
              );
              return;
            }

            final args = _argsController.text.trim().split(' ').where((s) => s.isNotEmpty).toList();

            final server = MCPServerConfig(
              id: const Uuid().v4(),
              name: name,
              command: command,
              args: args,
              description: _descriptionController.text.trim(),
              enabled: true,
            );

            widget.onAdd(server);
            Navigator.pop(context);
          },
          child: const Text('添加'),
        ),
      ],
    );
  }
}

/// 编辑 MCP 服务器对话框
class _EditMCPServerDialog extends StatefulWidget {
  final MCPServerConfig server;
  final Function(MCPServerConfig) onSave;

  const _EditMCPServerDialog({required this.server, required this.onSave});

  @override
  State<_EditMCPServerDialog> createState() => _EditMCPServerDialogState();
}

class _EditMCPServerDialogState extends State<_EditMCPServerDialog> {
  late TextEditingController _nameController;
  late TextEditingController _commandController;
  late TextEditingController _argsController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.server.name);
    _commandController = TextEditingController(text: widget.server.command);
    _argsController = TextEditingController(text: widget.server.args.join(' '));
    _descriptionController = TextEditingController(text: widget.server.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _commandController.dispose();
    _argsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('编辑 ${widget.server.name}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '服务器名称',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _commandController,
              decoration: const InputDecoration(
                labelText: '启动命令',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _argsController,
              decoration: const InputDecoration(
                labelText: '命令参数（空格分隔）',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: '描述',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
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
            final name = _nameController.text.trim();
            final command = _commandController.text.trim();

            if (name.isEmpty || command.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('请填写服务器名称和启动命令')),
              );
              return;
            }

            final args = _argsController.text.trim().split(' ').where((s) => s.isNotEmpty).toList();

            final updated = widget.server.copyWith(
              name: name,
              command: command,
              args: args,
              description: _descriptionController.text.trim(),
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
