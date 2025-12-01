import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import '../theme/app_theme.dart';
import 'settings_pages.dart';
import 'backup_settings_page.dart';
import 'chat_storage_page.dart';
import 'theme_palette_page.dart';
import 'haptic_settings_page.dart';
import 'tts_settings_page.dart';

enum SettingsSubPage {
  none,
  display,
  themePalette,
  haptic,
  tts,
  assistant,
  defaultModel,
  providers,
  search,
  mcp,
  quickPhrase,
  proxy,
  backup,
  chatStorage,
  about,
  docs,
  sponsor,
}

class SettingsScreen extends StatefulWidget {
  final VoidCallback onBack;

  const SettingsScreen({
    super.key,
    required this.onBack,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsSubPage _currentSubPage = SettingsSubPage.none;

  void _navigateToSubPage(SettingsSubPage page) {
    setState(() {
      _currentSubPage = page;
    });
  }

  void _navigateBack() {
    if (_currentSubPage != SettingsSubPage.none) {
      setState(() {
        _currentSubPage = SettingsSubPage.none;
      });
    } else {
      widget.onBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Route to sub-pages
    if (_currentSubPage != SettingsSubPage.none) {
      return _buildSubPage(context, isDark);
    }

    // Main settings list
    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  shadcn.IconButton.ghost(
                    onPressed: widget.onBack,
                    icon: Icon(
                      Symbols.arrow_back,
                      color: isDark ? AppTheme.gray200 : AppTheme.gray800,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '设置',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                    ),
                  ),
                ],
              ),
            ),

            // Settings Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 显示 section
                  _buildSection(
                    context,
                    items: [
                      _buildSettingItem(
                        context,
                        icon: Symbols.display_settings,
                        title: '显示',
                        value: '跟随系统',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.display),
                      ),
                      _buildDivider(isDark),
                      _buildSettingItem(
                        context,
                        icon: Symbols.palette,
                        title: '主题色板',
                        value: '默认',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.themePalette),
                      ),
                      _buildDivider(isDark),
                      _buildSettingItem(
                        context,
                        icon: Symbols.vibration,
                        title: '触感反馈',
                        value: '中等',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.haptic),
                      ),
                      _buildDivider(isDark),
                      _buildSettingItem(
                        context,
                        icon: Symbols.volume_up,
                        title: '语音朗读',
                        value: '关',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.tts),
                      ),
                      _buildDivider(isDark),
                      _buildSettingItem(
                        context,
                        icon: Symbols.help,
                        title: '助手',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.assistant),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 模型与服务 section
                  _buildSectionTitle('模型与服务', isDark),
                  const SizedBox(height: 8),
                  _buildSection(
                    context,
                    items: [
                      _buildSettingItem(
                        context,
                        icon: Symbols.favorite,
                        title: '默认模型',
                        value: '使用当前对话模型',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.defaultModel),
                      ),
                      _buildDivider(isDark),
                      _buildSettingItem(
                        context,
                        icon: Symbols.api,
                        title: '服务商',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.providers),
                      ),
                      _buildDivider(isDark),
                      _buildSettingItem(
                        context,
                        icon: Symbols.search,
                        title: '搜索服务',
                        value: 'Bing (Local)',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.search),
                      ),
                      _buildDivider(isDark),
                      _buildSettingItem(
                        context,
                        icon: Symbols.code_blocks,
                        title: 'MCP',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.mcp),
                      ),
                      _buildDivider(isDark),
                      _buildSettingItem(
                        context,
                        icon: Symbols.bolt,
                        title: '快捷短语',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.quickPhrase),
                      ),
                      _buildDivider(isDark),
                      _buildSettingItem(
                        context,
                        icon: Symbols.chat,
                        title: '网络代理',
                        value: '关',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.proxy),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 数据 section
                  _buildSectionTitle('数据', isDark),
                  const SizedBox(height: 8),
                  _buildSection(
                    context,
                    items: [
                      _buildSettingItem(
                        context,
                        icon: Symbols.backup,
                        title: '备份',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.backup),
                      ),
                      _buildDivider(isDark),
                      _buildSettingItem(
                        context,
                        icon: Symbols.folder_open,
                        title: '聊天存储',
                        subtitle: '0 文件 · 0 B',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.chatStorage),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 其他设置 section
                  _buildSectionTitle('其他设置', isDark),
                  const SizedBox(height: 8),
                  _buildSection(
                    context,
                    items: [
                      _buildSettingItem(
                        context,
                        icon: Symbols.info,
                        title: '关于',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.about),
                      ),
                      _buildDivider(isDark),
                      _buildSettingItem(
                        context,
                        icon: Symbols.description,
                        title: '使用文档',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.docs),
                      ),
                      _buildDivider(isDark),
                      _buildSettingItem(
                        context,
                        icon: Symbols.volunteer_activism,
                        title: '赞助',
                        isDark: isDark,
                        onTap: () => _navigateToSubPage(SettingsSubPage.sponsor),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppTheme.gray500,
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required List<Widget> items,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return shadcn.Card(
      filled: true,
      fillColor: isDark ? AppTheme.cardDark : AppTheme.cardLight,
      borderRadius: BorderRadius.circular(16),
      borderColor: isDark ? AppTheme.gray800.withValues(alpha: 0.3) : AppTheme.gray200,
      borderWidth: 1,
      padding: EdgeInsets.zero,
      child: Column(
        children: items,
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 56,
      color: isDark ? AppTheme.gray800.withValues(alpha: 0.5) : AppTheme.gray200,
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? value,
    String? subtitle,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: isDark ? AppTheme.gray400 : AppTheme.gray600,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.gray500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (value != null) ...[
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.gray500,
                  ),
                ),
                const SizedBox(width: 4),
              ],
              Icon(
                Symbols.chevron_right,
                size: 20,
                color: AppTheme.gray400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build sub-page based on current selection
  Widget _buildSubPage(BuildContext context, bool isDark) {
    switch (_currentSubPage) {
      case SettingsSubPage.display:
        return DisplaySettingsPage(onBack: _navigateBack);
      case SettingsSubPage.themePalette:
        return ThemePalettePage(onBack: _navigateBack);
      case SettingsSubPage.haptic:
        return HapticSettingsPage(onBack: _navigateBack);
      case SettingsSubPage.tts:
        return TTSSettingsPage(onBack: _navigateBack);
      case SettingsSubPage.assistant:
        return AssistantSettingsPage(onBack: _navigateBack);
      case SettingsSubPage.defaultModel:
        return DefaultModelPage(onBack: _navigateBack);
      case SettingsSubPage.providers:
        return ProvidersPage(onBack: _navigateBack);
      case SettingsSubPage.search:
        return SearchSettingsPage(onBack: _navigateBack);
      case SettingsSubPage.mcp:
        return MCPSettingsPage(onBack: _navigateBack);
      case SettingsSubPage.quickPhrase:
        return QuickPhraseSettingsPage(onBack: _navigateBack);
      case SettingsSubPage.proxy:
        return ProxySettingsPage(onBack: _navigateBack);
      case SettingsSubPage.backup:
        return BackupSettingsPage(onBack: _navigateBack);
      case SettingsSubPage.chatStorage:
        return ChatStoragePage(onBack: _navigateBack);
      case SettingsSubPage.about:
        return AboutPage(onBack: _navigateBack);
      case SettingsSubPage.docs:
        return DocsPage(onBack: _navigateBack);
      case SettingsSubPage.sponsor:
        return SponsorPage(onBack: _navigateBack);
      default:
        return Scaffold(
          backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
          body: SafeArea(
            child: Center(
              child: Text(
                '未知页面',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                ),
              ),
            ),
          ),
        );
    }
  }
}
