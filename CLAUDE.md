# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## 项目概述

这是一个 **Flutter 实现的多模型 AI Chat 应用**，位于 `gemini_chat_flutter/` 目录。

**核心特性**：
- 独特的 Zoom Drawer 侧边栏动画（缩放 + 滑动效果）
- **多服务商支持**（Gemini、OpenAI、Anthropic 等）
- 流式 AI 对话
- 快捷短语系统（完整 CRUD）
- 深色模式支持
- Markdown 渲染
- **shadcn_flutter 设计系统**（已完成 100% 迁移）
- Material 3 设计语言
- TTS 语音朗读
- 触感反馈系统
- MCP 服务器配置
- 网络代理支持
- WebDAV 备份

**技术栈**：
- Flutter 3.38.3+ / Dart 3.10.1+
- **shadcn_flutter ^0.0.47**（UI 组件库）
- Riverpod + Provider（混合状态管理）
- Freezed（不可变数据模型）
- google_generative_ai（Gemini SDK）
- flutter_markdown（Markdown 渲染）
- flutter_tts（语音朗读）
- url_launcher（外部链接）

---

## 开发命令

**工作目录**：所有命令在 `gemini_chat_flutter/` 目录下执行

```bash
# 安装依赖
flutter pub get

# 生成 Freezed 代码（数据模型）
dart run build_runner build --delete-conflicting-outputs

# 运行应用（开发模式）
flutter run

# 运行在特定平台
flutter run -d android
flutter run -d ios
flutter run -d chrome  # Web

# 热重载：按 r
# 热重启：按 R

# 构建 Release 版本
flutter build apk --release  # Android
flutter build ios --release  # iOS

# 清理构建缓存
flutter clean
flutter pub get
```

---

## 架构设计

### 项目结构

```
gemini_chat_flutter/
├── lib/
│   ├── main.dart                 # 应用入口
│   ├── models/                   # Freezed 数据模型（10+）
│   │   ├── message.dart          # 聊天消息
│   │   ├── assistant.dart        # AI 助手配置（含记忆和快捷短语）
│   │   ├── chat_session.dart     # 会话管理
│   │   ├── quick_phrase.dart     # 快捷短语
│   │   ├── provider_config.dart  # 服务商配置
│   │   ├── mcp_config.dart       # MCP 服务器配置
│   │   ├── proxy_config.dart     # 代理配置
│   │   ├── search_service.dart   # 搜索服务（Union Type）
│   │   └── theme_palette.dart    # 主题色板
│   ├── providers/                # 状态管理（7+）
│   │   ├── settings_provider.dart    # 全局设置（核心）
│   │   ├── messages_provider.dart
│   │   ├── quick_phrases_provider.dart
│   │   ├── assistant_provider.dart
│   │   ├── ai_service_provider.dart
│   │   └── gemini_service_provider.dart
│   ├── screens/                  # 页面（16+）
│   │   ├── home_screen.dart      # Zoom Drawer 容器
│   │   ├── chat_screen.dart      # 聊天界面
│   │   ├── settings_screen.dart  # 设置主页面
│   │   ├── settings_pages.dart   # 设置子页面集合
│   │   ├── providers_page.dart   # 服务商管理
│   │   ├── tts_settings_page.dart
│   │   ├── haptic_settings_page.dart
│   │   ├── theme_palette_page.dart
│   │   ├── backup_settings_page.dart
│   │   ├── chat_storage_page.dart
│   │   └── assistant_edit_page.dart  # 4Tab 助手编辑（实时保存）
│   ├── widgets/                  # 可复用组件
│   │   ├── sidebar.dart          # 侧边栏导航
│   │   ├── input_bar.dart        # 复杂输入组件
│   │   ├── settings_widgets.dart # 设置页面组件库
│   │   └── haptic_feedback_wrapper.dart
│   ├── services/                 # 业务逻辑（6+）
│   │   ├── gemini_service.dart   # Gemini API
│   │   ├── openai_service.dart   # OpenAI API
│   │   ├── anthropic_service.dart # Anthropic API
│   │   ├── ai_service.dart       # AI 服务抽象
│   │   ├── ai_service_factory.dart
│   │   ├── tts_service.dart      # 语音朗读
│   │   ├── haptic_service.dart   # 触感反馈
│   │   └── backup_service.dart   # WebDAV 备份
│   └── theme/
│       └── app_theme.dart        # 主题配置
├── test/                         # 测试文件
└── pubspec.yaml                  # 依赖配置
```

