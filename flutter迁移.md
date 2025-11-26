React 到 Flutter 迁移指南

这份文档旨在指导你将现有的高保真 React Web 应用迁移到 Flutter，目标是实现 100% 的视觉和交互还原。
1. 项目概览与架构映射
核心思想是将 React 的组件树 (组件树) 映射到 Flutter 的组件树 (小部件树)，并将 Tailwind CSS 样式映射到 Flutter 的 ThemeData 和 shadcn_flutter 的样式配置。
1.1 核心技术栈对比
功能	现有 Web 实现 (React)	目标 Flutter 实现
UI 框架	React（DOM + CSS）	Flutter (Canvas 渲染)
组件库	无 (Tailwind CSS 手写)	shadcn_flutter+ Material/库比蒂诺
样式	Tailwind CSS	ThemeData+shadcn_flutter主题
状态管理	使用状态解除状态	提供商 或 flutter_riverpod
AI 服务	@google/genes（JS SDK）	谷歌生成式人工智能（Dart SDK）
Markdown	react-markdown	flutter_markdown
图标	Google Fonts（Material Symbols）	Flutter 内置 图标或材质符号图标
1. 初始化 Flutter 项目
2.1 创建项目
code
巴什
flutter create gemini_chat_mobile
cd gemini_chat_mobile
2.2 添加依赖 (pubspec.yaml）
你需要引入 shadcn_flutter 以及其他核心依赖。
code
YAML
dependencies:
  flutter:
    sdk: flutter
  # UI 组件库
  shadcn_flutter: ^0.1.0 # 请检查 pub.dev 获取最新版本
  # 图标
  lucide_icons: ^0.1.0 # shadcn 常用图标库，替代 Material Icons
  # 状态管理
  flutter_riverpod: ^2.5.1
  # AI 模型
  google_generative_ai: ^0.2.2
  # Markdown 渲染
  flutter_markdown: ^0.6.14
  # 动画效果 (用于侧边栏缩放)
  animations: ^2.0.8
  # 键盘处理 (可选，用于聊天输入)
  keyboard_actions: ^4.2.0
2.3 配置 shadcn_flutter 主题
在 lib/main.dart 中配置 ShadcnApp，并根据 tailwind.config 迁移颜色。
code
镖
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'Gemini Chat',
      theme: ThemeData(
        colorScheme: ColorSchemes.light(
          primary: const Color(0xFFE4D5D5), // 对应 Tailwind 'primary'
          background: const Color(0xFFFFFFFF),
          card: const Color(0xFFFFFFFF),
          // ... 其他颜色映射
        ),
        radius: 12.0, // 对应 rounded-xl
      ),
      darkTheme: ThemeData(
        colorScheme: ColorSchemes.dark(
          primary: const Color(0xFFE4D5D5),
          background: const Color(0xFF121212),
          card: const Color(0xFF1E1E1E),
        ),
        radius: 12.0,
      ),
      home: const ZoomDrawer(), // 你的主页
    );
  }
}
3. 核心布局迁移 (App.tsx -> main.dart)
React 版本使用了一个独特的 "缩放抽屉" (缩放抽屉) 效果来实现侧边栏。在 Flutter 中，这需要使用 堆和转换 来手动实现。
实现策略：
堆: 底层放 侧边栏，上层放 主屏幕。
动画控制器: 控制侧边栏开启状态 (0.0 -> 1.0)。
转换：
侧边栏: 固定不动，或者轻微视差移动。
主屏幕: 当 值 > 0 时，执行 规模 (缩放到 0.95) 和 翻译 (向右移动 80% 屏幕宽度) 以及 边界半径 (圆角变大)。
4. 组件迁移详解
4.1 侧边栏 (Sidebar.tsx -> Sidebar Widget)
布局：柱子
头部: 搜索框。使用 ShadcnInput (带前缀图标)。
中间: 导航列表。使用 列表视图+ShadcnButton.ghost 或自定义 列表图块。
Web 中的 无滚动条 在 Flutter 中自动支持。
底部: 用户信息和设置按钮。
交互: 点击设置按钮时，调用回调函数关闭 Drawer 并跳转页面。
4.2 聊天页面 (ChatScreen.tsx -> ChatScreen Widget)
结构：脚手架 (或 柱子）
标题: 自定义 应用栏或排。包含 Menu 按钮 (触发 Drawer) 和 "Add Chat" 按钮。
消息列表：ListView.builder。
空状态: 当messages.isEmpty 时显示中心图标。
自动滚动: 使用 ScrollController，在 消息 变化时调用 跳转到或动画。
输入区域: 放在底部，见下文 输入栏。
消息气泡 (Message Bubble)
用户: 右对齐，背景色 颜色.灰色[100]（光） /颜色.灰色[800]（黑暗的）。
人工智能: 左对齐，透明背景。使用 Markdown正文 渲染内容。
4.3 输入栏 (InputBar.tsx -> InputBar Widget)
这是交互最复杂的部分。
顶部 Chips：
网址：弹性划船+溢出-x-自动。
扑：单个子滚动视图（水平）+排。
按钮: 使用ShadcnButton.outline或图标按钮。
输入框行：
左侧 +号：动画容器。点击展开时宽度变大，显示三个图标 (排的图标按钮）。
输入框：ShadcnInput或文本框。
最大行数：null (自适应高度)。
textInputAction: TextInputAction.send。
发送按钮: 圆形 图标按钮，根据是否有文字改变颜色。
弹窗 (Popups)：
网址：绝对 定位 div。
Flutter: 使用 叠加入口 (高级) 或 门户网站 库，或者简单点，如果弹窗在 InputBar 内部，使用 柱子 将弹窗放在 InputBar 上方即可（就像目前的 React 实现一样）。
4.4 设置页面 (SettingsPage.tsx -> SettingsScreen Widget)
导航: Flutter 使用 航海家 栈。
点击 "设置" -> Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()))。
点击子项 (如 "默认模型") -> Navigator.push(...)。
UI 组件映射 (shadcn_flutter)：
选择项->ShadcnButton.ghost（全宽，左对齐）或列表图块。
切换项->ShadcnSwitch+标签。
滑块项->ShadcnSlider。
输入项->ShadcnInput。
部门组->ShadcnCard。
特殊子页面
MCP/助理名单: 使用列表视图。
详细编辑（助理编辑）: 这是一个复杂的表单页面。
标签页: 使用ShadcnTabs (如果有) 或自定义 分段控制。
表单状态: 使用flutter_riverpod 管理当前编辑的对象状态，避免 设置状态 地狱。
5. 逻辑与数据层迁移
5.1 数据模型 (types.ts -> models/*.dart)
将所有 Interface 转换为 Dart Class，建议使用 冷冻 包来生成不可变对象和 JSON 序列化代码，这在处理复杂状态（如 Assistant 设置）时非常有帮助。
code
镖
@freezed
class Assistant with _$Assistant {
  const factory Assistant({
    required String id,
    required String name,
    // ... 其他字段
  }) = _Assistant;
}
5.2 全局状态 (useState -> Riverpod)
React 中 App.tsx 持有了 助理，供应商，快捷短语 等状态。
在 Flutter 中，创建 状态通知提供程序 来管理这些列表。
code
镖
// providers/assistants_provider.dart
class AssistantsNotifier extends StateNotifier<List<Assistant>> {
  AssistantsNotifier() : super(initialAssistants);
  
  void addAssistant(Assistant a) { ... }
  void updateAssistant(Assistant a) { ... }
}
5.3 Gemini 服务 (geminiService.ts -> gemini_service.dart)
直接使用 谷歌生成式人工智能 Dart 包。逻辑与 JS 版几乎一致（流式响应处理）。
6. 迁移检查清单 (Checklist)
[ ] 基础搭建: 创建 Flutter 项目，配置 shadcn_flutter 主题 (Light/Dark 模式)。
[ ] 侧边栏动画: 实现首页的 缩放抽屉 效果。
[ ] 输入栏 UI: 还原输入栏的 Chips、折叠菜单、图标样式。
[ ] 聊天功能：
消息列表渲染。
对接 Gemini API 流式输出。
Markdown 渲染。
[ ] 设置 - 基础 UI: 封装 部门组，选择项，切换项 等通用 Widget。
[ ] 设置 - 页面导航: 实现从主页到设置页，以及设置页内部子页面的跳转。
[ ] 设置 - 功能实现：
助手管理 (增删改查)。
服务商配置 (表单)。
快捷短语 (逻辑 + 存储)。
[ ] 细节打磨：
检查点击外部关闭弹窗的逻辑 (塔普区域）。
检查键盘弹出时的布局 (避免 overflow)。
暗黑模式适配检查。
7. 常见陷阱与提示
键盘遮挡: 在 Web 中浏览器会自动处理，Flutter 中需要确保输入框在键盘上方。通常 脚手架 会自动处理，但如果在 堆 中可能需要调整 底部 padding 为 MediaQuery.of(context).viewInsets.bottom。
SVG 图标: 如果 shadcn_flutter 或 lucid_icons 不够用，可以使用 flutter_svg 加载自定义 SVG。
性能：列表视图 记得使用 .builder 构造函数以支持长列表懒加载。