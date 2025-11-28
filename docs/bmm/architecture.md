# Cometix Architecture

## Executive Summary

Cometix 采用 **Flutter 跨平台架构**，以 **Riverpod + Freezed** 为核心的状态管理和数据模型方案。架构设计围绕三个核心原则：

1. **本地优先** - 数据默认存储在设备本地，保护用户隐私
2. **模块化** - 清晰的分层架构，便于维护和扩展
3. **性能优先** - 针对移动端优化，确保流畅体验

**技术栈概览：**
- 框架：Flutter 3.38+ / Dart 3.10.1+
- UI：shadcn_flutter + Material 3
- 状态管理：Riverpod
- 数据模型：Freezed + JSON Serializable
- AI 集成：google_generative_ai (Gemini SDK)
- 本地存储：SharedPreferences / Hive

---

## Decision Summary

| Category | Decision | Version | Affects | Rationale |
|----------|----------|---------|---------|-----------|
| Framework | Flutter | 3.38+ | All | 跨平台、原生性能、成熟生态 |
| State | Riverpod | 2.5.1 | All | 类型安全、无 BuildContext 依赖 |
| Models | Freezed | 2.5.7 | Models | 不可变、自动生成 copyWith/JSON |
| UI | shadcn_flutter | 0.0.47 | UI | 现代设计、高度可定制 |
| AI SDK | google_generative_ai | 0.4.6 | AI | 官方 Gemini SDK、流式支持 |
| Storage | Hive | 2.x | Data | 高性能、加密支持、无 SQL |
| Icons | Material Symbols | 4.x | UI | 丰富图标、Material 3 风格 |

---

## Project Structure

```
gemini_chat_flutter/
├── lib/
│   ├── main.dart                 # 应用入口
│   │
│   ├── core/                     # 核心基础设施 (新增)
│   │   ├── constants/            # 常量定义
│   │   │   ├── app_constants.dart
│   │   │   └── storage_keys.dart
│   │   ├── utils/                # 工具函数
│   │   │   ├── extensions.dart
│   │   │   └── validators.dart
│   │   └── errors/               # 错误处理
│   │       └── app_exceptions.dart
│   │
│   ├── models/                   # 数据模型 (Freezed)
│   │   ├── message.dart
│   │   ├── chat_session.dart
│   │   ├── quick_phrase.dart
│   │   ├── assistant.dart
│   │   └── app_settings.dart     # 新增
│   │
│   ├── providers/                # 状态管理 (Riverpod)
│   │   ├── messages_provider.dart
│   │   ├── sessions_provider.dart    # 新增
│   │   ├── quick_phrases_provider.dart
│   │   ├── gemini_service_provider.dart
│   │   ├── settings_provider.dart    # 新增
│   │   └── theme_provider.dart       # 新增
│   │
│   ├── services/                 # 业务服务
│   │   ├── gemini_service.dart       # AI 服务
│   │   ├── storage_service.dart      # 本地存储 (新增)
│   │   ├── export_service.dart       # 导出服务 (新增)
│   │   └── image_service.dart        # 图片处理 (新增)
│   │
│   ├── repositories/             # 数据仓库 (新增)
│   │   ├── session_repository.dart
│   │   ├── message_repository.dart
│   │   └── settings_repository.dart
│   │
│   ├── screens/                  # 页面
│   │   ├── home_screen.dart
│   │   ├── chat_screen.dart
│   │   ├── settings_screen.dart
│   │   └── settings_pages.dart
│   │
│   ├── widgets/                  # 组件
│   │   ├── common/               # 通用组件 (新增)
│   │   │   ├── loading_indicator.dart
│   │   │   └── error_view.dart
│   │   ├── chat/                 # 聊天组件 (重组)
│   │   │   ├── message_bubble.dart
│   │   │   ├── message_list.dart
│   │   │   └── typing_indicator.dart
│   │   ├── sidebar.dart
│   │   ├── input_bar.dart
│   │   └── settings_widgets.dart
│   │
│   └── theme/                    # 主题
│       └── app_theme.dart
│
├── test/                         # 测试
│   ├── unit/
│   ├── widget/
│   └── integration/
│
├── assets/                       # 资源文件 (新增)
│   └── images/
│
└── pubspec.yaml
```

---

## Technology Stack Details

### Core Technologies

| 层级 | 技术 | 版本 | 用途 |
|------|------|------|------|
| **Framework** | Flutter | 3.38+ | 跨平台 UI 框架 |
| **Language** | Dart | 3.10.1+ | 主语言 |
| **UI Components** | shadcn_flutter | ^0.0.47 | 组件库 |
| **State Management** | flutter_riverpod | ^2.5.1 | 响应式状态 |
| **Data Models** | freezed | ^2.5.7 | 不可变模型 |
| **JSON** | json_serializable | ^6.8.0 | JSON 序列化 |
| **AI SDK** | google_generative_ai | ^0.4.6 | Gemini API |
| **Markdown** | flutter_markdown | ^0.7.4+1 | Markdown 渲染 |
| **Storage** | hive_flutter | ^1.1.0 | 本地数据库 |
| **Env** | flutter_dotenv | ^5.2.1 | 环境变量 |
| **UUID** | uuid | ^4.5.1 | ID 生成 |
| **Icons** | material_symbols_icons | ^4.2785.1 | 图标 |