### 状态管理架构

**混合模式**：Provider + Riverpod

```dart
// Provider 模式（大部分设置页面）
final settings = provider.Provider.of<SettingsProvider>(context);
await settings.setThemeMode(ThemeMode.dark);

// Riverpod 模式（快捷短语）
final phrases = ref.watch(quickPhrasesProvider);
ref.read(quickPhrasesProvider.notifier).addPhrase(phrase);
```

### 关键技术决策

**数据模型：Freezed**
- 不可变对象 + copyWith
- JSON 序列化/反序列化
- Union types（如 SearchServiceOptions 支持 13 种搜索引擎）

**UI 组件：shadcn_flutter + Material 3**
- shadcn 组件优先
- Material 3 作为补充
- 统一的深色/浅色模式

---

## 设置页面架构

### 页面状态总览

| 页面 | 文件位置 | 状态管理 | 持久化 |
|-----|---------|---------|-------|
| DisplaySettings | settings_pages.dart | SettingsProvider | ✅ |
| ThemePalette | theme_palette_page.dart | SettingsProvider | ✅ |
| HapticSettings | haptic_settings_page.dart | SettingsProvider | ✅ |
| TTSSettings | tts_settings_page.dart | SettingsProvider | ✅ |
| AssistantSettings | settings_pages.dart | AssistantProvider | ✅ |
| DefaultModel | settings_pages.dart | SettingsProvider | ✅ |
| Providers | providers_page.dart | SettingsProvider | ✅ |
| Search | settings_pages.dart | SettingsProvider | ✅ |
| MCP | settings_pages.dart | SettingsProvider | ✅ |
| QuickPhrase | settings_pages.dart | Riverpod | ✅ |
| Proxy | settings_pages.dart | SettingsProvider | ✅ |
| Backup | backup_settings_page.dart | BackupProvider | ✅ |
| ChatStorage | chat_storage_page.dart | SettingsProvider | ✅ |
| About | settings_pages.dart | - | - |
| Docs | settings_pages.dart | - | - |
| Sponsor | settings_pages.dart | - | - |

### 公共工具函数

```dart
// 文件顶部定义，所有页面共享
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
```

---

## 核心实现细节

### 1. Zoom Drawer 动画

位置：`lib/screens/home_screen.dart`

```dart
// AnimationController 控制动画时长（300ms）
// Transform.scale 实现缩放效果（1.0 → 0.95）
// Transform.translate 实现水平滑动（0 → 80% 屏幕宽度）
```

### 2. 多服务商 AI 服务

位置：`lib/services/ai_service_factory.dart`

```dart
// 工厂模式创建 AI 服务
AIService createService(String provider) {
  switch (provider) {
    case 'gemini': return GeminiService();
    case 'openai': return OpenAIService();
    case 'anthropic': return AnthropicService();
    // ...
  }
}
```

### 3. Freezed Union Types

位置：`lib/models/search_service.dart`

```dart
@freezed
class SearchServiceOptions with _$SearchServiceOptions {
  const factory SearchServiceOptions.bingLocal({required String id}) = BingLocalOptions;
  const factory SearchServiceOptions.duckDuckGo({required String id, ...}) = DuckDuckGoOptions;
  const factory SearchServiceOptions.tavily({required String id, required String apiKey}) = TavilyOptions;
  // 支持 13 种搜索引擎
}

// 使用 .map() 获取类型特定的显示名称
final displayName = service.map(
  bingLocal: (_) => 'Bing (本地)',
  duckDuckGo: (_) => 'DuckDuckGo',
  // ...
);
```

### 4. 代理测试功能

位置：`lib/screens/settings_pages.dart` - ProxySettingsPage

