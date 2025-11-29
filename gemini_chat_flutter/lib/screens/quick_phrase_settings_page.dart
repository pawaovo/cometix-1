import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:material_symbols_icons/symbols.dart';
import 'package:uuid/uuid.dart';
import '../theme/app_theme.dart';
import '../providers/quick_phrases_provider.dart';
import '../widgets/settings_widgets.dart';
import '../models/quick_phrase.dart';

/// 快捷短语设置页面
class QuickPhraseSettingsPage extends ConsumerWidget {
  final VoidCallback onBack;

  const QuickPhraseSettingsPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final phrases = ref.watch(quickPhrasesProvider);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '快捷短语', onBack: onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 添加按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '快捷短语列表',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Symbols.add, size: 20),
                        onPressed: () => _showAddPhraseDialog(context, ref),
                        tooltip: '添加快捷短语',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 快捷短语列表
                  if (phrases.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          '暂无快捷短语\n点击右上角添加',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppTheme.gray500 : AppTheme.gray400,
                          ),
                        ),
                      ),
                    )
                  else
                    ...phrases.map((phrase) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _QuickPhraseCard(
                          phrase: phrase,
                          onEdit: () => _showEditPhraseDialog(context, ref, phrase),
                          onDelete: () => _deletePhrase(context, ref, phrase.id),
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

  void _deletePhrase(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除此快捷短语吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              ref.read(quickPhrasesProvider.notifier).deletePhrase(id);
              Navigator.pop(ctx);
            },
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  void _showAddPhraseDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => _AddQuickPhraseDialog(
        onAdd: (phrase) {
          ref.read(quickPhrasesProvider.notifier).addPhrase(phrase);
        },
      ),
    );
  }

  void _showEditPhraseDialog(BuildContext context, WidgetRef ref, QuickPhrase phrase) {
    showDialog(
      context: context,
      builder: (ctx) => _EditQuickPhraseDialog(
        phrase: phrase,
        onSave: (updated) {
          ref.read(quickPhrasesProvider.notifier).updatePhrase(updated);
        },
      ),
    );
  }
}

/// 快捷短语卡片
class _QuickPhraseCard extends StatelessWidget {
  final QuickPhrase phrase;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _QuickPhraseCard({
    required this.phrase,
    required this.onEdit,
    required this.onDelete,
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
              // 快捷键标签
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  phrase.shortcut,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              const Spacer(),

              // 操作按钮
              IconButton(
                icon: const Icon(Symbols.edit, size: 18),
                onPressed: onEdit,
                tooltip: '编辑',
              ),
              IconButton(
                icon: const Icon(Symbols.delete, size: 18),
                onPressed: onDelete,
                tooltip: '删除',
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 短语内容
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.gray800.withOpacity(0.5) : AppTheme.gray100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              phrase.phrase,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? AppTheme.gray100 : AppTheme.gray900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 添加快捷短语对话框
class _AddQuickPhraseDialog extends StatefulWidget {
  final Function(QuickPhrase) onAdd;

  const _AddQuickPhraseDialog({required this.onAdd});

  @override
  State<_AddQuickPhraseDialog> createState() => _AddQuickPhraseDialogState();
}

class _AddQuickPhraseDialogState extends State<_AddQuickPhraseDialog> {
  final _shortcutController = TextEditingController();
  final _phraseController = TextEditingController();

  @override
  void dispose() {
    _shortcutController.dispose();
    _phraseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('添加快捷短语'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _shortcutController,
              decoration: const InputDecoration(
                labelText: '快捷键',
                border: OutlineInputBorder(),
                hintText: '例如: 总结',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phraseController,
              decoration: const InputDecoration(
                labelText: '短语内容',
                border: OutlineInputBorder(),
                hintText: '例如: 请帮我总结一下这段内容',
              ),
              maxLines: 4,
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
            final shortcut = _shortcutController.text.trim();
            final phrase = _phraseController.text.trim();

            if (shortcut.isEmpty || phrase.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('请填写快捷键和短语内容')),
              );
              return;
            }

            final newPhrase = QuickPhrase(
              id: const Uuid().v4(),
              shortcut: shortcut,
              phrase: phrase,
            );

            widget.onAdd(newPhrase);
            Navigator.pop(context);
          },
          child: const Text('添加'),
        ),
      ],
    );
  }
}

/// 编辑快捷短语对话框
class _EditQuickPhraseDialog extends StatefulWidget {
  final QuickPhrase phrase;
  final Function(QuickPhrase) onSave;

  const _EditQuickPhraseDialog({required this.phrase, required this.onSave});

  @override
  State<_EditQuickPhraseDialog> createState() => _EditQuickPhraseDialogState();
}

class _EditQuickPhraseDialogState extends State<_EditQuickPhraseDialog> {
  late TextEditingController _shortcutController;
  late TextEditingController _phraseController;

  @override
  void initState() {
    super.initState();
    _shortcutController = TextEditingController(text: widget.phrase.shortcut);
    _phraseController = TextEditingController(text: widget.phrase.phrase);
  }

  @override
  void dispose() {
    _shortcutController.dispose();
    _phraseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('编辑快捷短语'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _shortcutController,
              decoration: const InputDecoration(
                labelText: '快捷键',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phraseController,
              decoration: const InputDecoration(
                labelText: '短语内容',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
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
            final shortcut = _shortcutController.text.trim();
            final phrase = _phraseController.text.trim();

            if (shortcut.isEmpty || phrase.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('请填写快捷键和短语内容')),
              );
              return;
            }

            final updated = widget.phrase.copyWith(
              shortcut: shortcut,
              phrase: phrase,
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
