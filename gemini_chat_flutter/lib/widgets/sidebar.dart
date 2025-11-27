import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import '../screens/home_screen.dart';
import '../theme/app_theme.dart';

class Sidebar extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final Function(AppView) onNavigate;

  const Sidebar({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Material(
        color: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
        child: SafeArea(
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
                child: Row(
                  children: [
                    Expanded(
                      child: shadcn.TextField(
                        placeholder: const Text('搜索历史记录'),
                        style: TextStyle(
                          color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                        ),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.gray800 : AppTheme.gray100,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        border: const Border.fromBorderSide(BorderSide.none),
                        borderRadius: BorderRadius.circular(24),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        features: [
                          shadcn.InputLeadingFeature(
                            Icon(
                              Symbols.search,
                              color: isDark ? AppTheme.gray500 : AppTheme.gray400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Symbols.history,
                      size: 32,
                      color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                    ),
                  ],
                ),
              ),

              // Navigation List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // Active Item
                    _buildAssistantItem(
                      context,
                      letter: 'D',
                      name: '默认助手',
                      isActive: true,
                      icon: Symbols.expand_less,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 8),

                    // Other Items
                    _buildAssistantItem(
                      context,
                      letter: 'D',
                      name: '默认助手',
                      isActive: false,
                      icon: Symbols.edit,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 8),

                    _buildAssistantItem(
                      context,
                      letter: 'S',
                      name: '示例助手',
                      isActive: false,
                      icon: Symbols.edit,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              // Bottom Section
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: isDark ? AppTheme.gray800 : AppTheme.gray100,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // User Avatar
                    shadcn.Avatar(
                      initials: 'U',
                      size: 40,
                      backgroundColor: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 16),

                    // User Name
                    Expanded(
                      child: Text(
                        '用户',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppTheme.gray200 : AppTheme.gray800,
                        ),
                      ),
                    ),

                    // Language Button
                    shadcn.IconButton.ghost(
                      onPressed: () {},
                      icon: Icon(
                        Symbols.translate,
                        color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                      ),
                    ),

                    // Settings Button
                    shadcn.IconButton.ghost(
                      onPressed: () {
                        onNavigate(AppView.settings);
                      },
                      icon: Icon(
                        Symbols.settings,
                        color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                      ),
                    ),
                  ],
                ),
              ),

              // Handle Indicator
              Container(
                width: 144,
                height: 6,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.gray700 : AppTheme.gray200,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssistantItem(
    BuildContext context, {
    required String letter,
    required String name,
    required bool isActive,
    required IconData icon,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isActive
            ? (isDark ? AppTheme.gray800 : AppTheme.gray100)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Avatar
                shadcn.Avatar(
                  initials: letter,
                  size: 40,
                  backgroundColor: AppTheme.primaryColor,
                ),
                const SizedBox(width: 16),

                // Name
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppTheme.gray200 : AppTheme.gray800,
                    ),
                  ),
                ),

                // Icon
                Icon(
                  icon,
                  color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
