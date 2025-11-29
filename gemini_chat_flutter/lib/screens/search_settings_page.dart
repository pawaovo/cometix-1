import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:material_symbols_icons/symbols.dart';
import 'package:uuid/uuid.dart';
import '../theme/app_theme.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_widgets.dart';
import '../models/search_service.dart';

/// 搜索服务设置页面
class SearchSettingsPage extends StatefulWidget {
  final VoidCallback onBack;

  const SearchSettingsPage({super.key, required this.onBack});

  @override
  State<SearchSettingsPage> createState() => _SearchSettingsPageState();
}

class _SearchSettingsPageState extends State<SearchSettingsPage> {
  final Map<String, bool> _testing = {};

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = provider.Provider.of<SettingsProvider>(context);
    final services = settings.searchServices;
    final selected = settings.searchServiceSelected.clamp(0, services.isNotEmpty ? services.length - 1 : 0);
    final common = settings.searchCommonOptions;

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
                  // 添加按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '搜索服务列表',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Symbols.add, size: 20),
                        onPressed: () => _showAddServiceDialog(context, settings),
                        tooltip: '添加搜索服务',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 服务列表
                  ...List.generate(services.length, (index) {
                    final service = services[index];
                    final serviceId = service.map(
                      bingLocal: (s) => s.id,
                      duckDuckGo: (s) => s.id,
                      tavily: (s) => s.id,
                      exa: (s) => s.id,
                      zhipu: (s) => s.id,
                      searxng: (s) => s.id,
                      linkup: (s) => s.id,
                      brave: (s) => s.id,
                      metaso: (s) => s.id,
                      jina: (s) => s.id,
                      ollama: (s) => s.id,
                      perplexity: (s) => s.id,
                      bocha: (s) => s.id,
                    );

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ServiceCard(
                        service: service,
                        selected: index == selected,
                        testing: _testing[serviceId] == true,
                        connection: settings.searchConnection[serviceId],
                        onTap: () => settings.setSearchServiceSelected(index),
                        onEdit: () => _showEditServiceDialog(context, settings, service, index),
                        onDelete: () => _deleteService(settings, index),
                        onTest: () => _testConnection(settings, service, serviceId),
                      ),
                    );
                  }),

                  const SizedBox(height: 16),

                  // 通用配置
                  shadcn.Card(
                    filled: true,
                    fillColor: isDark ? AppTheme.gray900.withOpacity(0.3) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    borderColor: isDark ? AppTheme.gray800 : AppTheme.gray200,
                    borderWidth: 1,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '通用配置',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppTheme.gray300 : AppTheme.gray700,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 最大结果数
                        _StepperRow(
                          icon: Symbols.format_list_numbered,
                          label: '最大结果数',
                          value: common.resultSize,
                          onMinus: common.resultSize > 1
                              ? () => settings.setSearchCommonOptions(
                                    SearchCommonOptions(
                                      resultSize: common.resultSize - 1,
                                      timeout: common.timeout,
                                    ),
                                  )
                              : null,
                          onPlus: common.resultSize < 20
                              ? () => settings.setSearchCommonOptions(
                                    SearchCommonOptions(
                                      resultSize: common.resultSize + 1,
                                      timeout: common.timeout,
                                    ),
                                  )
                              : null,
                        ),
                        const Divider(height: 24),

                        // 超时时间
                        _StepperRow(
                          icon: Symbols.timer,
                          label: '超时时间（秒）',
                          value: common.timeout ~/ 1000,
                          onMinus: common.timeout > 1000
                              ? () => settings.setSearchCommonOptions(
                                    SearchCommonOptions(
                                      resultSize: common.resultSize,
                                      timeout: common.timeout - 1000,
                                    ),
                                  )
                              : null,
                          onPlus: common.timeout < 30000
                              ? () => settings.setSearchCommonOptions(
                                    SearchCommonOptions(
                                      resultSize: common.resultSize,
                                      timeout: common.timeout + 1000,
                                    ),
                                  )
                              : null,
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

  void _deleteService(SettingsProvider settings, int index) {
    final services = List<SearchServiceOptions>.from(settings.searchServices);
    if (services.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('至少需要保留一个搜索服务')),
      );
      return;
    }
    services.removeAt(index);
    settings.setSearchServices(services);
  }

  Future<void> _testConnection(SettingsProvider settings, SearchServiceOptions service, String serviceId) async {
    setState(() => _testing[serviceId] = true);
    await Future.delayed(const Duration(seconds: 1)); // 模拟测试
    settings.setSearchConnection(serviceId, true); // 模拟成功
    if (mounted) setState(() => _testing[serviceId] = false);
  }

  void _showAddServiceDialog(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (ctx) => _AddServiceDialog(
        onAdd: (service) {
          final services = List<SearchServiceOptions>.from(settings.searchServices)..add(service);
          settings.setSearchServices(services);
        },
      ),
    );
  }

  void _showEditServiceDialog(BuildContext context, SettingsProvider settings, SearchServiceOptions service, int index) {
    showDialog(
      context: context,
      builder: (ctx) => _EditServiceDialog(
        service: service,
        onSave: (updated) {
          final services = List<SearchServiceOptions>.from(settings.searchServices);
          services[index] = updated;
          settings.setSearchServices(services);
        },
      ),
    );
  }
}

