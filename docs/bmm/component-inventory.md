# 组件清单

## 数据模型 (models/)

| 模型 | 文件 | 字段 | 说明 |
|------|------|------|------|
| `Message` | message.dart | id, text, role | 聊天消息 |
| `ChatSession` | chat_session.dart | id, title, messages, createdAt | 会话管理 |
| `QuickPhrase` | quick_phrase.dart | id, title, content, shortcut | 快捷短语 |
| `Assistant` | assistant.dart | id, name, systemPrompt, model | AI 助手配置 |

## 状态管理 (providers/)

| Provider | 文件 | 类型 | 职责 |
|----------|------|------|------|
| `messagesProvider` | messages_provider.dart | StateNotifier | 消息 CRUD |
| `quickPhrasesProvider` | quick_phrases_provider.dart | StateNotifier | 快捷短语管理 |
| `geminiServiceProvider` | gemini_service_provider.dart | Provider | AI 服务单例 |

## 页面组件 (screens/)

| 页面 | 文件 | 功能 |
|------|------|------|
| `HomeScreen` | home_screen.dart | Zoom Drawer 容器，动画控制 |
| `ChatScreen` | chat_screen.dart | 聊天界面，消息列表，流式响应 |
| `SettingsScreen` | settings_screen.dart | 设置入口 |
| `SettingsPages` | settings_pages.dart | 设置子页面集合 |

## UI 组件 (widgets/)

| 组件 | 文件 | 功能 | 复杂度 |
|------|------|------|--------|
| `Sidebar` | sidebar.dart | 侧边栏导航，会话列表 | 中 |
| `InputBar` | input_bar.dart | 输入栏，媒体菜单，工具弹窗 | 高 |
| `SettingsWidgets` | settings_widgets.dart | 设置页面专用组件 | 低 |

## 服务 (services/)

| 服务 | 文件 | 方法 | 说明 |
|------|------|------|------|
| `GeminiService` | gemini_service.dart | `sendMessageStream()` | 流式 AI 响应 |

## 主题 (theme/)

| 配置 | 文件 | 内容 |
|------|------|------|
| `AppTheme` | app_theme.dart | Material 3 + shadcn_flutter 双主题系统 |

## shadcn_flutter 组件使用

已迁移的 shadcn 组件（27+）：

| 类别 | 组件 |
|------|------|
| **布局** | Card, Avatar |
| **输入** | TextField, IconButton, Switch |
| **反馈** | Dialog, Toast |
| **导航** | Tabs |

详见 `SHADCN_MIGRATION.md`

## 组件依赖关系

```
HomeScreen
├── Sidebar
│   └── 会话列表项
└── ChatScreen
    ├── 消息列表
    │   └── Markdown 渲染
    └── InputBar
        ├── 媒体菜单
        └── 工具弹窗
```
