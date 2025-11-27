# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## 项目概述

这是一个 **Flutter 实现的 Gemini Chat 移动应用**，位于 `gemini_chat_flutter/` 目录。

**核心特性**：
- 独特的 Zoom Drawer 侧边栏动画（缩放 + 滑动效果）
- 流式 AI 对话（Gemini API 集成）
- 快捷短语系统
- 深色模式支持
- Markdown 渲染
- **shadcn_flutter 设计系统**（已完成 100% 迁移）
- Material 3 设计语言

**技术栈**：
- Flutter 3.38.3+ / Dart 3.10.1+
- **shadcn_flutter ^0.0.47**（UI 组件库）
- Riverpod（状态管理）
- Freezed（不可变数据模型）
- google_generative_ai（Gemini SDK）
- flutter_markdown（Markdown 渲染）

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
flutter run -d chrome  # Web（实验性）

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

### 项目架构

```
gemini_chat_flutter/
├── lib/
│   ├── main.dart                 # 应用入口，加载 .env 配置
│   ├── models/                   # Freezed 不可变数据模型
│   │   ├── message.dart          # 聊天消息
│   │   ├── assistant.dart        # AI 助手配置
│   │   ├── chat_session.dart     # 会话管理
│   │   └── quick_phrase.dart     # 快捷短语
│   ├── providers/                # Riverpod 状态管理
│   │   ├── messages_provider.dart
│   │   ├── quick_phrases_provider.dart
│   │   └── gemini_service_provider.dart
│   ├── screens/                  # 主要页面
│   │   ├── home_screen.dart      # Zoom Drawer 容器
│   │   ├── chat_screen.dart      # 聊天界面
│   │   └── settings_screen.dart  # 设置页面
│   ├── widgets/                  # 可复用组件
│   │   ├── sidebar.dart          # 侧边栏导航
│   │   ├── input_bar.dart        # 复杂输入组件（带工具弹窗）
│   │   └── settings_widgets.dart # 设置页面组件
│   ├── services/                 # 业务逻辑
│   │   └── gemini_service.dart   # Gemini API 集成
│   └── theme/                    # 主题配置
│       └── app_theme.dart        # Material 3 主题配置
├── test/                         # 测试文件
├── android/                      # Android 平台配置
├── ios/                          # iOS 平台配置
├── web/                          # Web 平台配置
├── .env                          # 环境变量（API Key）
└── pubspec.yaml                  # 依赖配置
```

### 关键技术决策

**状态管理：Riverpod**
- 类型安全
- 编译时检查
- 无需 BuildContext
- 更好的可测试性

**数据模型：Freezed**
- 不可变对象
- JSON 序列化/反序列化
- copyWith 功能
- Union types 支持

**UI 组件库：shadcn_flutter**
- 现代化的设计系统
- 70+ 精美组件
- 完整的深色/浅色模式支持
- 高度可定制
- 类型安全

**UI 框架：Material 3**
- 现代设计系统
- 内置深色模式
- 自适应组件
- 更好的无障碍支持
- 与 shadcn_flutter 完美共存

---

## 核心实现细节

### 1. Zoom Drawer 动画

位置：`lib/screens/home_screen.dart`

实现原理：
- `AnimationController` 控制动画时长（300ms）
- `Transform.scale` 实现缩放效果（1.0 → 0.95）
- `Transform.translate` 实现水平滑动（0 → 80% 屏幕宽度）
- `ClipRRect` 在动画时添加圆角
- `Stack` 布局：底层 Sidebar，上层 ChatScreen

### 2. 流式 AI 响应

位置：`lib/services/gemini_service.dart`

关键点：
- 使用 `google_generative_ai` Dart SDK
- 默认模型：`gemini-2.0-flash-exp`
- `sendMessageStream()` 返回 `Stream<String>`
- 历史消息转换为 Gemini `Content` 格式
- 错误处理：捕获异常并返回中文错误消息

### 3. 输入栏组件

位置：`lib/widgets/input_bar.dart`

复杂功能：
- 可展开的媒体菜单（相机、相册、文件）
- 工具弹窗（历史、模型选择、MCP、快捷短语）
- 基于快捷键的自动建议
- 自适应发送按钮样式
- 多行文本输入支持

### 4. 主题配置

位置：`lib/theme/app_theme.dart`

**双主题系统**：shadcn_flutter + Material 3

#### shadcn_flutter 主题
```dart
static shadcn.ThemeData shadcnTheme = shadcn.ThemeData(
  colorScheme: shadcn.ColorScheme.fromColors(
    brightness: Brightness.light,
    colors: {
      'background': backgroundLight,
      'foreground': gray900,
      'card': cardLight,
      'primary': primaryColor,
      'accent': accentBrown,
      // ... 完整色彩系统
    },
  ),
  radius: 12.0,
);
```

