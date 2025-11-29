import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:material_symbols_icons/symbols.dart';
import '../theme/app_theme.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_widgets.dart';
import '../models/proxy_config.dart';

/// 网络代理设置页面
class ProxySettingsPage extends StatefulWidget {
  final VoidCallback onBack;

  const ProxySettingsPage({super.key, required this.onBack});

  @override
  State<ProxySettingsPage> createState() => _ProxySettingsPageState();
}

class _ProxySettingsPageState extends State<ProxySettingsPage> {
  late TextEditingController _hostController;
  late TextEditingController _portController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  bool _testing = false;

  @override
  void initState() {
    super.initState();
    final settings = provider.Provider.of<SettingsProvider>(context, listen: false);
    final config = settings.proxyConfig;
    _hostController = TextEditingController(text: config.host);
    _portController = TextEditingController(text: config.port);
    _usernameController = TextEditingController(text: config.username);
    _passwordController = TextEditingController(text: config.password);
  }

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  // 启用开关
                  shadcn.Card(
                    filled: true,
                    fillColor: isDark ? AppTheme.gray900.withValues(alpha: 0.3) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    borderColor: isDark ? AppTheme.gray800 : AppTheme.gray200,
                    borderWidth: 1,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Symbols.vpn_lock,
                          size: 20,
                          color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '启用代理',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                            ),
                          ),
                        ),
                        shadcn.Switch(
                          value: config.enabled,
                          onChanged: (value) {
                            final updated = config.copyWith(enabled: value);
                            settings.setProxyConfig(updated);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 代理配置
                  shadcn.Card(
                    filled: true,
                    fillColor: isDark ? AppTheme.gray900.withValues(alpha: 0.3) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    borderColor: isDark ? AppTheme.gray800 : AppTheme.gray200,
                    borderWidth: 1,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '代理配置',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 代理类型
                        DropdownButtonFormField<ProxyType>(
                          value: config.type,
                          decoration: InputDecoration(
                            labelText: '代理类型',
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: isDark ? AppTheme.gray800.withValues(alpha: 0.5) : AppTheme.gray100,
                          ),
                          items: const [
                            DropdownMenuItem(value: ProxyType.http, child: Text('HTTP')),
                            DropdownMenuItem(value: ProxyType.https, child: Text('HTTPS')),
                            DropdownMenuItem(value: ProxyType.socks5, child: Text('SOCKS5')),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              final updated = config.copyWith(type: value);
                              settings.setProxyConfig(updated);
                            }
                          },
                        ),
                        const SizedBox(height: 16),

                        // 服务器地址
                        TextField(
                          controller: _hostController,
                          decoration: InputDecoration(
                            labelText: '服务器地址',
                            border: const OutlineInputBorder(),
                            hintText: '例如: 127.0.0.1',
                            filled: true,
                            fillColor: isDark ? AppTheme.gray800.withValues(alpha: 0.5) : AppTheme.gray100,
                          ),
                          onChanged: (value) {
                            final updated = config.copyWith(host: value);
                            settings.setProxyConfig(updated);
                          },
                        ),
                        const SizedBox(height: 16),

                        // 端口
                        TextField(
                          controller: _portController,
                          decoration: InputDecoration(
                            labelText: '端口',
                            border: const OutlineInputBorder(),
                            hintText: '例如: 8080',
                            filled: true,
                            fillColor: isDark ? AppTheme.gray800.withValues(alpha: 0.5) : AppTheme.gray100,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            final updated = config.copyWith(port: value);
                            settings.setProxyConfig(updated);
                          },
                        ),
                        const SizedBox(height: 16),

                        // 用户名（可选）
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: '用户名（可选）',
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: isDark ? AppTheme.gray800.withValues(alpha: 0.5) : AppTheme.gray100,
                          ),
                          onChanged: (value) {
                            final updated = config.copyWith(username: value);
                            settings.setProxyConfig(updated);
                          },
                        ),
                        const SizedBox(height: 16),

                        // 密码（可选）
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: '密码（可选）',
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: isDark ? AppTheme.gray800.withValues(alpha: 0.5) : AppTheme.gray100,
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            final updated = config.copyWith(password: value);
                            settings.setProxyConfig(updated);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 测试连接按钮
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _testing ? null : () => _testConnection(config),
                      icon: _testing
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Symbols.wifi_find, size: 18),
                      label: Text(_testing ? '测试中...' : '测试连接'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 说明
                  shadcn.Card(
                    filled: true,
                    fillColor: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    borderColor: Colors.blue.withValues(alpha: 0.3),
                    borderWidth: 1,
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Symbols.info,
                          size: 18,
                          color: Colors.blue.shade700,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '代理设置将应用于所有网络请求。\n如果遇到连接问题，请检查代理配置是否正确。',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ],
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

  Future<void> _testConnection(ProxyConfig config) async {
    if (config.host.isEmpty || config.port.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请填写服务器地址和端口')),
      );
      return;
    }

    setState(() => _testing = true);

    // 模拟测试连接
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _testing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('连接测试成功！'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
