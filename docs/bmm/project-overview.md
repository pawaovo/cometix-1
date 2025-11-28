# Cometix - 项目概览

## 基本信息

| 属性 | 值 |
|------|-----|
| **项目名称** | Cometix (Gemini Chat Flutter) |
| **项目类型** | Mobile App (Flutter) |
| **仓库类型** | Monolith |
| **主语言** | Dart 3.10.1+ |
| **框架** | Flutter 3.38+ |
| **架构模式** | Component-based + Provider Pattern |

## 项目描述

Cometix 是一个基于 Flutter 实现的 Gemini Chat 移动应用，具有以下核心特性：

- **Zoom Drawer 侧边栏动画** - 独特的缩放 + 滑动效果
- **流式 AI 对话** - Gemini API 集成，实时响应
- **快捷短语系统** - 预设常用提示词
- **深色模式支持** - 完整的主题切换
- **Markdown 渲染** - AI 响应格式化显示
- **shadcn_flutter 设计系统** - 现代化 UI 组件库

## 技术栈

| 类别 | 技术 | 版本 |
|------|------|------|
| Framework | Flutter | 3.38+ |
| Language | Dart | ^3.10.1 |
| UI Library | shadcn_flutter | ^0.0.47 |
| State Management | flutter_riverpod | ^2.5.1 |
| Data Models | freezed | ^2.5.7 |
| AI Integration | google_generative_ai | ^0.4.6 |
| Markdown | flutter_markdown | ^0.7.4+1 |
| Icons | material_symbols_icons | ^4.2785.1 |
| Env Config | flutter_dotenv | ^5.2.1 |

## 目录结构

```
gemini_chat_flutter/
├── lib/
│   ├── main.dart           # 应用入口
│   ├── models/             # Freezed 数据模型
│   ├── providers/          # Riverpod 状态管理
│   ├── screens/            # 页面组件
│   ├── services/           # 业务服务
│   ├── theme/              # 主题配置
│   └── widgets/            # 可复用组件
├── android/                # Android 平台配置
├── ios/                    # iOS 平台配置
├── web/                    # Web 平台配置
├── test/                   # 测试文件
├── .env                    # 环境变量 (API Key)
└── pubspec.yaml            # 依赖配置
```

## 平台支持

- ✅ Android
- ✅ iOS
- ✅ Web (实验性)

## 快速开始

```bash
cd gemini_chat_flutter

# 安装依赖
flutter pub get

# 生成 Freezed 代码
dart run build_runner build --delete-conflicting-outputs

# 运行应用
flutter run
```

## 相关文档

- [源码结构分析](./source-tree-analysis.md)
- [组件清单](./component-inventory.md)
- [开发指南](./development-guide.md)