#### Material 3 主题
```dart
// 核心颜色
primaryColor: Color(0xFFE4D5D5)
backgroundLight: Color(0xFFFFFFFF)
backgroundDark: Color(0xFF121212)
gray100-900: 完整灰度色阶
accentBrown: Color(0xFF8B5E3C)

// 主题特性
- useMaterial3: true
- 自适应深色模式
- 圆角输入框（24px）
- 自定义 ElevatedButton 样式
```

---

## 环境配置

1. **创建 `.env` 文件**在 `gemini_chat_flutter/` 根目录：
   ```
   API_KEY=your_gemini_api_key_here
   ```

2. **确认 `pubspec.yaml` 配置**（已配置）：
   ```yaml
   flutter:
     assets:
       - .env
   ```

3. **获取 Gemini API Key**：
   - 访问 https://ai.google.dev/
   - 创建 API Key
   - 粘贴到 `.env` 文件

---

## 常见问题排查

### Flutter Build Runner 失败

```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### API Key 无效

- 检查 `.env` 文件是否在项目根目录
- 验证 API Key 格式正确
- 确认 `pubspec.yaml` 中 `assets` 包含 `.env`

### 依赖冲突

```bash
flutter pub upgrade
```

### 键盘遮挡输入框

- `Scaffold` 会自动处理
- 如果在 `Stack` 中，需手动添加 `MediaQuery.of(context).viewInsets.bottom` 作为 padding

---

## 代码风格约定

### Dart/Flutter 编码规范

1. **数据模型定义**
   - 所有数据类使用 `@freezed` 注解
   - 自动生成 `copyWith`、`==`、`hashCode`
   - JSON 序列化使用 `@JsonSerializable`
   ```dart
   @freezed
   class Message with _$Message {
     const factory Message({
       required String id,
       required String text,
       required String role,
     }) = _Message;

     factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
   }
   ```

2. **Riverpod Provider 命名规范**
   - Provider: `xxxProvider`（小驼峰）
   - Notifier: `XxxNotifier`（大驼峰）
   - 文件名: `xxx_provider.dart`（蛇形命名）

3. **Widget 组织原则**
   - 有状态组件：`StatefulWidget`
   - 无状态组件：`StatelessWidget`
   - 消费 Provider：`ConsumerWidget` 或 `ConsumerStatefulWidget`
   - 私有 Widget 使用 `_` 前缀

4. **异步处理规范**
   - 使用 `async/await` 而非 `.then()`
   - Stream 使用 `await for` 循环
   - 错误处理使用 `try-catch`
   - 长时间操作显示 Loading 状态

5. **注释规则**
   - **代码注释必须使用中文**
   - 复杂逻辑添加解释性注释
   - 公共 API 使用 `///` 文档注释
   - 避免无意义的注释（如 `// 构造函数`）

6. **文件组织**
   - 每个文件只包含一个主要 Widget/类
   - 相关的私有 Widget 可以放在同一文件
   - 超过 300 行考虑拆分文件

7. **命名约定**
   - 类名：`PascalCase`
   - 变量/函数：`camelCase`
   - 常量：`camelCase`（不使用 UPPER_CASE）
   - 私有成员：`_camelCase`

8. **shadcn_flutter 组件使用规范**
   - 优先使用 shadcn 组件而非原生 Flutter 组件
   - 导入时使用别名：`import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;`
   - 注意 API 差异（参见 shadcn_flutter 组件使用指南）
   - 保持与 Material 3 主题的兼容性

---

## 测试

### Flutter 测试

```bash
# 运行所有测试
flutter test

# 运行单个测试文件
flutter test test/widget_test.dart

# 生成覆盖率报告
flutter test --coverage
```

当前测试文件：`test/widget_test.dart`（基础 Widget 测试）

---

## 性能优化建议

1. **ListView 优化**
   - 始终使用 `ListView.builder` 而非 `ListView`
   - 长列表启用 `cacheExtent`

2. **图片优化**
   - 使用 `CachedNetworkImage` 缓存网络图片
   - 本地图片使用 `AssetImage`

3. **动画优化**
   - 复用 `AnimationController`
   - 使用 `RepaintBoundary` 隔离重绘区域

4. **状态管理**
   - 避免不必要的 `setState`
   - 使用 `const` 构造函数

---

## 依赖版本

### 核心依赖

