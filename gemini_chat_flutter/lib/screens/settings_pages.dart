import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart' as provider;
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/settings_widgets.dart';
import '../providers/settings_provider.dart';
import '../providers/assistant_provider.dart';
import '../providers/quick_phrases_provider.dart';
import '../models/assistant.dart';
import '../models/mcp_config.dart';
import '../models/proxy_config.dart';
import '../models/quick_phrase.dart';
import 'assistant_edit_page.dart';

/// 公共工具函数：打开外部链接
Future<void> launchExternalUrl(String url, {BuildContext? context}) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else if (context != null && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('无法打开链接')),
    );
  }
}

/// Display settings page (Theme and Language)
class DisplaySettingsPage extends StatelessWidget {
  final VoidCallback onBack;

  const DisplaySettingsPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = provider.Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '显示', onBack: onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 主题设置
                  SectionGroup(
                    title: '主题设置',
                    children: [
                      SelectionItem(
                        label: '浅色',
                        selected: settings.themeMode == ThemeMode.light,
                        onTap: () => settings.setThemeMode(ThemeMode.light),
                      ),
                      SelectionItem(
                        label: '深色',
                        selected: settings.themeMode == ThemeMode.dark,
                        onTap: () => settings.setThemeMode(ThemeMode.dark),
                      ),
                      SelectionItem(
                        label: '跟随系统',
                        selected: settings.themeMode == ThemeMode.system,
                        onTap: () => settings.setThemeMode(ThemeMode.system),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 语言设置
                  SectionGroup(
                    title: '语言设置',
                    children: [
                      SelectionItem(
                        label: '简体中文',
                        selected: settings.appLocale == 'zh_CN',
                        onTap: () => settings.setAppLocale('zh_CN'),
                      ),
                      SelectionItem(
                        label: '繁体中文',
                        selected: settings.appLocale == 'zh_TW',
                        onTap: () => settings.setAppLocale('zh_TW'),
                      ),
                      SelectionItem(
                        label: '英文',
                        selected: settings.appLocale == 'en',
                        onTap: () => settings.setAppLocale('en'),
                      ),
                      SelectionItem(
                        label: '跟随系统',
                        selected: settings.appLocale == null,
                        onTap: () => settings.setAppLocale(null),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 字体设置
                  SectionGroup(
                    title: '字体设置',
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '字体大小',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                  ),
                                ),
                                Text(
                                  '${(settings.chatFontScale * 100).toInt()}%',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.gray500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Slider(
                              value: settings.chatFontScale,
                              min: 0.8,
                              max: 1.5,
                              divisions: 14,
                              activeColor: AppTheme.primaryColor,
                              onChanged: (value) => settings.setChatFontScale(value),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 显示选项
                  SectionGroup(
                    title: '显示选项',
                    children: [
                      ToggleItem(
                        label: '显示用户头像',
                        checked: settings.showUserAvatar,
                        onChange: settings.setShowUserAvatar,
                      ),
                      ToggleItem(
                        label: '显示模型图标',
                        checked: settings.showModelIcon,
                        onChange: settings.setShowModelIcon,
                      ),
                      ToggleItem(
                        label: '显示时间戳',
                        checked: settings.showTimestamp,
                        onChange: settings.setShowTimestamp,
                      ),
                      ToggleItem(
                        label: '启用 Markdown 渲染',
                        checked: settings.enableMarkdown,
                        onChange: settings.setEnableMarkdown,
                      ),
                      ToggleItem(
                        label: '自动滚动到底部',
                        checked: settings.autoScroll,
                        onChange: settings.setAutoScroll,
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
                          '基于 Flutter 的 AI 聊天助手',
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
                        value: '1.0.0',
                        onTap: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '框架',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                              ),
                            ),
                            Text(
                              'Flutter 3.38.3',
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
                        label: 'GitHub',
                        icon: Symbols.code,
                        onTap: () => launchExternalUrl('https://github.com/anthropics/cometix'),
                      ),
                      ValueItem(
                        label: '许可证',
                        value: 'MIT',
                        icon: Symbols.description,
                        onTap: () => launchExternalUrl('https://opensource.org/licenses/MIT'),
                      ),
                      ValueItem(
                        label: '文档',
                        icon: Symbols.menu_book,
                        onTap: () => launchExternalUrl('https://github.com/anthropics/cometix/blob/main/README.md'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SectionGroup(
                    children: [
                      ValueItem(
                        label: '报告问题',
                        icon: Symbols.bug_report,
                        onTap: () => launchExternalUrl('https://github.com/anthropics/cometix/issues'),
                      ),
                      ValueItem(
                        label: '贡献代码',
                        icon: Symbols.code_blocks,
                        onTap: () => launchExternalUrl('https://github.com/anthropics/cometix/pulls'),
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

/// 赞助页面 - 显示赞助方式和赞助用户列表
class SponsorPage extends StatelessWidget {
  final VoidCallback onBack;

  const SponsorPage({super.key, required this.onBack});

  /// 显示微信赞赏码
  void _showWeChatQRCode(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? AppTheme.cardDark : AppTheme.cardLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              Symbols.qr_code,
              color: isDark ? AppTheme.gray100 : AppTheme.gray900,
            ),
            const SizedBox(width: 12),
            Text(
              '微信赞赏码',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? AppTheme.gray100 : AppTheme.gray900,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.gray200),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Symbols.qr_code_2,
                      size: 80,
                      color: AppTheme.gray400,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '二维码待配置',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.gray500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '扫描上方二维码进行赞赏',
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.gray500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 赞助用户列表（后续可从远程加载）
    final sponsors = [
      {'name': 'wwxiaoqi', 'avatar': 'W'},
      {'name': 'orange1...', 'avatar': 'O'},
      {'name': 'meeer', 'avatar': 'M'},
      {'name': 'Jorben', 'avatar': 'J'},
      {'name': 'stou', 'avatar': 'S'},
      {'name': 'Gordon', 'avatar': 'G'},
      {'name': '阳月🌙', 'avatar': '阳'},
      {'name': 'JaqenZe', 'avatar': 'J'},
      {'name': 'thinking', 'avatar': 'T'},
      {'name': '昼月无寂', 'avatar': '昼'},
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
                  // 感谢语
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withValues(alpha: 0.3),
                          AppTheme.primaryColor.withValues(alpha: 0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Symbols.favorite,
                          size: 32,
                          color: Colors.red.shade400,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '感谢您的支持',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '您的赞助是我们持续开发的动力',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.gray500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 赞助方式
                  SectionGroup(
                    title: '赞助方式',
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => launchExternalUrl('https://afdian.com/a/cometix', context: context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.purple.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Symbols.favorite,
                                    size: 20,
                                    color: Colors.purple,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '爱发电',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '通过爱发电平台赞助',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.gray500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Symbols.open_in_new,
                                  size: 18,
                                  color: AppTheme.gray400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _showWeChatQRCode(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Symbols.qr_code,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '微信赞赏',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '扫描微信赞赏码',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.gray500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Symbols.chevron_right,
                                  size: 18,
                                  color: AppTheme.gray400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 赞助用户
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 12),
                    child: Row(
                      children: [
                        Text(
                          '赞助用户',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.gray500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${sponsors.length} 人',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.gray400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width >= 480 ? 6 : 5,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: sponsors.length,
                    itemBuilder: (context, index) {
                      final sponsor = sponsors[index];
                      // 根据名字生成随机颜色
                      final colors = [
                        Colors.blue,
                        Colors.purple,
                        Colors.orange,
                        Colors.teal,
                        Colors.pink,
                        Colors.indigo,
                        Colors.amber,
                        Colors.cyan,
                      ];
                      final color = colors[index % colors.length];

                      return Column(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: color.withValues(alpha: 0.3),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                sponsor['avatar']!,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: color,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            sponsor['name']!,
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? AppTheme.gray300 : AppTheme.gray600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // 底部感谢
                  Center(
                    child: Text(
                      '❤️ 感谢所有赞助者的支持 ❤️',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.gray500,
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

/// Network Proxy settings page
class ProxySettingsPage extends StatefulWidget {
  final VoidCallback onBack;

  const ProxySettingsPage({super.key, required this.onBack});

  @override
  State<ProxySettingsPage> createState() => _ProxySettingsPageState();
}

class _ProxySettingsPageState extends State<ProxySettingsPage> {
  // 文本控制器
  late final TextEditingController _hostCtl;
  late final TextEditingController _portCtl;
  late final TextEditingController _userCtl;
  late final TextEditingController _passCtl;
  late final TextEditingController _testUrlCtl;

  // 焦点节点（用于失去焦点时保存）
  final FocusNode _hostFn = FocusNode();
  final FocusNode _portFn = FocusNode();
  final FocusNode _userFn = FocusNode();
  final FocusNode _passFn = FocusNode();

  // 测试状态
  bool _testing = false;
  String? _testErr;
  bool? _testOk;

  @override
  void initState() {
    super.initState();
    // 从 SettingsProvider 读取配置初始化控制器
    final settings = provider.Provider.of<SettingsProvider>(context, listen: false);
    final config = settings.proxyConfig;

    _hostCtl = TextEditingController(text: config.host);
    _portCtl = TextEditingController(text: config.port);
    _userCtl = TextEditingController(text: config.username);
    _passCtl = TextEditingController(text: config.password);
    _testUrlCtl = TextEditingController(text: 'https://www.google.com');

    // 监听焦点变化，失去焦点时保存配置
    _hostFn.addListener(() {
      if (!_hostFn.hasFocus) _saveConfig();
    });
    _portFn.addListener(() {
      if (!_portFn.hasFocus) _saveConfig();
    });
    _userFn.addListener(() {
      if (!_userFn.hasFocus) _saveConfig();
    });
    _passFn.addListener(() {
      if (!_passFn.hasFocus) _saveConfig();
    });
  }

  @override
  void dispose() {
    _hostCtl.dispose();
    _portCtl.dispose();
    _userCtl.dispose();
    _passCtl.dispose();
    _testUrlCtl.dispose();
    _hostFn.dispose();
    _portFn.dispose();
    _userFn.dispose();
    _passFn.dispose();
    super.dispose();
  }

  /// 保存代理配置到 SettingsProvider
  void _saveConfig() {
    final settings = provider.Provider.of<SettingsProvider>(context, listen: false);
    final current = settings.proxyConfig;

    settings.setProxyConfig(
      current.copyWith(
        host: _hostCtl.text,
        port: _portCtl.text,
        username: _userCtl.text,
        password: _passCtl.text,
      ),
    );
  }

  /// 测试代理连接
  Future<void> _onTest() async {
    final url = _testUrlCtl.text.trim();
    if (url.isEmpty) {
      setState(() {
        _testOk = false;
        _testErr = '请输入测试 URL';
      });
      return;
    }

    setState(() {
      _testing = true;
      _testOk = null;
      _testErr = null;
    });

    try {
      final settings = provider.Provider.of<SettingsProvider>(context, listen: false);
      final config = settings.proxyConfig;

      final host = _hostCtl.text.trim();
      final port = int.tryParse(_portCtl.text.trim()) ?? 8080;
      final user = _userCtl.text.trim();
      final pass = _passCtl.text;

      // 根据代理类型配置 HttpClient
      final io = HttpClient();

      if (config.type == ProxyType.socks5) {
        // TODO: SOCKS5 代理支持需要额外依赖
        // 这里暂时提示不支持
        setState(() {
          _testing = false;
          _testOk = false;
          _testErr = 'SOCKS5 代理暂不支持，请使用 HTTP/HTTPS';
        });
        return;
      } else {
        // HTTP/HTTPS 代理配置
        io.findProxy = (_) => 'PROXY $host:$port';
        if (user.isNotEmpty) {
          io.addProxyCredentials(
            host,
            port,
            '',
            HttpClientBasicCredentials(user, pass),
          );
        }
      }

      // 发起测试请求（8秒超时）
      final client = IOClient(io);
      final res = await client.get(Uri.parse(url)).timeout(
        const Duration(seconds: 8),
        onTimeout: () {
          throw TimeoutException('连接超时');
        },
      );
      client.close();

      // 判断响应状态码
      final success = res.statusCode >= 200 && res.statusCode < 400;
      setState(() {
        _testing = false;
        _testOk = success;
        _testErr = success ? null : 'HTTP ${res.statusCode}';
      });
    } on TimeoutException catch (_) {
      setState(() {
        _testing = false;
        _testOk = false;
        _testErr = '连接超时（8秒）';
      });
    } catch (e) {
      setState(() {
        _testing = false;
        _testOk = false;
        _testErr = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = provider.Provider.of<SettingsProvider>(context);
    final config = settings.proxyConfig;

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
                        checked: config.enabled,
                        onChange: (v) {
                          settings.setProxyConfig(config.copyWith(enabled: v));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Opacity(
                    opacity: config.enabled ? 1.0 : 0.5,
                    child: IgnorePointer(
                      ignoring: !config.enabled,
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
                            child: DropdownButton<ProxyType>(
                              value: config.type,
                              isExpanded: true,
                              underline: const SizedBox(),
                              items: ProxyType.values
                                  .map((t) => DropdownMenuItem(
                                        value: t,
                                        child: Text(t.name.toUpperCase()),
                                      ))
                                  .toList(),
                              onChanged: (v) {
                                if (v != null) {
                                  settings.setProxyConfig(config.copyWith(type: v));
                                }
                              },
                            ),
                          ),
                          SectionGroup(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '服务器地址',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    TextField(
                                      controller: _hostCtl,
                                      focusNode: _hostFn,
                                      decoration: _inputDecoration(context, '127.0.0.1'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '端口',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    TextField(
                                      controller: _portCtl,
                                      focusNode: _portFn,
                                      keyboardType: TextInputType.number,
                                      decoration: _inputDecoration(context, '8080'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '用户名',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    TextField(
                                      controller: _userCtl,
                                      focusNode: _userFn,
                                      decoration: _inputDecoration(context, '可选'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '密码',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    TextField(
                                      controller: _passCtl,
                                      focusNode: _passFn,
                                      obscureText: true,
                                      decoration: _inputDecoration(context, '可选'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '测试 URL',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: isDark ? AppTheme.gray400 : AppTheme.gray600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    TextField(
                                      controller: _testUrlCtl,
                                      decoration: _inputDecoration(context, 'https://www.google.com'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: _testing ? null : _onTest,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isDark ? AppTheme.gray800 : AppTheme.gray200,
                                      foregroundColor: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                      disabledBackgroundColor: isDark ? AppTheme.gray900 : AppTheme.gray100,
                                      disabledForegroundColor: AppTheme.gray500,
                                      minimumSize: const Size(100, 40),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(_testing ? '测试中...' : '测试'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (_testOk == true)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                              child: Text(
                                '✓ 连接成功',
                                style: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          if (_testOk == false)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                              child: Text(
                                '✗ 连接失败: ${_testErr ?? '未知错误'}',
                                style: TextStyle(
                                  color: Colors.red.shade600,
                                  fontSize: 13,
                                ),
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

  /// 输入框装饰样式
  InputDecoration _inputDecoration(BuildContext context, String hint) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;

    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: isDark ? Colors.white10 : const Color(0xFFF7F7F9),
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 14,
        color: AppTheme.gray400,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: (isDark ? AppTheme.gray800 : AppTheme.gray200).withValues(alpha: 0.5),
          width: 0.6,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: (isDark ? AppTheme.gray800 : AppTheme.gray200).withValues(alpha: 0.5),
          width: 0.6,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: cs.primary.withValues(alpha: 0.5),
          width: 1.0,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }
}

/// 使用文档页面 - 提供快速入门指南和常用功能说明
class DocsPage extends StatelessWidget {
  final VoidCallback onBack;

  const DocsPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 文档条目列表
    final docItems = [
      {
        'icon': Symbols.rocket_launch,
        'title': '快速入门',
        'desc': '了解如何开始使用 Cometix',
        'url': 'https://github.com/anthropics/cometix#readme',
      },
      {
        'icon': Symbols.settings,
        'title': '配置指南',
        'desc': '配置 API Key 和服务商',
        'url': 'https://github.com/anthropics/cometix/blob/main/docs/configuration.md',
      },
      {
        'icon': Symbols.smart_toy,
        'title': '助手系统',
        'desc': '创建和管理自定义助手',
        'url': 'https://github.com/anthropics/cometix/blob/main/docs/assistants.md',
      },
      {
        'icon': Symbols.code_blocks,
        'title': 'MCP 协议',
        'desc': '了解 Model Context Protocol',
        'url': 'https://modelcontextprotocol.io/docs',
      },
      {
        'icon': Symbols.help,
        'title': '常见问题',
        'desc': '常见问题解答',
        'url': 'https://github.com/anthropics/cometix/discussions',
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '使用文档', onBack: onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 头部说明
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.gray800.withValues(alpha: 0.5) : AppTheme.gray100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Symbols.menu_book,
                          size: 32,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '欢迎使用 Cometix',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '点击下方链接查看详细文档',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.gray500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 文档列表
                  SectionGroup(
                    title: '帮助文档',
                    children: docItems.map((item) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => launchExternalUrl(item['url'] as String),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    item['icon'] as IconData,
                                    size: 20,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'] as String,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item['desc'] as String,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.gray500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Symbols.open_in_new,
                                  size: 18,
                                  color: AppTheme.gray400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // 底部提示
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '文档链接将在浏览器中打开。如有问题，欢迎在 GitHub 上提交 Issue。',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.gray500,
                        height: 1.5,
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

// Placeholder pages for other settings
class AssistantSettingsPage extends StatelessWidget {
  final VoidCallback onBack;
  const AssistantSettingsPage({super.key, required this.onBack});

  void _addAssistant(BuildContext context) {
    final assistantProvider = provider.Provider.of<AssistantProvider>(context, listen: false);
    final newId = 'assistant_${DateTime.now().millisecondsSinceEpoch}';
    assistantProvider.addAssistant(
      Assistant(
        id: newId,
        name: '新助手',
        description: '描述你的助手',
        systemPrompt: '',
        enabled: true,
      ),
    );
    // 直接进入编辑页面
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AssistantEditPage(assistantId: newId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final assistantProvider = provider.Provider.of<AssistantProvider>(context);
    final assistants = assistantProvider.assistants;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(
              title: '助手设置',
              onBack: onBack,
              actionIcon: Symbols.add,
              onAction: () => _addAssistant(context),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (assistants.isEmpty)
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
                    ...assistants.map((assistant) {
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
                                      assistant.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                      ),
                                    ),
                                    if (assistant.description != null) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        assistant.description!,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppTheme.gray500,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AssistantEditPage(assistantId: assistant.id),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Symbols.edit,
                                  size: 20,
                                  color: AppTheme.gray400,
                                ),
                              ),
                              ToggleSwitch(
                                checked: assistant.enabled,
                                onChange: (v) => assistantProvider.toggleAssistant(assistant.id),
                              ),
                              IconButton(
                                onPressed: () => assistantProvider.deleteAssistant(assistant.id),
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

class DefaultModelPage extends StatelessWidget {
  final VoidCallback onBack;
  const DefaultModelPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = provider.Provider.of<SettingsProvider>(context);

    // 构建可用模型列表
    final List<Map<String, dynamic>> availableModels = [];

    // 添加"使用当前对话模型"选项
    availableModels.add({
      'displayName': '使用当前对话模型',
      'provider': null,
      'modelId': null,
      'isDefault': true,
    });

    // 从 providerConfigs 中提取所有已启用的模型
    for (final entry in settings.providerConfigs.entries) {
      final providerKey = entry.key;
      final config = entry.value;

      // 只显示已启用的服务商
      if (!config.enabled) continue;

      // 遍历该服务商的所有模型
      for (final modelId in config.models) {
        // 获取模型的显示名称
        String modelDisplayName = modelId;
        final overrides = config.modelOverrides[modelId];
        if (overrides != null && overrides is Map) {
          final customName = overrides['name']?.toString().trim();
          if (customName != null && customName.isNotEmpty) {
            modelDisplayName = customName;
          } else {
            final apiId = (overrides['apiModelId'] ?? overrides['api_model_id'])?.toString().trim();
            if (apiId != null && apiId.isNotEmpty) {
              modelDisplayName = apiId;
            }
          }
        }

        availableModels.add({
          'displayName': modelDisplayName,
          'provider': providerKey,
          'modelId': modelId,
          'providerName': config.name.isNotEmpty ? config.name : providerKey,
          'isDefault': false,
        });
      }
    }

    // 判断当前选中的模型
    bool isModelSelected(Map<String, dynamic> model) {
      if (model['isDefault'] == true) {
        // "使用当前对话模型"选项：当未设置时选中
        return settings.currentModelProvider == null || settings.currentModelId == null;
      } else {
        // 具体模型：比对 provider 和 modelId
        return settings.currentModelProvider == model['provider'] &&
               settings.currentModelId == model['modelId'];
      }
    }

    // 选择模型的回调
    Future<void> selectModel(Map<String, dynamic> model) async {
      if (model['isDefault'] == true) {
        // 重置为使用当前对话模型
        await settings.resetCurrentModel();
      } else {
        // 设置具体模型
        await settings.setCurrentModel(
          model['provider'] as String,
          model['modelId'] as String,
        );
      }
    }

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '默认模型', onBack: onBack),
            Expanded(
              child: availableModels.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Symbols.info,
                            size: 64,
                            color: AppTheme.gray400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '暂无可用模型',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.gray500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '请先在服务商设置中配置模型',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.gray400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        SectionGroup(
                          title: '选择默认模型',
                          children: availableModels.map((model) {
                            final isDefault = model['isDefault'] == true;
                            return SelectionItem(
                              label: model['displayName'] as String,
                              subtitle: isDefault ? null : model['providerName'] as String?,
                              selected: isModelSelected(model),
                              onTap: () => selectModel(model),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        // 提示信息
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '默认模型将用于新建的聊天会话。如果选择"使用当前对话模型"，则使用当前会话的模型。',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.gray500,
                              height: 1.5,
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

/// 搜索服务设置页面 - 连接 SettingsProvider 实现持久化
class SearchSettingsPage extends StatelessWidget {
  final VoidCallback onBack;
  const SearchSettingsPage({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = provider.Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SettingsHeader(title: '搜索服务', onBack: onBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 启用搜索开关
                  SectionGroup(
                    title: '搜索设置',
                    children: [
                      ToggleItem(
                        label: '启用搜索',
                        checked: settings.searchEnabled,
                        onChange: (value) => settings.setSearchEnabled(value),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 搜索引擎选择
                  Opacity(
                    opacity: settings.searchEnabled ? 1.0 : 0.5,
                    child: IgnorePointer(
                      ignoring: !settings.searchEnabled,
                      child: SectionGroup(
                        title: '搜索引擎',
                        children: settings.searchServices.isEmpty
                            ? [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    '暂无可用搜索服务',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.gray500,
                                    ),
                                  ),
                                ),
                              ]
                            : List.generate(
                                settings.searchServices.length,
                                (index) {
                                  final service = settings.searchServices[index];
                                  // 根据类型生成显示名称
                                  final displayName = service.map(
                                    bingLocal: (_) => 'Bing (本地)',
                                    duckDuckGo: (_) => 'DuckDuckGo',
                                    tavily: (_) => 'Tavily',
                                    exa: (_) => 'Exa',
                                    zhipu: (_) => '智谱搜索',
                                    searxng: (_) => 'SearXNG',
                                    linkup: (_) => 'LinkUp',
                                    brave: (_) => 'Brave Search',
                                    metaso: (_) => 'Metaso',
                                    jina: (_) => 'Jina',
                                    ollama: (_) => 'Ollama',
                                    perplexity: (_) => 'Perplexity',
                                    bocha: (_) => 'Bocha',
                                  );
                                  return SelectionItem(
                                    label: displayName,
                                    selected: settings.searchServiceSelected == index,
                                    onTap: () => settings.setSearchServiceSelected(index),
                                    icon: Symbols.search,
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 说明信息
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '搜索服务可以让 AI 获取最新的网络信息来回答问题。启用后，AI 会在需要时自动搜索相关内容。',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.gray500,
                        height: 1.5,
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

class MCPSettingsPage extends StatelessWidget {
  final VoidCallback onBack;
  const MCPSettingsPage({super.key, required this.onBack});

  /// 显示添加/编辑 MCP 服务器对话框
  void _showServerDialog(BuildContext context, {int? editIndex}) {
    final settings = provider.Provider.of<SettingsProvider>(context, listen: false);
    final isEdit = editIndex != null;
    final existingServer = isEdit ? settings.mcpServers[editIndex] : null;

    // 初始化表单字段
    final nameController = TextEditingController(text: existingServer?.name ?? '');
    final commandController = TextEditingController(text: existingServer?.command ?? 'npx');
    final argsController = TextEditingController(text: existingServer?.args.join(' ') ?? '');
    final descriptionController = TextEditingController(text: existingServer?.description ?? '');
    bool enabled = existingServer?.enabled ?? true;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: isDark ? AppTheme.cardDark : AppTheme.cardLight,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            isEdit ? '编辑 MCP 服务器' : '添加 MCP 服务器',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDark ? AppTheme.gray100 : AppTheme.gray900,
            ),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 服务器名称
                  Text(
                    '服务器名称',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.gray500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                    ),
                    decoration: InputDecoration(
                      hintText: '例如: filesystem',
                      hintStyle: TextStyle(color: AppTheme.gray400),
                      filled: true,
                      fillColor: isDark ? AppTheme.gray800 : AppTheme.gray100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 启动命令
                  Text(
                    '启动命令',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.gray500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: commandController,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                      fontFamily: 'monospace',
                    ),
                    decoration: InputDecoration(
                      hintText: '例如: npx',
                      hintStyle: TextStyle(color: AppTheme.gray400),
                      filled: true,
                      fillColor: isDark ? AppTheme.gray800 : AppTheme.gray100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 命令参数
                  Text(
                    '命令参数（空格分隔）',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.gray500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: argsController,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                      fontFamily: 'monospace',
                    ),
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: '例如: -y @modelcontextprotocol/server-filesystem /path',
                      hintStyle: TextStyle(color: AppTheme.gray400),
                      filled: true,
                      fillColor: isDark ? AppTheme.gray800 : AppTheme.gray100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 描述
                  Text(
                    '描述（可选）',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.gray500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descriptionController,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                    ),
                    decoration: InputDecoration(
                      hintText: '描述服务器用途',
                      hintStyle: TextStyle(color: AppTheme.gray400),
                      filled: true,
                      fillColor: isDark ? AppTheme.gray800 : AppTheme.gray100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 启用开关
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '启用此服务器',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                        ),
                      ),
                      ToggleSwitch(
                        checked: enabled,
                        onChange: (value) {
                          setDialogState(() {
                            enabled = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                '取消',
                style: TextStyle(color: AppTheme.gray500),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final command = commandController.text.trim();
                final argsText = argsController.text.trim();
                final description = descriptionController.text.trim();

                // 验证必填字段
                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('请输入服务器名称')),
                  );
                  return;
                }
                if (command.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('请输入启动命令')),
                  );
                  return;
                }

                // 解析参数（按空格分割）
                final args = argsText.isEmpty ? <String>[] : argsText.split(RegExp(r'\s+'));

                final server = MCPServerConfig(
                  id: existingServer?.id ?? 'mcp_${DateTime.now().millisecondsSinceEpoch}',
                  name: name,
                  command: command,
                  args: args,
                  enabled: enabled,
                  description: description,
                  tools: existingServer?.tools ?? [],
                  status: existingServer?.status ?? 'stopped',
                );

                // 添加或更新服务器
                if (isEdit) {
                  await settings.updateMcpServer(editIndex, server);
                } else {
                  await settings.addMcpServer(server);
                }

                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }

                // 显示成功提示
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEdit ? '服务器已更新' : '服务器已添加'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.gray900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(isEdit ? '更新' : '添加'),
            ),
          ],
        ),
      ),
    );
  }

  /// 删除服务器（带确认）
  void _deleteServer(BuildContext context, int index) {
    final settings = provider.Provider.of<SettingsProvider>(context, listen: false);
    final server = settings.mcpServers[index];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: isDark ? AppTheme.cardDark : AppTheme.cardLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          '删除服务器',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? AppTheme.gray100 : AppTheme.gray900,
          ),
        ),
        content: Text(
          '确定要删除 "${server.name}" 吗？此操作无法撤销。',
          style: TextStyle(
            fontSize: 14,
            color: isDark ? AppTheme.gray300 : AppTheme.gray700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              '取消',
              style: TextStyle(color: AppTheme.gray500),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await settings.removeMcpServer(index);
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('服务器已删除'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  /// 切换服务器启用状态
  void _toggleServer(BuildContext context, int index) async {
    final settings = provider.Provider.of<SettingsProvider>(context, listen: false);
    final server = settings.mcpServers[index];
    final updated = MCPServerConfig(
      id: server.id,
      name: server.name,
      command: server.command,
      args: server.args,
      env: server.env,
      enabled: !server.enabled,
      description: server.description,
      tools: server.tools,
      status: server.status,
    );
    await settings.updateMcpServer(index, updated);
  }

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
            SettingsHeader(
              title: 'MCP',
              onBack: onBack,
              actionIcon: Symbols.add,
              onAction: () => _showServerDialog(context),
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
                  if (servers.isEmpty)
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
                            const SizedBox(height: 8),
                            Text(
                              '点击右上角 + 号添加服务器',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.gray400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...servers.asMap().entries.map((entry) {
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
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _showServerDialog(context, editIndex: index),
                            borderRadius: BorderRadius.circular(16),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              server.name,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                              ),
                                            ),
                                            if (server.description.isNotEmpty) ...[
                                              const SizedBox(width: 8),
                                              Flexible(
                                                child: Text(
                                                  server.description,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppTheme.gray400,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${server.command} ${server.args.join(' ')}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: AppTheme.gray500,
                                            fontFamily: 'monospace',
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (server.tools.isNotEmpty) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            '${server.tools.length} 个工具',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.gray400,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  ToggleSwitch(
                                    checked: server.enabled,
                                    onChange: (v) => _toggleServer(context, index),
                                  ),
                                  IconButton(
                                    onPressed: () => _deleteServer(context, index),
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

/// 快捷短语设置页面 - 使用 Riverpod 连接 quickPhrasesProvider
class QuickPhraseSettingsPage extends ConsumerStatefulWidget {
  final VoidCallback onBack;
  const QuickPhraseSettingsPage({super.key, required this.onBack});

  @override
  ConsumerState<QuickPhraseSettingsPage> createState() => _QuickPhraseSettingsPageState();
}

class _QuickPhraseSettingsPageState extends ConsumerState<QuickPhraseSettingsPage> {
  /// 添加新短语
  void _addPhrase() {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    _showEditDialog(
      onSave: (title, content) {
        ref.read(quickPhrasesProvider.notifier).addPhrase(
          QuickPhrase(
            id: newId,
            phrase: content,
            shortcut: title,
          ),
        );
      },
    );
  }

  /// 编辑短语
  void _editPhrase(QuickPhrase phrase) {
    _showEditDialog(
      initialTitle: phrase.shortcut,
      initialContent: phrase.phrase,
      onSave: (title, content) {
        ref.read(quickPhrasesProvider.notifier).updatePhrase(
          QuickPhrase(
            id: phrase.id,
            phrase: content,
            shortcut: title,
          ),
        );
      },
    );
  }

  /// 删除短语（带确认）
  void _deletePhrase(QuickPhrase phrase) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppTheme.cardDark : AppTheme.cardLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          '删除短语',
          style: TextStyle(
            color: isDark ? AppTheme.gray100 : AppTheme.gray900,
          ),
        ),
        content: Text(
          '确定要删除 "${phrase.shortcut}" 吗？',
          style: TextStyle(
            color: isDark ? AppTheme.gray300 : AppTheme.gray700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '取消',
              style: TextStyle(color: AppTheme.gray500),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(quickPhrasesProvider.notifier).deletePhrase(phrase.id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  /// 显示编辑对话框
  void _showEditDialog({
    String? initialTitle,
    String? initialContent,
    required Function(String title, String content) onSave,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleController = TextEditingController(text: initialTitle ?? '');
    final contentController = TextEditingController(text: initialContent ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: isDark ? AppTheme.cardDark : AppTheme.cardLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          initialTitle == null ? '添加快捷短语' : '编辑快捷短语',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? AppTheme.gray100 : AppTheme.gray900,
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '快捷键',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.gray500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: '例如：翻译、总结',
                  hintStyle: TextStyle(color: AppTheme.gray400),
                  filled: true,
                  fillColor: isDark ? AppTheme.gray800 : AppTheme.gray100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: TextStyle(
                  color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '短语内容',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.gray500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: contentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: '输入短语内容',
                  hintStyle: TextStyle(color: AppTheme.gray400),
                  filled: true,
                  fillColor: isDark ? AppTheme.gray800 : AppTheme.gray100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: TextStyle(
                  color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              '取消',
              style: TextStyle(color: AppTheme.gray500),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final title = titleController.text.trim();
              final content = contentController.text.trim();

              if (title.isEmpty || content.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('标题和内容不能为空')),
                );
                return;
              }

              onSave(title, content);
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: AppTheme.gray900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final phrases = ref.watch(quickPhrasesProvider);

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
                  if (phrases.isEmpty)
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
                            const SizedBox(height: 8),
                            Text(
                              '点击右上角 + 号添加',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.gray400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SectionGroup(
                      children: phrases.map((phrase) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _editPhrase(phrase),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          phrase.shortcut,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          phrase.phrase,
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
                                    onPressed: () => _deletePhrase(phrase),
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
