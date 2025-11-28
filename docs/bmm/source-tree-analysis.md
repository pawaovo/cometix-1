# 源码结构分析

## 目录树

```
gemini_chat_flutter/
├── lib/                              # 主源码目录
│   ├── main.dart                     # 🚀 应用入口点
│   │
│   ├── models/                       # 📦 数据模型 (Freezed)
│   │   ├── message.dart              # 聊天消息模型
│   │   ├── chat_session.dart         # 会话管理模型
│   │   ├── quick_phrase.dart         # 快捷短语模型
│   │   ├── assistant.dart            # AI 助手配置模型
│   │   └── *.freezed.dart / *.g.dart # 生成的代码
│   │
│   ├── providers/                    # 🔄 状态管理 (Riverpod)
│   │   ├── messages_provider.dart    # 消息状态
│   │   ├── quick_phrases_provider.dart # 快捷短语状态
│   │   └── gemini_service_provider.dart # AI 服务状态
│   │
│   ├── screens/                      # 📱 页面组件
│   │   ├── home_screen.dart          # Zoom Drawer 容器
│   │   ├── chat_screen.dart          # 聊天界面
│   │   ├── settings_screen.dart      # 设置页面
│   │   └── settings_pages.dart       # 设置子页面
│   │
│   ├── services/                     # ⚙️ 业务服务
│   │   └── gemini_service.dart       # Gemini API 集成
│   │
│   ├── theme/                        # 🎨 主题配置
│   │   └── app_theme.dart            # Material 3 + shadcn 主题
│   │
│   └── widgets/                      # 🧩 可复用组件
│       ├── sidebar.dart              # 侧边栏导航
│       ├── input_bar.dart            # 输入栏组件
│       └── settings_widgets.dart     # 设置页面组件
│
├── android/                          # Android 平台配置
├── ios/                              # iOS 平台配置
├── web/                              # Web 平台配置
├── test/                             # 测试文件
│
├── .env                              # 🔑 环境变量 (API Key)
├── pubspec.yaml                      # 📋 依赖配置
├── README.md                         # 项目文档
└── SHADCN_MIGRATION.md               # UI 迁移报告
```

## 关键目录说明

### models/ - 数据模型层

使用 Freezed 实现不可变数据模型，自动生成：
- `copyWith` 方法
- `==` 和 `hashCode`
- JSON 序列化/反序列化

| 模型 | 用途 |
|------|------|
| `Message` | 聊天消息（id, text, role） |
| `ChatSession` | 会话管理 |
| `QuickPhrase` | 快捷短语 |
| `Assistant` | AI 助手配置 |

### providers/ - 状态管理层

使用 Riverpod 实现响应式状态管理：

| Provider | 职责 |
|----------|------|
| `messagesProvider` | 管理聊天消息列表 |
| `quickPhrasesProvider` | 管理快捷短语 |
| `geminiServiceProvider` | 提供 AI 服务实例 |

### screens/ - 页面层

| 页面 | 功能 |
|------|------|
| `HomeScreen` | 主容器，实现 Zoom Drawer 动画 |
| `ChatScreen` | 聊天界面，消息列表 + 输入 |
| `SettingsScreen` | 设置入口页面 |
| `SettingsPages` | 设置子页面集合 |

### widgets/ - 组件层

| 组件 | 功能 |
|------|------|
| `Sidebar` | 侧边栏导航，会话列表 |
| `InputBar` | 复杂输入组件，含工具弹窗 |
| `SettingsWidgets` | 设置页面专用组件 |

### services/ - 服务层

| 服务 | 功能 |
|------|------|
| `GeminiService` | Gemini API 封装，流式响应 |

## 数据流

```
用户输入 → InputBar → Provider → GeminiService → Gemini API
                                      ↓
UI 更新 ← Provider ← Stream<String> ←─┘
```

## 入口点

`lib/main.dart`:
1. 加载 `.env` 配置
2. 初始化 shadcn.Theme
3. 包裹 ProviderScope
4. 启动 MaterialApp → HomeScreen
