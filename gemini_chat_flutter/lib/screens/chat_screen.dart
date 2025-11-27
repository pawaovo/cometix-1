import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import '../models/message.dart';
import '../providers/messages_provider.dart';
import '../providers/quick_phrases_provider.dart';
import '../providers/gemini_service_provider.dart';
import '../widgets/input_bar.dart';
import '../theme/app_theme.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final VoidCallback onMenuClick;

  const ChatScreen({
    super.key,
    required this.onMenuClick,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _handleSend(String text) async {
    if (text.trim().isEmpty || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Add user message
    final userMessage = Message(role: 'user', text: text);
    ref.read(messagesProvider.notifier).addMessage(userMessage);

    // Scroll to bottom after adding user message
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    // Add placeholder assistant message
    ref.read(messagesProvider.notifier).addMessage(
          const Message(role: 'model', text: ''),
        );

    // Get messages history
    final messages = ref.read(messagesProvider);
    final history = messages.sublist(0, messages.length - 1);

    // Stream response from Gemini
    final geminiService = ref.read(geminiServiceProvider);
    String fullResponse = '';

    try {
      await for (final chunk in geminiService.sendMessageStream(
        history: history,
        newMessage: text,
      )) {
        fullResponse += chunk;
        ref.read(messagesProvider.notifier).updateLastMessage(fullResponse);

        // Scroll to bottom as new content arrives
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
    } catch (e) {
      ref.read(messagesProvider.notifier).updateLastMessage(
            '抱歉，处理您的请求时遇到错误：$e',
          );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesProvider);
    final quickPhrases = ref.watch(quickPhrasesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: (isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight)
                  .withValues(alpha: 0.9),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppTheme.gray800 : AppTheme.gray200,
                  width: 0.5,
                ),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  // Menu Button
                  shadcn.IconButton.ghost(
                    onPressed: widget.onMenuClick,
                    icon: Icon(
                      Symbols.menu,
                      size: 32,
                      color: isDark ? AppTheme.gray200 : AppTheme.gray800,
                    ),
                  ),

                  // Title
                  Expanded(
                    child: Center(
                      child: Text(
                        messages.isEmpty ? '新对话' : 'Gemini 2.5',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                        ),
                      ),
                    ),
                  ),

                  // Map Button
                  shadcn.IconButton.ghost(
                    onPressed: () {},
                    icon: Icon(
                      Symbols.map,
                      size: 32,
                      color: isDark ? AppTheme.gray200 : AppTheme.gray800,
                    ),
                  ),

                  // New Chat Button
                  shadcn.IconButton.ghost(
                    onPressed: () {
                      ref.read(messagesProvider.notifier).clearMessages();
                    },
                    icon: Icon(
                      Symbols.add_circle,
                      size: 32,
                      color: isDark ? AppTheme.gray200 : AppTheme.gray800,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Messages Area
          Expanded(
            child: messages.isEmpty
                ? _buildEmptyState(isDark)
                : _buildMessagesList(messages, isDark),
          ),

          // Input Bar
          InputBar(
            onSend: _handleSend,
            disabled: _isLoading,
            quickPhrases: quickPhrases,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: isDark ? AppTheme.gray800 : AppTheme.gray100,
              borderRadius: BorderRadius.circular(48),
            ),
            child: Icon(
              Symbols.smart_toy,
              size: 60,
              color: isDark ? AppTheme.gray600 : AppTheme.gray300,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '开始一个新的对话',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDark ? AppTheme.gray400 : AppTheme.gray400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList(List<Message> messages, bool isDark) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isUser = message.role == 'user';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.85,
                  ),
                  child: shadcn.Card(
                    filled: isUser,
                    fillColor: isUser
                        ? (isDark ? AppTheme.gray800 : AppTheme.gray100)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16).copyWith(
                      bottomRight: isUser ? Radius.zero : const Radius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    child: message.text.isEmpty && message.role == 'model'
                        ? _buildLoadingIndicator()
                        : isUser
                            ? Text(
                                message.text,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                ),
                              )
                            : MarkdownBody(
                                data: message.text,
                                styleSheet: MarkdownStyleSheet(
                                  p: TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    color: isDark ? AppTheme.gray200 : AppTheme.gray800,
                                  ),
                                  code: TextStyle(
                                    backgroundColor:
                                        isDark ? AppTheme.gray800 : AppTheme.gray100,
                                    color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                  ),
                                  codeblockDecoration: BoxDecoration(
                                    color: isDark ? AppTheme.gray800 : AppTheme.gray100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(0),
        const SizedBox(width: 4),
        _buildDot(150),
        const SizedBox(width: 4),
        _buildDot(300),
      ],
    );
  }

  Widget _buildDot(int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppTheme.gray400,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
