import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/app_theme.dart';
import '../widgets/settings_widgets.dart';

/// Display settings page (Theme and Language)
class DisplaySettingsPage extends StatefulWidget {
  final VoidCallback onBack;

  const DisplaySettingsPage({super.key, required this.onBack});

  @override
  State<DisplaySettingsPage> createState() => _DisplaySettingsPageState();
}

class _DisplaySettingsPageState extends State<DisplaySettingsPage> {
  String _theme = '跟随系统';
  String _language = '跟随系统';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '显示', onBack: widget.onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SectionGroup(
                    title: '主题设置',
                    children: [
                      SelectionItem(
                        label: '浅色',
                        selected: _theme == '浅色',
                        onTap: () => setState(() => _theme = '浅色'),
                      ),
                      SelectionItem(
                        label: '深色',
                        selected: _theme == '深色',
                        onTap: () => setState(() => _theme = '深色'),
                      ),
                      SelectionItem(
                        label: '跟随系统',
                        selected: _theme == '跟随系统',
                        onTap: () => setState(() => _theme = '跟随系统'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SectionGroup(
                    title: '语言设置',
                    children: [
                      SelectionItem(
                        label: '简体中文',
                        selected: _language == '简体中文',
                        onTap: () => setState(() => _language = '简体中文'),
                      ),
                      SelectionItem(
                        label: '繁体中文',
                        selected: _language == '繁体中文',
                        onTap: () => setState(() => _language = '繁体中文'),
                      ),
                      SelectionItem(
                        label: '英文',
                        selected: _language == '英文',
                        onTap: () => setState(() => _language = '英文'),
                      ),
                      SelectionItem(
                        label: '跟随系统',
                        selected: _language == '跟随系统',
                        onTap: () => setState(() => _language = '跟随系统'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// About page
class AboutPage extends StatelessWidget {
  final VoidCallback onBack;

  const AboutPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '关于', onBack: onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // App Info
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.purple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Symbols.smart_toy,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Cometix',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '开源AI助手',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.gray500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SectionGroup(
                    children: [
                      ValueItem(
                        label: '版本',
                        value: '1.1.2 / 2017',
                        onTap: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '系统',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                              ),
                            ),
                            Text(
                              'Flutter',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.gray500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SectionGroup(
                    children: [
                      ValueItem(
                        label: '官网',
                        icon: Symbols.language,
                        onTap: () {},
                      ),
                      ValueItem(
                        label: 'GitHub',
                        icon: Symbols.code,
                        onTap: () {},
                      ),
                      ValueItem(
                        label: '许可证',
                        icon: Symbols.description,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SectionGroup(
                    children: [
                      ValueItem(
                        label: '加入QQ群',
                        icon: Symbols.group,
                        onTap: () {},
                      ),
                      ValueItem(
                        label: '在 Discord 中加入我们',
                        icon: Symbols.forum,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sponsor page
class SponsorPage extends StatelessWidget {
  final VoidCallback onBack;

  const SponsorPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final sponsors = [
      {'name': 'wwxiaoqi', 'avatar': 'W'},
      {'name': 'orange1...', 'avatar': 'O'},
      {'name': 'meeer', 'avatar': 'M'},
      {'name': 'Jorben', 'avatar': 'J'},
      {'name': 'stou', 'avatar': 'S'},
      {'name': 'Gordon', 'avatar': 'G'},
      {'name': '阳月🌙', 'avatar': 'Y'},
      {'name': 'JaqenZe', 'avatar': 'J'},
      {'name': 'thinking', 'avatar': 'T'},
      {'name': '昼月无寂', 'avatar': 'Z'},
    ];

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '赞助', onBack: onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SectionGroup(
                    title: '赞助方式',
                    children: [
                      ValueItem(
                        label: '爱发电',
                        icon: Symbols.favorite,
                        onTap: () {},
                      ),
                      ValueItem(
                        label: '微信赞助',
                        icon: Symbols.link,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 12),
                    child: Text(
                      '赞助用户',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.gray500,
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: sponsors.length,
                    itemBuilder: (context, index) {
                      final sponsor = sponsors[index];
                      return Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                sponsor['avatar']!,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.gray700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            sponsor['name']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.gray500,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Network Proxy settings page
class ProxySettingsPage extends StatefulWidget {
  final VoidCallback onBack;

  const ProxySettingsPage({super.key, required this.onBack});

  @override
  State<ProxySettingsPage> createState() => _ProxySettingsPageState();
}

class _ProxySettingsPageState extends State<ProxySettingsPage> {
  bool _enabled = false;
  String _type = 'HTTP';
  String _host = '127.0.0.1';
  String _port = '8080';
  String _username = '';
  String _password = '';
  String _testUrl = 'https://www.google.com';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '网络代理', onBack: widget.onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SectionGroup(
                    children: [
                      ToggleItem(
                        label: '启用代理',
                        checked: _enabled,
                        onChange: (v) => setState(() => _enabled = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Opacity(
                    opacity: _enabled ? 1.0 : 0.5,
                    child: IgnorePointer(
                      ignoring: !_enabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Text(
                              '代理类型',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.gray500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isDark ? AppTheme.cardDark : AppTheme.cardLight,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark ? AppTheme.gray800.withValues(alpha: 0.3) : AppTheme.gray200,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: _type,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: ['HTTP', 'HTTPS', 'SOCKS5']
                                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                                  .toList(),
                              onChanged: (v) => setState(() => _type = v!),
                            ),
                          ),
                          SectionGroup(
                            children: [
                              InputItem(
                                label: '服务器地址',
                                value: _host,
                                onChange: (v) => setState(() => _host = v),
                                placeholder: '127.0.0.1',
                              ),
                              InputItem(
                                label: '端口',
                                value: _port,
                                onChange: (v) => setState(() => _port = v),
                                placeholder: '8080',
                              ),
                              InputItem(
                                label: '用户名',
                                value: _username,
                                onChange: (v) => setState(() => _username = v),
                                placeholder: '可选',
                              ),
                              InputItem(
                                label: '密码',
                                value: _password,
                                onChange: (v) => setState(() => _password = v),
                                placeholder: '可选',
                                obscureText: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '同时开启全局代理与供应商代理时，将优先使用供应商代理。',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.gray500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Text(
                              '连接测试',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.gray500,
                              ),
                            ),
                          ),
                          SectionGroup(
                            children: [
                              InputItem(
                                label: '测试URL',
                                value: _testUrl,
                                onChange: (v) => setState(() => _testUrl = v),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark ? AppTheme.gray800 : AppTheme.gray200,
                                foregroundColor: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('测试'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Backup settings page
/// Documentation page (placeholder)
class DocsPage extends StatelessWidget {
  final VoidCallback onBack;

  const DocsPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '使用文档', onBack: onBack),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Symbols.description,
                      size: 64,
                      color: AppTheme.gray400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '文档内容',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.gray500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder pages for other settings
class AssistantSettingsPage extends StatefulWidget {
  final VoidCallback onBack;
  const AssistantSettingsPage({super.key, required this.onBack});

  @override
  State<AssistantSettingsPage> createState() => _AssistantSettingsPageState();
}

class _AssistantSettingsPageState extends State<AssistantSettingsPage> {
  final List<Map<String, dynamic>> _assistants = [
    {
      'name': '默认助手',
      'description': '通用AI助手，适用于各种场景',
      'enabled': true,
    },
    {
      'name': '代码助手',
      'description': '专注于编程和代码相关的任务',
      'enabled': true,
    },
    {
      'name': '写作助手',
      'description': '帮助你进行创意写作和文案创作',
      'enabled': false,
    },
  ];

  void _toggleAssistant(int index) {
    setState(() {
      _assistants[index]['enabled'] = !_assistants[index]['enabled'];
    });
  }

  void _addAssistant() {
    setState(() {
      _assistants.add({
        'name': '新助手',
        'description': '描述你的助手',
        'enabled': true,
      });
    });
  }

  void _deleteAssistant(int index) {
    setState(() {
      _assistants.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(
              title: '助手',
              onBack: widget.onBack,
              actionIcon: Symbols.add,
              onAction: _addAssistant,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_assistants.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(
                              Symbols.help,
                              size: 64,
                              color: AppTheme.gray400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '暂无助手',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.gray500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ..._assistants.asMap().entries.map((entry) {
                      final index = entry.key;
                      final assistant = entry.value;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.cardDark : AppTheme.cardLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark ? AppTheme.gray800.withValues(alpha: 0.3) : AppTheme.gray200,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      assistant['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      assistant['description'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppTheme.gray500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ToggleSwitch(
                                checked: assistant['enabled'],
                                onChange: (v) => _toggleAssistant(index),
                              ),
                              IconButton(
                                onPressed: () => _deleteAssistant(index),
                                icon: Icon(
                                  Symbols.delete,
                                  size: 20,
                                  color: AppTheme.gray400,
                                ),
                              ),
                            ],
                          ),
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
}

class DefaultModelPage extends StatefulWidget {
  final VoidCallback onBack;
  const DefaultModelPage({super.key, required this.onBack});

  @override
  State<DefaultModelPage> createState() => _DefaultModelPageState();
}

class _DefaultModelPageState extends State<DefaultModelPage> {
  String _selectedModel = '使用当前对话模型';
  final List<Map<String, String>> _models = [
    {'name': '使用当前对话模型', 'provider': ''},
    {'name': 'GPT-4', 'provider': 'OpenAI'},
    {'name': 'GPT-3.5 Turbo', 'provider': 'OpenAI'},
    {'name': 'Claude 3 Opus', 'provider': 'Anthropic'},
    {'name': 'Claude 3 Sonnet', 'provider': 'Anthropic'},
    {'name': 'Gemini Pro', 'provider': 'Google'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '默认模型', onBack: widget.onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SectionGroup(
                    title: '选择默认模型',
                    children: _models.map((model) {
                      return SelectionItem(
                        label: model['name']!,
                        subtitle: model['provider']!.isEmpty ? null : model['provider'],
                        selected: _selectedModel == model['name'],
                        onTap: () => setState(() => _selectedModel = model['name']!),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProvidersPage extends StatefulWidget {
  final VoidCallback onBack;
  const ProvidersPage({super.key, required this.onBack});

  @override
  State<ProvidersPage> createState() => _ProvidersPageState();
}

class _ProvidersPageState extends State<ProvidersPage> {
  final List<Map<String, dynamic>> _providers = [
    {
      'name': 'OpenAI',
      'enabled': true,
      'apiKey': 'sk-*********************',
      'models': ['gpt-4', 'gpt-3.5-turbo'],
    },
    {
      'name': 'Anthropic',
      'enabled': true,
      'apiKey': 'sk-ant-*********************',
      'models': ['claude-3-opus', 'claude-3-sonnet'],
    },
    {
      'name': 'Google',
      'enabled': false,
      'apiKey': '',
      'models': ['gemini-pro'],
    },
  ];

  void _toggleProvider(int index) {
    setState(() {
      _providers[index]['enabled'] = !_providers[index]['enabled'];
    });
  }

  void _editProvider(int index) {
    // TODO: Show edit dialog
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '服务商', onBack: widget.onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 12),
                    child: Text(
                      'AI 服务提供商',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.gray500,
                      ),
                    ),
                  ),
                  ..._providers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final provider = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.cardDark : AppTheme.cardLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? AppTheme.gray800.withValues(alpha: 0.3) : AppTheme.gray200,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _editProvider(index),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider['name'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        provider['apiKey'].isEmpty ? '未配置 API Key' : provider['apiKey'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.gray500,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${(provider['models'] as List).length} 个模型',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppTheme.gray400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ToggleSwitch(
                                  checked: provider['enabled'],
                                  onChange: (v) => _toggleProvider(index),
                                ),
                              ],
                            ),
                          ),
                        ),
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
}

class SearchSettingsPage extends StatefulWidget {
  final VoidCallback onBack;
  const SearchSettingsPage({super.key, required this.onBack});

  @override
  State<SearchSettingsPage> createState() => _SearchSettingsPageState();
}

class _SearchSettingsPageState extends State<SearchSettingsPage> {
  String _selectedEngine = 'Bing (Local)';
  final List<String> _engines = [
    'Bing (Local)',
    'Google',
    'DuckDuckGo',
    'Brave Search',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '搜索服务', onBack: widget.onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SectionGroup(
                    title: '搜索引擎',
                    children: _engines.map((engine) {
                      return SelectionItem(
                        label: engine,
                        selected: _selectedEngine == engine,
                        onTap: () => setState(() => _selectedEngine = engine),
                        icon: Symbols.search,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MCPSettingsPage extends StatefulWidget {
  final VoidCallback onBack;
  const MCPSettingsPage({super.key, required this.onBack});

  @override
  State<MCPSettingsPage> createState() => _MCPSettingsPageState();
}

class _MCPSettingsPageState extends State<MCPSettingsPage> {
  final List<Map<String, dynamic>> _servers = [
    {
      'name': 'filesystem',
      'command': 'npx',
      'args': ['-y', '@modelcontextprotocol/server-filesystem', '/path/to/allowed/files'],
      'enabled': true,
    },
    {
      'name': 'github',
      'command': 'npx',
      'args': ['-y', '@modelcontextprotocol/server-github'],
      'enabled': false,
    },
  ];

  void _addServer() {
    setState(() {
      _servers.add({
        'name': 'new-server',
        'command': 'npx',
        'args': [],
        'enabled': true,
      });
    });
  }

  void _toggleServer(int index) {
    setState(() {
      _servers[index]['enabled'] = !_servers[index]['enabled'];
    });
  }

  void _deleteServer(int index) {
    setState(() {
      _servers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(
              title: 'MCP',
              onBack: widget.onBack,
              actionIcon: Symbols.add,
              onAction: _addServer,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 12),
                    child: Text(
                      'Model Context Protocol 服务器',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.gray500,
                      ),
                    ),
                  ),
                  if (_servers.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(
                              Symbols.code_blocks,
                              size: 64,
                              color: AppTheme.gray400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '暂无 MCP 服务器',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.gray500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ..._servers.asMap().entries.map((entry) {
                      final index = entry.key;
                      final server = entry.value;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.cardDark : AppTheme.cardLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark ? AppTheme.gray800.withValues(alpha: 0.3) : AppTheme.gray200,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          server['name'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${server['command']} ${(server['args'] as List).join(' ')}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: AppTheme.gray500,
                                            fontFamily: 'monospace',
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  ToggleSwitch(
                                    checked: server['enabled'],
                                    onChange: (v) => _toggleServer(index),
                                  ),
                                  IconButton(
                                    onPressed: () => _deleteServer(index),
                                    icon: Icon(
                                      Symbols.delete,
                                      size: 20,
                                      color: AppTheme.gray400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
}

class QuickPhraseSettingsPage extends StatefulWidget {
  final VoidCallback onBack;
  const QuickPhraseSettingsPage({super.key, required this.onBack});

  @override
  State<QuickPhraseSettingsPage> createState() => _QuickPhraseSettingsPageState();
}

class _QuickPhraseSettingsPageState extends State<QuickPhraseSettingsPage> {
  final List<Map<String, String>> _phrases = [
    {'title': '翻译', 'content': '请将以下内容翻译成中文：'},
    {'title': '总结', 'content': '请总结以下内容的要点：'},
    {'title': '解释', 'content': '请详细解释以下内容：'},
  ];

  void _addPhrase() {
    setState(() {
      _phrases.add({'title': '新短语', 'content': ''});
    });
  }

  void _deletePhrase(int index) {
    setState(() {
      _phrases.removeAt(index);
    });
  }

  void _editPhrase(int index) {
    // TODO: Show edit dialog
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(
              title: '快捷短语',
              onBack: widget.onBack,
              actionIcon: Symbols.add,
              onAction: _addPhrase,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_phrases.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(
                              Symbols.bolt,
                              size: 64,
                              color: AppTheme.gray400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '暂无快捷短语',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.gray500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SectionGroup(
                      children: _phrases.asMap().entries.map((entry) {
                        final index = entry.key;
                        final phrase = entry.value;
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _editPhrase(index),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          phrase['title']!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          phrase['content']!,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: AppTheme.gray500,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => _deletePhrase(index),
                                    icon: Icon(
                                      Symbols.delete,
                                      size: 20,
                                      color: AppTheme.gray400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
