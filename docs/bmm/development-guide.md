# 开发指南

## 环境要求

| 依赖 | 版本 |
|------|------|
| Flutter | 3.38.3+ |
| Dart | 3.10.1+ |
| Android Studio / VS Code | 最新版 |

## 快速开始

```bash
cd gemini_chat_flutter

# 1. 安装依赖
flutter pub get

# 2. 配置环境变量
# 创建 .env 文件，添加 Gemini API Key
echo "API_KEY=your_gemini_api_key" > .env

# 3. 生成 Freezed 代码
dart run build_runner build --delete-conflicting-outputs

# 4. 运行应用
flutter run
```

## 常用命令

| 命令 | 说明 |
|------|------|
| `flutter pub get` | 安装依赖 |
| `dart run build_runner build --delete-conflicting-outputs` | 生成 Freezed 代码 |
| `flutter run` | 运行应用 |
| `flutter run -d chrome` | Web 运行 |
| `flutter run -d android` | Android 运行 |
| `flutter run -d ios` | iOS 运行 |
| `flutter clean && flutter pub get` | 清理并重装 |
| `flutter analyze` | 代码分析 |
| `flutter test` | 运行测试 |

## 开发工作流

### 添加新数据模型

1. 在 `lib/models/` 创建文件
2. 使用 `@freezed` 注解定义模型
3. 运行 `dart run build_runner build --delete-conflicting-outputs`

```dart
@freezed
class NewModel with _$NewModel {
  const factory NewModel({
    required String id,
    required String name,
  }) = _NewModel;

  factory NewModel.fromJson(Map<String, dynamic> json) => _$NewModelFromJson(json);
}
```

### 添加新 Provider

1. 在 `lib/providers/` 创建文件
2. 定义 StateNotifier 和 Provider

```dart
class NewNotifier extends StateNotifier<List<NewModel>> {
  NewNotifier() : super([]);
  // 方法...
}

final newProvider = StateNotifierProvider<NewNotifier, List<NewModel>>((ref) {
  return NewNotifier();
});
```

### 添加新页面

1. 在 `lib/screens/` 创建文件
2. 使用 `ConsumerWidget` 或 `ConsumerStatefulWidget`
3. 优先使用 shadcn_flutter 组件

### 添加新组件

1. 在 `lib/widgets/` 创建文件
2. 遵循单一职责原则
3. 使用 shadcn_flutter 组件库

## 代码规范

### 命名约定

| 类型 | 规范 | 示例 |
|------|------|------|
| 类名 | PascalCase | `ChatScreen` |
| 变量/函数 | camelCase | `sendMessage` |
| 文件名 | snake_case | `chat_screen.dart` |
| 常量 | camelCase | `defaultModel` |

### 注释规则

- **代码注释必须使用中文**
- 复杂逻辑添加解释性注释
- 公共 API 使用 `///` 文档注释

### shadcn_flutter 使用

```dart
// 导入
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

// 使用组件
shadcn.TextField(
  controller: controller,
  placeholder: Text('提示文本'),
)
```

## 调试技巧

- 使用 `debugPrint()` 而非 `print()`
- 热重载：按 `r`
- 热重启：按 `R`
- 启用 Flutter DevTools 进行性能分析

## 环境配置

### .env 文件

```
API_KEY=your_gemini_api_key_here
```

### 获取 Gemini API Key

1. 访问 https://ai.google.dev/
2. 创建 API Key
3. 粘贴到 `.env` 文件