```dart
// 8 秒超时测试
final io = HttpClient();
io.findProxy = (_) => 'PROXY $host:$port';
final client = IOClient(io);
final res = await client.get(Uri.parse(url)).timeout(
  const Duration(seconds: 8),
);
```

### 5. 助手编辑页面（4Tab 布局）

位置：`lib/screens/assistant_edit_page.dart`

```dart
// 4个Tab：基础、提示词、记忆、快捷短语
TabBar(
  tabs: [Tab(text: '基础'), Tab(text: '提示词'), Tab(text: '记忆'), Tab(text: '快捷短语')],
)

// 实时保存（500ms 防抖）
void _onTextChanged() {
  _debounceTimer?.cancel();
  _debounceTimer = Timer(const Duration(milliseconds: 500), _saveAssistant);
}

// 通用输入对话框（减少重复代码）
void _showInputDialog({
  required String title,
  required String hint,
  required String confirmText,
  String initialValue = '',
  required void Function(String value) onConfirm,
}) { ... }
```

**Assistant 模型字段**：
```dart
@freezed
class Assistant {
  // 基础信息
  String id, name, description, systemPrompt;
  // 参数配置
  double temperature, topP;
  int contextMessageCount;
  bool streamOutput;
  // 记忆配置
  bool enableMemory, useHistoryChat;
  List<String> memories;
  // 快捷短语
  List<String> quickPhrases;
}
```

---

## 代码风格约定

### 核心规范

1. **注释必须使用中文**
2. **优先使用 shadcn_flutter 组件**
3. **状态管理**：设置相关用 Provider，其他用 Riverpod
4. **数据模型**：必须使用 Freezed

### Riverpod 页面模式

```dart
class QuickPhraseSettingsPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<QuickPhraseSettingsPage> createState() => _State();
}

class _State extends ConsumerState<QuickPhraseSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final phrases = ref.watch(quickPhrasesProvider);
    // ...
  }
}
```

### Provider 页面模式

```dart
class DefaultModelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = provider.Provider.of<SettingsProvider>(context);
    // ...
  }
}
```

---

## 项目状态

### 已完成功能 ✅

**核心功能**：
- Flutter 基础架构（Riverpod + Provider + Freezed）
- shadcn_flutter 组件迁移（100% 完成）
- Zoom Drawer 侧边栏动画
- 聊天界面与流式 AI 响应
- Markdown 渲染
- 深色模式支持

**设置系统**（全部持久化）：
- 显示设置（主题/语言/字体）
- 主题色板选择（圆形色块预览）
- 触感反馈设置（强度选择即触发反馈）
- TTS 语音设置（语言/语速/音量/音高）
- 助手管理（4Tab 编辑页面 + 实时保存）
  - 基础：名称、描述、参数配置
  - 提示词：系统提示词
  - 记忆：启用记忆、参考历史、管理记忆列表
  - 快捷短语：助手专属快捷短语
- 默认模型选择
- 服务商管理（多服务商配置）
- 搜索服务设置
- MCP 服务器配置（CRUD）
- 快捷短语管理（全局快捷短语）
- 网络代理设置（+ 连接测试）
- WebDAV 备份
- 聊天存储管理

**信息页面**：
- 关于页面
- 使用文档（外部链接）
- 赞助页面（爱发电 + 微信）

### 待开发功能 🚧

- 会话历史管理（侧边栏列表）
- 图片上传与多模态输入
- 消息操作菜单（复制/删除/重新生成）
- 语音输入（STT）
- 多语言国际化
- 桌面端快捷键

---

## 参考项目

本项目参考 `D:\ai\cometix\kelivo` 进行快速实现：
- 设置页面结构
- iOS 风格 UI 组件
- TTS 服务配置
- 代理测试逻辑

---

## 相关资源

- **Flutter 官方文档**: https://flutter.dev/docs
- **shadcn_flutter 文档**: https://pub.dev/packages/shadcn_flutter
- **Riverpod 文档**: https://riverpod.dev
- **Freezed 文档**: https://pub.dev/packages/freezed
- **Gemini API 文档**: https://ai.google.dev/docs
- **Material 3 设计**: https://m3.material.io/
