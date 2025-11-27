import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import '../models/quick_phrase.dart';
import '../theme/app_theme.dart';

enum ActiveTool { history, model, mcp, quick }

class InputBar extends StatefulWidget {
  final Function(String) onSend;
  final bool disabled;
  final List<QuickPhrase> quickPhrases;

  const InputBar({
    super.key,
    required this.onSend,
    required this.disabled,
    required this.quickPhrases,
  });

  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isMenuExpanded = false;
  ActiveTool? _activeTool;
  QuickPhrase? _suggestion;

  // Mock data
  final List<String> _historyItems = ['上次对话', '关于 React Hooks', '翻译任务', '代码调试'];
  final List<String> _modelItems = [
    'Gemini 2.5 Flash',
    'Gemini 1.5 Pro',
    'GPT-4o',
    'Claude 3.5 Sonnet'
  ];
  final List<String> _mcpItems = [
    'fetch_html',
    'fetch_json',
    'web_search',
    'code_interpreter'
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_activeTool == ActiveTool.quick) return;

    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() => _suggestion = null);
      return;
    }

    // Check for exact match with shortcuts
    final match = widget.quickPhrases.cast<QuickPhrase?>().firstWhere(
          (qp) => qp?.shortcut == text,
          orElse: () => null,
        );

    setState(() => _suggestion = match);
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      setState(() {
        _activeTool = null;
        _isMenuExpanded = false;
      });
    }
  }

  void _handleSubmit() {
    if (_controller.text.trim().isEmpty || widget.disabled) return;

    widget.onSend(_controller.text);
    _controller.clear();
    setState(() {
      _suggestion = null;
      _activeTool = null;
    });
  }

  void _toggleTool(ActiveTool tool) {
    setState(() {
      if (_activeTool == tool) {
        _activeTool = null;
      } else {
        _activeTool = tool;
        _isMenuExpanded = false;
      }
    });
  }

  void _applySuggestion(QuickPhrase phrase) {
    _controller.text = phrase.phrase;
    setState(() {
      _suggestion = null;
      _activeTool = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // Backdrop
        if (_isMenuExpanded || _activeTool != null)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isMenuExpanded = false;
                  _activeTool = null;
                });
              },
              child: Container(color: Colors.transparent),
            ),
          ),

        // Main Input Bar
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tool Popups
            if (_activeTool != null || _suggestion != null)
              _buildToolPopup(isDark),

            // Top Icons Row
            _buildTopIconsRow(isDark),

            // Bottom Input Row
            _buildInputRow(isDark),

            // Home Indicator
            _buildHomeIndicator(isDark),
          ],
        ),
      ],
    );
  }

  Widget _buildToolPopup(bool isDark) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : AppTheme.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppTheme.gray800 : AppTheme.gray100,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      constraints: const BoxConstraints(maxHeight: 240),
      child: _buildPopupContent(isDark),
    );
  }

  Widget _buildPopupContent(bool isDark) {
    if (_activeTool == ActiveTool.history) {
      return _buildListPopup(
        title: '最近对话',
        items: _historyItems,
        icon: Symbols.chat_bubble_outline,
        iconColor: AppTheme.gray500,
        isDark: isDark,
      );
    } else if (_activeTool == ActiveTool.model) {
      return _buildListPopup(
        title: '切换模型',
        items: _modelItems,
        icon: Symbols.smart_toy,
        iconColor: Colors.blue,
        isDark: isDark,
        showCheck: true,
      );
    } else if (_activeTool == ActiveTool.mcp) {
      return _buildListPopup(
        title: 'MCP 工具',
        items: _mcpItems,
        icon: Symbols.construction,
        iconColor: Colors.orange,
        isDark: isDark,
        showStatus: true,
      );
    } else if (_activeTool == ActiveTool.quick) {
      return _buildQuickPhrasesPopup(isDark);
    } else if (_suggestion != null) {
      return _buildSuggestionChip(_suggestion!, isDark);
    }

    return const SizedBox.shrink();
  }

  Widget _buildListPopup({
    required String title,
    required List<String> items,
    required IconData icon,
    required Color iconColor,
    required bool isDark,
    bool showCheck = false,
    bool showStatus = false,
  }) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.gray500,
            ),
          ),
        ),
        ...items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Icon(icon, size: 20, color: iconColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                        ),
                      ),
                    ),
                    if (showCheck && index == 0)
                      const Icon(Symbols.check, size: 20, color: Colors.blue),
                    if (showStatus)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildQuickPhrasesPopup(bool isDark) {
    if (widget.quickPhrases.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            '暂无快捷短语',
            style: TextStyle(color: AppTheme.gray500, fontSize: 14),
          ),
        ),
      );
    }

    return ListView(
      shrinkWrap: true,
      children: widget.quickPhrases.map((qp) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _applySuggestion(qp),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Symbols.bolt, size: 20, color: AppTheme.accentBrown),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          qp.phrase,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                          ),
                        ),
                        Text(
                          '/${qp.shortcut}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.gray500,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSuggestionChip(QuickPhrase phrase, bool isDark) {
    return Material(
      color: AppTheme.accentBrown,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _applySuggestion(phrase),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Symbols.bolt, size: 20, color: Colors.white),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  phrase.phrase,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopIconsRow(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          _buildToolButton(
            icon: Symbols.history,
            tool: ActiveTool.history,
            tooltip: '上次对话',
            isDark: isDark,
          ),
          const SizedBox(width: 24),
          _buildToolButton(
            icon: Symbols.smart_toy,
            tool: ActiveTool.model,
            tooltip: '模型',
            isDark: isDark,
          ),
          const SizedBox(width: 24),
          _buildToolButton(
            icon: Symbols.construction,
            tool: ActiveTool.mcp,
            tooltip: 'MCP 工具',
            isDark: isDark,
          ),
          const SizedBox(width: 24),
          _buildToolButton(
            icon: Symbols.bolt,
            tool: ActiveTool.quick,
            tooltip: '快捷短语',
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required ActiveTool tool,
    required String tooltip,
    required bool isDark,
  }) {
    final isActive = _activeTool == tool;
    return shadcn.IconButton.ghost(
      onPressed: () => _toggleTool(tool),
      icon: Icon(
        icon,
        size: 26,
        color: isActive
            ? (isDark ? AppTheme.gray100 : AppTheme.gray900)
            : (isDark ? AppTheme.gray400 : AppTheme.gray500),
      ),
    );
  }

  Widget _buildInputRow(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.gray800 : AppTheme.gray100,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? AppTheme.gray700 : AppTheme.gray200,
        ),
      ),
      child: Row(
        children: [
          // Expandable Media Menu
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: _isMenuExpanded
                ? BoxDecoration(
                    color: isDark ? AppTheme.gray700 : AppTheme.gray200,
                    borderRadius: BorderRadius.circular(20),
                  )
                : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isMenuExpanded)
                  shadcn.IconButton.ghost(
                    onPressed: () {
                      setState(() {
                        _isMenuExpanded = true;
                        _activeTool = null;
                      });
                    },
                    icon: Icon(
                      Symbols.add_circle,
                      size: 24,
                      color: isDark ? AppTheme.gray400 : AppTheme.gray500,
                    ),
                  )
                else ...[
                  shadcn.IconButton.ghost(
                    onPressed: () {},
                    icon: Icon(
                      Symbols.camera_alt,
                      size: 20,
                      color: isDark ? AppTheme.gray300 : AppTheme.gray600,
                    ),
                  ),
                  shadcn.IconButton.ghost(
                    onPressed: () {},
                    icon: Icon(
                      Symbols.image,
                      size: 20,
                      color: isDark ? AppTheme.gray300 : AppTheme.gray600,
                    ),
                  ),
                  shadcn.IconButton.ghost(
                    onPressed: () {},
                    icon: Icon(
                      Symbols.folder,
                      size: 20,
                      color: isDark ? AppTheme.gray300 : AppTheme.gray600,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Text Input
          Expanded(
            child: shadcn.TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: !widget.disabled,
              placeholder: const Text('发送消息'),
              style: TextStyle(
                fontSize: 16,
                color: isDark ? AppTheme.gray200 : AppTheme.gray700,
              ),
              border: const Border.fromBorderSide(BorderSide.none),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _handleSubmit(),
            ),
          ),

          // Send Button
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _controller.text.trim().isNotEmpty
                  ? (isDark ? Colors.white : Colors.black)
                  : (isDark ? AppTheme.gray600 : AppTheme.gray200),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: _controller.text.trim().isNotEmpty && !widget.disabled
                  ? _handleSubmit
                  : null,
              icon: Icon(
                Symbols.arrow_upward,
                size: 18,
                color: _controller.text.trim().isNotEmpty
                    ? (isDark ? Colors.black : Colors.white)
                    : (isDark ? AppTheme.gray300 : AppTheme.gray600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeIndicator(bool isDark) {
    return Container(
      width: 128,
      height: 6,
      margin: const EdgeInsets.only(top: 16, bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.gray700 : AppTheme.gray300,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