```yaml
# UI 组件库
shadcn_flutter: ^0.0.47

# 状态管理
flutter_riverpod: ^2.5.1

# AI 服务
google_generative_ai: ^0.4.6

# UI 组件
flutter_markdown: ^0.7.4+1
material_symbols_icons: ^4.2785.1

# 数据模型
freezed_annotation: ^2.4.4
json_annotation: ^4.9.0

# 工具库
uuid: ^4.5.1
flutter_dotenv: ^5.2.1

# 开发依赖
build_runner: ^2.4.13
freezed: ^2.5.7
json_serializable: ^6.8.0
flutter_lints: ^6.0.0
```

---

## 项目状态与路线图

### 已完成功能 ✅
- Flutter 基础架构（Riverpod + Freezed）
- **shadcn_flutter 组件迁移（100% 完成，27+ 组件）**
- Zoom Drawer 侧边栏动画
- 聊天界面与流式 AI 响应
- Markdown 渲染
- 深色模式支持
- 快捷短语基础功能
- 设置页面基础 UI

### 待完善功能 🚧
- 本地持久化存储（SharedPreferences / Hive）
- 图片上传与多模态输入
- MCP 服务器集成
- 助手管理完整功能
- 搜索历史功能
- 语音输入
- 多语言支持

### 已知问题 ⚠️
- 长消息列表性能优化
- 键盘弹出时的布局调整
- 部分设置项未持久化

---

## 开发建议

### 添加新功能时
1. 先在 `models/` 定义数据模型（使用 Freezed）
2. 在 `providers/` 创建状态管理
3. 在 `widgets/` 或 `screens/` 实现 UI（**优先使用 shadcn_flutter 组件**）
4. 运行 `dart run build_runner build` 生成代码
5. 测试 Light/Dark 模式兼容性
6. 运行 `flutter analyze` 确保无错误和警告

### 调试技巧
- 使用 `debugPrint()` 而非 `print()`
- 启用 Flutter DevTools 进行性能分析
- 使用 `flutter analyze` 检查代码质量
- 使用 `flutter doctor` 检查环境配置

### 性能优化检查清单
- [ ] 长列表使用 `ListView.builder`
- [ ] 避免在 `build()` 中创建对象
- [ ] 使用 `const` 构造函数
- [ ] 图片使用缓存
- [ ] 避免不必要的 `setState`

---

## shadcn_flutter 组件使用指南

### 迁移文档

完整的 shadcn_flutter 迁移报告请参阅：**`gemini_chat_flutter/SHADCN_MIGRATION.md`**

该文档包含：
- 完整的组件迁移统计（27+ 组件）
- API 差异说明
- 代码示例
- 最佳实践
- 已知问题和注意事项

### 常用组件 API

#### TextField
```dart
shadcn.TextField(
  controller: controller,
  placeholder: Text('提示文本'),
  style: TextStyle(...),
  border: Border.fromBorderSide(BorderSide.none),
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
)
```

#### IconButton
```dart
shadcn.IconButton.ghost(
  onPressed: () {},
  icon: Icon(Icons.menu),
)
```

#### Avatar
```dart
shadcn.Avatar(
  initials: 'U',
  size: 40,
  backgroundColor: AppTheme.primaryColor,
  // 注意：不支持 textStyle 参数
)
```

#### Card
```dart
shadcn.Card(
  filled: true,
  fillColor: Colors.white,
  borderRadius: BorderRadius.circular(16),
  borderColor: Colors.grey,  // 使用 borderColor 而非 border
  borderWidth: 1,            // 使用 borderWidth
  padding: EdgeInsets.zero,
  child: Widget,
)
```

#### Switch
```dart
shadcn.Switch(
  value: checked,
  onChanged: (value) {},
  activeColor: Colors.blue,
  inactiveColor: Colors.grey,
)
```

### API 差异注意事��

1. **Avatar 组件**
   - ❌ 不支持 `textStyle` 参数
   - ✅ 需通过 AvatarTheme 配置

2. **Card 组件**
   - ❌ 不使用 `border: Border.all(...)`
   - ✅ 使用 `borderColor` 和 `borderWidth`

3. **TextField 组件**
   - ❌ 不使用 `hintText`
   - ✅ 使用 `placeholder: Text(...)`

### 主题配置

在 `lib/main.dart` 中使用 shadcn.Theme 包裹应用：

```dart
return shadcn.Theme(
  data: AppTheme.shadcnTheme,
  child: MaterialApp(
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.darkTheme,
    home: const HomeScreen(),
  ),
);
```

---

## 相关资源

- **Flutter 官方文档**: https://flutter.dev/docs
- **shadcn_flutter 文档**: https://pub.dev/packages/shadcn_flutter
- **Riverpod 文档**: https://riverpod.dev
- **Freezed 文档**: https://pub.dev/packages/freezed
- **Gemini API 文档**: https://ai.google.dev/docs
- **Material 3 设计**: https://m3.material.io/