### Integration Points

| 集成点 | 协议 | 认证 | 说明 |
|--------|------|------|------|
| Gemini API | HTTPS/REST | API Key | AI 对话服务 |
| 本地存储 | Hive | - | 加密存储 |
| 系统相机 | Platform Channel | 权限 | 图片上传 |
| 系统麦克风 | Platform Channel | 权限 | 语音输入 (P1) |
| 生物识别 | local_auth | 权限 | 应用锁 (P1) |

---

## Implementation Patterns

### 1. Provider 模式

```dart
// 所有状态使用 Riverpod Provider
// 命名规范: xxxProvider (小驼峰)

// StateNotifierProvider - 可变状态
final messagesProvider = StateNotifierProvider<MessagesNotifier, List<Message>>((ref) {
  return MessagesNotifier(ref.read(messageRepositoryProvider));
});

// FutureProvider - 异步数据
final sessionProvider = FutureProvider.family<ChatSession?, String>((ref, id) {
  return ref.read(sessionRepositoryProvider).getById(id);
});

// Provider - 简单依赖
final geminiServiceProvider = Provider<GeminiService>((ref) {
  return GeminiService(apiKey: ref.read(settingsProvider).apiKey);
});
```

### 2. Repository 模式

```dart
// Repository 封装数据访问
// 隔离存储实现细节

abstract class MessageRepository {
  Future<List<Message>> getBySessionId(String sessionId);
  Future<void> save(Message message);
  Future<void> delete(String id);
  Stream<List<Message>> watchBySessionId(String sessionId);
}

class HiveMessageRepository implements MessageRepository {
  final Box<Message> _box;
  // 实现...
}
```

### 3. Freezed 数据模型

```dart
// 所有数据模型使用 @freezed
// 自动生成: copyWith, ==, hashCode, toJson, fromJson

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String text,
    required String role,  // 'user' | 'assistant'
    required DateTime createdAt,
    String? sessionId,
    @Default(false) bool isFavorite,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}
```

### 4. 服务层模式

```dart
// Service 封装业务逻辑
// 不直接操作 UI，通过 Provider 暴露

class GeminiService {
  final GenerativeModel _model;

  Stream<String> sendMessageStream(String prompt, List<Message> history) async* {
    final content = _buildContent(prompt, history);
    final response = _model.generateContentStream(content);
    await for (final chunk in response) {
      yield chunk.text ?? '';
    }
  }
}
```

---

## Consistency Rules

### Naming Conventions

| 类型 | 规范 | 示例 |
|------|------|------|
| 文件名 | snake_case | `message_bubble.dart` |
| 类名 | PascalCase | `MessageBubble` |
| 变量/函数 | camelCase | `sendMessage` |
| 常量 | camelCase | `defaultModel` |
| Provider | xxxProvider | `messagesProvider` |
| Notifier | XxxNotifier | `MessagesNotifier` |
| Repository | XxxRepository | `MessageRepository` |
| Service | XxxService | `GeminiService` |

### Code Organization

```dart
// 文件结构顺序
// 1. imports (dart: → package: → relative)
// 2. part directives
// 3. constants
// 4. class definition
// 5. factory constructors
// 6. fields
// 7. getters/setters
// 8. methods (public → private)

// Widget 结构
class MyWidget extends ConsumerWidget {
  // 1. 构造函数
  const MyWidget({super.key});

  // 2. build 方法
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. ref.watch 在顶部
    final state = ref.watch(myProvider);

    // 4. 返回 Widget
    return Container();
  }

  // 5. 私有方法
  void _handleTap() {}
}
```

### Error Handling

```dart
// 统一错误处理模式

// 1. 自定义异常
class AppException implements Exception {
  final String message;
  final String? code;
  AppException(this.message, {this.code});
}

class ApiException extends AppException {
  ApiException(super.message, {super.code});
}

// 2. Service 层抛出异常
class GeminiService {
  Future<void> sendMessage(String prompt) async {
    try {
      // ...
    } on GenerativeAIException catch (e) {
      throw ApiException('AI 服务错误: ${e.message}', code: 'AI_ERROR');
    }
  }
}

// 3. Provider 层捕获并转换为 AsyncValue
final responseProvider = FutureProvider<String>((ref) async {
  try {
    return await ref.read(geminiServiceProvider).sendMessage(prompt);
  } catch (e) {
    throw e; // AsyncValue.error 自动处理
  }
});

// 4. UI 层显示错误
response.when(
  data: (data) => Text(data),
  loading: () => CircularProgressIndicator(),
  error: (e, _) => ErrorView(message: e.toString()),
);
```

### Logging Strategy

