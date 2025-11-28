# Cometix - 项目文档索引

> 📍 **AI 开发入口点** - 进行 brownfield PRD 时引用此文档

## 项目概览

| 属性 | 值 |
|------|-----|
| **类型** | Monolith - Flutter Mobile App |
| **主语言** | Dart 3.10.1+ |
| **框架** | Flutter + shadcn_flutter |
| **架构** | Component-based + Riverpod |
| **入口点** | `lib/main.dart` |

## 快速参考

- **技术栈**: Flutter 3.38+, Riverpod, Freezed, shadcn_flutter
- **AI 集成**: Gemini API (google_generative_ai)
- **平台**: Android, iOS, Web

## 生成的文档

| 文档 | 说明 |
|------|------|
| [项目概览](./project-overview.md) | 项目基本信息和技术栈 |
| [源码结构分析](./source-tree-analysis.md) | 目录结构和关键文件 |
| [组件清单](./component-inventory.md) | 模型、Provider、组件列表 |
| [开发指南](./development-guide.md) | 环境配置和开发工作流 |

## 现有文档

| 文档 | 位置 | 说明 |
|------|------|------|
| [README](../../gemini_chat_flutter/README.md) | 项目根目录 | 项目介绍 |
| [SHADCN_MIGRATION](../../gemini_chat_flutter/SHADCN_MIGRATION.md) | 项目根目录 | UI 迁移报告 |
| [CLAUDE.md](../../CLAUDE.md) | 仓库根目录 | AI 开发指南 |

## 核心模块

### 数据模型 (4)
- `Message` - 聊天消息
- `ChatSession` - 会话管理
- `QuickPhrase` - 快捷短语
- `Assistant` - AI 助手配置

### 状态管理 (3)
- `messagesProvider` - 消息状态
- `quickPhrasesProvider` - 快捷短语
- `geminiServiceProvider` - AI 服务

### 页面 (4)
- `HomeScreen` - Zoom Drawer 容器
- `ChatScreen` - 聊天界面
- `SettingsScreen` - 设置页面
- `SettingsPages` - 设置子页面

### 组件 (3)
- `Sidebar` - 侧边栏导航
- `InputBar` - 输入栏组件
- `SettingsWidgets` - 设置组件

### 服务 (1)
- `GeminiService` - Gemini API 集成

## 快速开始

```bash
cd gemini_chat_flutter
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## 下一步

进行 PRD 规划时，引用此索引作为项目上下文。

---

*生成时间: 2024-11-28 | 扫描级别: Quick | 模式: initial_scan*