/// 服务卡片
class _ServiceCard extends StatelessWidget {
  final SearchServiceOptions service;
  final bool selected;
  final bool testing;
  final bool? connection;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTest;

  const _ServiceCard({
    required this.service,
    required this.selected,
    required this.testing,
    required this.connection,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onTest,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final serviceName = service.map(
      bingLocal: (_) => 'Bing (本地)',
      duckDuckGo: (_) => 'DuckDuckGo',
      tavily: (_) => 'Tavily',
      exa: (_) => 'Exa',
      zhipu: (_) => 'Zhipu',
      searxng: (_) => 'SearXNG',
      linkup: (_) => 'LinkUp',
      brave: (_) => 'Brave',
      metaso: (_) => 'Metaso',
      jina: (_) => 'Jina',
      ollama: (_) => 'Ollama',
      perplexity: (_) => 'Perplexity',
      bocha: (_) => 'Bocha',
    );

    String statusText;
    Color statusColor;
    if (testing) {
      statusText = '测试中';
      statusColor = Colors.blue;
    } else if (connection == true) {
      statusText = '已连接';
      statusColor = Colors.green;
    } else if (connection == false) {
      statusText = '连接失败';
      statusColor = Colors.orange;
    } else {
      statusText = '未测试';
      statusColor = isDark ? AppTheme.gray500 : AppTheme.gray400;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: shadcn.Card(
        filled: true,
        fillColor: selected
            ? (isDark ? AppTheme.primaryColor.withOpacity(0.1) : AppTheme.primaryColor.withOpacity(0.05))
            : (isDark ? AppTheme.gray900.withOpacity(0.3) : Colors.white),
        borderRadius: BorderRadius.circular(16),
        borderColor: selected ? AppTheme.primaryColor : (isDark ? AppTheme.gray800 : AppTheme.gray200),
        borderWidth: selected ? 2 : 1,
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // 图标
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  serviceName[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // 名称
            Expanded(
              child: Text(
                serviceName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                ),
              ),
            ),

            // 状态
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                statusText,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
            const SizedBox(width: 8),

            // 操作按钮
            IconButton(
              icon: const Icon(Symbols.edit, size: 18),
              onPressed: onEdit,
              tooltip: '编辑',
            ),
            IconButton(
              icon: const Icon(Symbols.wifi_find, size: 18),
              onPressed: onTest,
              tooltip: '测试连接',
            ),
            IconButton(
              icon: const Icon(Symbols.delete, size: 18),
              onPressed: onDelete,
              tooltip: '删除',
            ),
          ],
        ),
      ),
    );
  }
}

/// 步进器行
class _StepperRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;

  const _StepperRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onMinus,
    this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Icon(icon, size: 18, color: isDark ? AppTheme.gray400 : AppTheme.gray600),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: isDark ? AppTheme.gray100 : AppTheme.gray900,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Symbols.remove, size: 16),
          onPressed: onMinus,
        ),
        Container(
          width: 42,
          alignment: Alignment.center,
          child: Text(
            '$value',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? AppTheme.gray100 : AppTheme.gray900,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Symbols.add, size: 16),
          onPressed: onPlus,
        ),
      ],
    );
  }
}

/// 添加服务对话框
class _AddServiceDialog extends StatefulWidget {
  final Function(SearchServiceOptions) onAdd;

  const _AddServiceDialog({required this.onAdd});

  @override
  State<_AddServiceDialog> createState() => _AddServiceDialogState();
}