```dart
// 使用 debugPrint 而非 print
// 生产环境自动禁用

void log(String message, {String? tag}) {
  debugPrint('[${tag ?? 'APP'}] $message');
}

// 分级日志
class AppLogger {
  static void info(String msg) => log(msg, tag: 'INFO');
  static void warn(String msg) => log(msg, tag: 'WARN');
  static void error(String msg, [Object? error]) {
    log('$msg ${error ?? ''}', tag: 'ERROR');
  }
}
```

---

## Data Architecture

### 数据模型关系

```
┌─────────────────┐
│   AppSettings   │  应用设置 (单例)
└─────────────────┘
         │
         ▼
┌─────────────────┐       ┌─────────────────┐
│   ChatSession   │ 1───n │     Message     │
│                 │       │                 │
│ - id            │       │ - id            │
│ - title         │       │ - sessionId     │
│ - assistantId   │       │ - text          │
│ - createdAt     │       │ - role          │
│ - updatedAt     │       │ - createdAt     │
└─────────────────┘       │ - isFavorite    │
         │                └─────────────────┘
         │
         ▼
┌─────────────────┐       ┌─────────────────┐
│    Assistant    │       │   QuickPhrase   │
│                 │       │                 │
│ - id            │       │ - id            │
│ - name          │       │ - title         │
│ - systemPrompt  │       │ - content       │
│ - model         │       │ - shortcut      │
│ - isDefault     │       │ - category      │
└─────────────────┘       └─────────────────┘
```

### 本地存储结构

```dart
// Hive Boxes
const String sessionsBox = 'sessions';      // ChatSession
const String messagesBox = 'messages';      // Message
const String assistantsBox = 'assistants';  // Assistant
const String phrasesBox = 'phrases';        // QuickPhrase
const String settingsBox = 'settings';      // AppSettings

// 加密存储 (敏感数据)
const String secureBox = 'secure';          // API Keys
```

---

## Security Architecture

### 数据安全

| 数据类型 | 存储位置 | 加密 | 说明 |
|----------|----------|------|------|
| API Key | Hive (secure) | AES-256 | 加密存储 |
| 对话历史 | Hive | 可选 | 用户可开启 |
| 设置 | Hive | 否 | 非敏感 |
| 临时数据 | 内存 | - | 不持久化 |

### 网络安全

- 所有 API 请求使用 HTTPS
- API Key 不在日志中输出
- 不上传用户数据到自有服务器

### 应用安全 (P1)

- 生物识别锁 (Face ID / 指纹)
- 隐私模式 (临时对话不保存)
- 自动锁定 (后台超时)

---

## Performance Considerations

### 启动优化

| 优化项 | 目标 | 方法 |
|--------|------|------|
| 冷启动 | <2秒 | 延迟初始化、减少首屏依赖 |
| 热启动 | <500ms | 保持状态、避免重建 |

### 渲染优化

| 优化项 | 方法 |
|--------|------|
| 列表 | ListView.builder + itemExtent |
| 重建 | const 构造函数、select() |
| 动画 | RepaintBoundary 隔离 |
| 图片 | 缓存 + 压缩 |

### 内存优化

| 优化项 | 方法 |
|--------|------|
| 消息列表 | 分页加载、虚拟滚动 |
| 图片 | 限制缓存大小 |
| Provider | 及时 dispose |

---

## Development Environment

### Prerequisites

- Flutter SDK 3.38.3+
- Dart SDK 3.10.1+
- Android Studio / VS Code
- Xcode (macOS, for iOS)

### Setup Commands

```bash
# 克隆项目
git clone <repo>
cd gemini_chat_flutter

# 安装依赖
flutter pub get

# 配置环境变量
cp .env.example .env
# 编辑 .env 添加 API_KEY

# 生成代码
dart run build_runner build --delete-conflicting-outputs

# 运行应用
flutter run

# 运行测试
flutter test
```

---

## Architecture Decision Records (ADRs)

### ADR-001: 选择 Riverpod 而非 Bloc

**状态：** 已采纳
**日期：** 2024-11-28

**背景：** 需要选择状态管理方案

**决策：** 使用 Riverpod

**理由：**
- 类型安全，编译时检查
- 无需 BuildContext
- 更好的可测试性
- 与 Freezed 配合良好

**后果：** 学习曲线略高，但长期维护性更好

---

### ADR-002: 选择 Hive 而非 SQLite

**状态：** 已采纳
**日期：** 2024-11-28

**背景：** 需要本地持久化方案

**决策：** 使用 Hive

**理由：**
- 纯 Dart 实现，无原生依赖
- 性能优秀（比 SQLite 快）
- 内置加密支持
- API 简洁

**后果：** 不支持复杂查询，但对本应用足够

---

### ADR-003: 本地优先架构

**状态：** 已采纳
**日期：** 2024-11-28

**背景：** 用户隐私是核心差异化

**决策：** 数据默认存储本地，云同步可选

**理由：**
- 保护用户隐私
- 无需后端服务器
- 降低运营成本
- 离线可用

**后果：** 多设备同步需要额外开发

---

_Generated by BMAD Decision Architecture Workflow v1.0_
_Date: 2024-11-28_
_For: m1397_
