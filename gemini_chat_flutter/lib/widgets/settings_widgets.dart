import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import '../theme/app_theme.dart';

/// Common header for settings sub-pages
class SettingsHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final IconData? actionIcon;
  final VoidCallback? onAction;

  const SettingsHeader({
    super.key,
    required this.title,
    required this.onBack,
    this.actionIcon,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          shadcn.IconButton.ghost(
            onPressed: onBack,
            icon: Icon(
              Symbols.arrow_back,
              color: isDark ? AppTheme.gray200 : AppTheme.gray800,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDark ? AppTheme.gray100 : AppTheme.gray900,
              ),
            ),
          ),
          if (actionIcon != null && onAction != null)
            shadcn.IconButton.ghost(
              onPressed: onAction,
              icon: Icon(
                actionIcon,
                color: isDark ? AppTheme.gray200 : AppTheme.gray800,
              ),
            ),
        ],
      ),
    );
  }
}

/// Section group with optional title
class SectionGroup extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const SectionGroup({
    super.key,
    this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.gray500,
              ),
            ),
          ),
        ],
        shadcn.Card(
          filled: true,
          fillColor: isDark ? AppTheme.cardDark : AppTheme.cardLight,
          borderRadius: BorderRadius.circular(16),
          borderColor: isDark ? AppTheme.gray800.withValues(alpha: 0.3) : AppTheme.gray200,
          borderWidth: 1,
          padding: EdgeInsets.zero,
          child: Column(
            children: _addDividers(children, isDark),
          ),
        ),
      ],
    );
  }

  List<Widget> _addDividers(List<Widget> children, bool isDark) {
    final List<Widget> result = [];
    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(Divider(
          height: 1,
          thickness: 1,
          indent: 16,
          endIndent: 16,
          color: isDark ? AppTheme.gray800.withValues(alpha: 0.5) : AppTheme.gray200,
        ));
      }
    }
    return result;
  }
}

/// Selection item with optional checkmark
class SelectionItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? subtitle;
  final IconData? icon;

  const SelectionItem({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 20,
                  color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.gray500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (selected)
                Icon(
                  Symbols.check,
                  size: 20,
                  color: isDark ? Colors.white : Colors.black,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Toggle switch item
class ToggleItem extends StatelessWidget {
  final String label;
  final bool checked;
  final ValueChanged<bool> onChange;
  final IconData? icon;

  const ToggleItem({
    super.key,
    required this.label,
    required this.checked,
    required this.onChange,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 20,
              color: isDark ? AppTheme.gray400 : AppTheme.gray600,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isDark ? AppTheme.gray100 : AppTheme.gray900,
              ),
            ),
          ),
          ToggleSwitch(
            checked: checked,
            onChange: onChange,
          ),
        ],
      ),
    );
  }
}

/// Standalone toggle switch widget (reusable)
class ToggleSwitch extends StatelessWidget {
  final bool checked;
  final ValueChanged<bool> onChange;

  const ToggleSwitch({
    super.key,
    required this.checked,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return shadcn.Switch(
      value: checked,
      onChanged: onChange,
      activeColor: AppTheme.accentBrown,
      inactiveColor: isDark ? AppTheme.gray700 : AppTheme.gray200,
      activeThumbColor: Colors.white,
      inactiveThumbColor: Colors.white,
    );
  }
}

/// Value item with chevron
class ValueItem extends StatelessWidget {
  final String label;
  final String? value;
  final IconData? icon;
  final VoidCallback? onTap;

  const ValueItem({
    super.key,
    required this.label,
    this.value,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 20,
                  color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                  ),
                ),
              ),
              if (value != null) ...[
                Text(
                  value!,
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
}

/// Input field item
class InputItem extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChange;
  final String? placeholder;
  final bool obscureText;

  const InputItem({
    super.key,
    required this.label,
    required this.value,
    required this.onChange,
    this.placeholder,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.gray500,
            ),
          ),
          const SizedBox(height: 8),
          shadcn.TextField(
            controller: TextEditingController(text: value)
              ..selection = TextSelection.fromPosition(
                TextPosition(offset: value.length),
              ),
            onChanged: onChange,
            obscureText: obscureText,
            placeholder: placeholder != null ? Text(placeholder!) : null,
            decoration: BoxDecoration(
              color: isDark ? AppTheme.gray800 : AppTheme.gray100,
              borderRadius: BorderRadius.circular(12),
            ),
            border: const Border.fromBorderSide(BorderSide.none),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppTheme.gray100 : AppTheme.gray900,
            ),
          ),
        ],
      ),
    );
  }
}