class _AddServiceDialogState extends State<_AddServiceDialog> {
  String _selectedType = 'bing_local';
  final _apiKeyController = TextEditingController();

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('添加搜索服务'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedType,
            decoration: const InputDecoration(labelText: '服务类型'),
            items: const [
              DropdownMenuItem(value: 'bing_local', child: Text('Bing (本地)')),
              DropdownMenuItem(value: 'duckduckgo', child: Text('DuckDuckGo')),
              DropdownMenuItem(value: 'tavily', child: Text('Tavily')),
              DropdownMenuItem(value: 'brave', child: Text('Brave')),
            ],
            onChanged: (value) => setState(() => _selectedType = value!),
          ),
          if (_selectedType != 'bing_local' && _selectedType != 'duckduckgo') ...[
            const SizedBox(height: 16),
            TextField(
              controller: _apiKeyController,
              decoration: const InputDecoration(
                labelText: 'API Key',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            final id = const Uuid().v4().substring(0, 8);
            SearchServiceOptions service;

            switch (_selectedType) {
              case 'duckduckgo':
                service = SearchServiceOptions.duckDuckGo(id: id);
                break;
              case 'tavily':
                service = SearchServiceOptions.tavily(id: id, apiKey: _apiKeyController.text);
                break;
              case 'brave':
                service = SearchServiceOptions.brave(id: id, apiKey: _apiKeyController.text);
                break;
              default:
                service = SearchServiceOptions.bingLocal(id: id);
            }

            widget.onAdd(service);
            Navigator.pop(context);
          },
          child: const Text('添加'),
        ),
      ],
    );
  }
}

/// 编辑服务对话框
class _EditServiceDialog extends StatefulWidget {
  final SearchServiceOptions service;
  final Function(SearchServiceOptions) onSave;

  const _EditServiceDialog({required this.service, required this.onSave});

  @override
  State<_EditServiceDialog> createState() => _EditServiceDialogState();
}

class _EditServiceDialogState extends State<_EditServiceDialog> {
  late TextEditingController _apiKeyController;

  @override
  void initState() {
    super.initState();
    final apiKey = widget.service.maybeMap(
      tavily: (s) => s.apiKey,
      brave: (s) => s.apiKey,
      orElse: () => '',
    );
    _apiKeyController = TextEditingController(text: apiKey);
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serviceName = widget.service.map(
      bingLocal: (_) => 'Bing (本地)',
      duckDuckGo: (_) => 'DuckDuckGo',
      tavily: (_) => 'Tavily',
      exa: (_) => 'Exa',
      zhipu: (_) => 'Zhipu',
      searxng: (_) => 'SearXNG',
      linkup: (_) => 'LinkUp',
      brave: (_) => 'Brave',
      metaso: (_) => 'Metaso',
      jina: (_) => 'Jina',
      ollama: (_) => 'Ollama',
      perplexity: (_) => 'Perplexity',
      bocha: (_) => 'Bocha',
    );

    final needsApiKey = widget.service.maybeMap(
      bingLocal: (_) => false,
      duckDuckGo: (_) => false,
      orElse: () => true,
    );

    return AlertDialog(
      title: Text('编辑 $serviceName'),
      content: needsApiKey
          ? TextField(
              controller: _apiKeyController,
              decoration: const InputDecoration(
                labelText: 'API Key',
                border: OutlineInputBorder(),
              ),
            )
          : const Text('此服务无需配置'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            final updated = widget.service.map(
              bingLocal: (s) => s,
              duckDuckGo: (s) => s,
              tavily: (s) => SearchServiceOptions.tavily(id: s.id, apiKey: _apiKeyController.text),
              exa: (s) => SearchServiceOptions.exa(id: s.id, apiKey: _apiKeyController.text),
              zhipu: (s) => SearchServiceOptions.zhipu(id: s.id, apiKey: _apiKeyController.text),
              searxng: (s) => s,
              linkup: (s) => SearchServiceOptions.linkup(id: s.id, apiKey: _apiKeyController.text),
              brave: (s) => SearchServiceOptions.brave(id: s.id, apiKey: _apiKeyController.text),
              metaso: (s) => SearchServiceOptions.metaso(id: s.id, apiKey: _apiKeyController.text),
              jina: (s) => SearchServiceOptions.jina(id: s.id, apiKey: _apiKeyController.text),
              ollama: (s) => SearchServiceOptions.ollama(id: s.id, apiKey: _apiKeyController.text),
              perplexity: (s) => SearchServiceOptions.perplexity(id: s.id, apiKey: _apiKeyController.text),
              bocha: (s) => SearchServiceOptions.bocha(id: s.id, apiKey: _apiKeyController.text),
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
