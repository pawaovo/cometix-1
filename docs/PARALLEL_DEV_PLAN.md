# Cometix 并行开发计划

> 基于 Kelivo 参考项目的功能完善计划
> 创建日期: 2025-11-29

---

## 一、项目对比分析

### 1.1 当前项目状态 (gemini_chat_flutter)

| 模块 | 状态 | 说明 |
|------|------|------|
| 基础架构 | ✅ 完成 | Riverpod + Freezed |
| UI 组件库 | ✅ 完成 | shadcn_flutter 迁移 100% |
| Zoom Drawer | ✅ 完成 | 侧边栏动画 |
| 聊天界面 | ✅ 完成 | 流式响应 + Markdown |
| 设置页面 | 🚧 框架完成 | UI 框架已有，功能未实现 |
| 数据持久化 | ❌ 未实现 | 无本地存储 |
| 多服务商支持 | ❌ 未实现 | 仅 Gemini |

### 1.2 参考项目功能 (Kelivo)

**核心功能模块**：
- 多服务商支持 (OpenAI, Anthropic, Google, 等)
- 完整的设置系统 (SettingsProvider)
- 助手管理 (AssistantProvider)
- MCP 服务器集成
- 搜索服务 (12+ 搜索引擎)
- TTS 语音服务
- WebDAV 备份
- 网络代理
- 快捷短语
- 热键系统

---

## 二、功能差异详细对比

### 2.1 设置页面模块对比

| 设置项 | Kelivo | Cometix | 差距 |
|--------|--------|---------|------|
| 显示设置 | 主题/字体/布局/触感反馈 | 仅主题+语言 | 需补充 |
| 助手管理 | 完整CRUD+配置 | 仅列表展示 | 需重构 |
| 默认模型 | 对话/标题/OCR模型 | 仅单选列表 | 需补充 |
| 服务商 | 多Key管理+模型获取 | 仅展示 | 需重构 |
| 搜索服务 | 12+引擎+通用配置 | 仅4个选项 | 需重构 |
| MCP | 完整配置+JSON编辑 | 仅列表 | 需补充 |
| 快捷短语 | 完整CRUD | 仅列表 | 需补充 |
| 网络代理 | HTTP/HTTPS/SOCKS5 | UI完成 | 需接入 |
| 备份 | WebDAV+本地+导入 | UI完成 | 需接入 |
| TTS服务 | 多服务商支持 | ❌ 无 | 需新增 |
| 热键 | 完整配置 | ❌ 无 | 需新增 |

### 2.2 核心 Provider 对比

**Kelivo Providers (14个)**:
```
├── settings_provider.dart    # 全局设置 (100+ 配置项)
├── assistant_provider.dart   # 助手管理
├── chat_provider.dart        # 聊天状态
├── model_provider.dart       # 模型管理
├── mcp_provider.dart         # MCP 服务
├── quick_phrase_provider.dart
├── backup_provider.dart
├── tts_provider.dart
├── memory_provider.dart
├── tag_provider.dart
├── hotkey_provider.dart
├── instruction_injection_provider.dart
├── update_provider.dart
└── user_provider.dart
```

**Cometix Providers (3个)**:
```
├── messages_provider.dart
├── quick_phrases_provider.dart
└── gemini_service_provider.dart
```

---

## 三、并行开发任务分配

### Git Worktrees 设置

```bash
# 在项目根目录执行
cd D:\ai\cometix

# 创建工作树
git worktree add ../cometix-settings-general settings-general
git worktree add ../cometix-settings-model settings-model
git worktree add ../cometix-settings-data settings-data
git worktree add ../cometix-providers providers-core
git worktree add ../cometix-services services-core
```

---

## 四、任务模块详细说明

### 模块 A: 设置页面 - 通用设置

**分支**: `settings-general`
**工作目录**: `cometix-settings-general`

**任务清单**:

1. **显示设置页面重构** (`lib/screens/settings_pages.dart`)
   - [ ] 主题色板选择 (参考 kelivo theme_palette)
   - [ ] 动态颜色开关
   - [ ] 字体设置 (应用字体/代码字体)
   - [ ] 字体大小缩放
   - [ ] 触感反馈设置
   - [ ] 聊天背景设置
   - [ ] Markdown 渲染选项

2. **助手设置页面重构**
   - [ ] 助手详情编辑页面
   - [ ] 系统提示词配置
   - [ ] 模型绑定
   - [ ] 上下文消息数量
   - [ ] 温度/TopP 参数
   - [ ] 流式输出开关

3. **关于页面完善**
   - [ ] 版本检查
   - [ ] 链接跳转实现
   - [ ] 许可证展示

**参考文件**:
- `kelivo/lib/desktop/desktop_settings_page.dart` (显示设置部分)
- `kelivo/lib/features/assistant/pages/assistant_settings_edit_page.dart`
- `kelivo/lib/desktop/setting/about_pane.dart`

---

### 模块 B: 设置页面 - 模型与服务

**分支**: `settings-model`
**工作目录**: `cometix-settings-model`

**任务清单**:

1. **默认模型页面重构** (`lib/screens/settings_pages.dart`)
   - [ ] 对话模型选择
   - [ ] 标题生成模型选择
   - [ ] OCR 模型选择
   - [ ] 翻译模型选择
   - [ ] 模型选择器组件

2. **服务商页面重构**
   - [ ] 服务商列表 (支持拖拽排序)
   - [ ] 添加服务商对话框
   - [ ] API Key 管理 (多Key支持)
   - [ ] 模型列表获取
   - [ ] 自定义模型添加
   - [ ] 服务商启用/禁用

3. **搜索服务页面重构**
   - [ ] 搜索服务列表
   - [ ] 添加搜索服务对话框
   - [ ] 通用搜索配置 (结果数量/语言等)
   - [ ] 搜索服务测试

4. **MCP 页面完善**
   - [ ] MCP 服务器配置
   - [ ] JSON 配置编辑器
   - [ ] 服务器状态显示
   - [ ] 工具列表展示

**参考文件**:
- `kelivo/lib/desktop/setting/default_model_pane.dart`
- `kelivo/lib/desktop/setting/search_services_pane.dart`
- `kelivo/lib/desktop/setting/mcp_pane.dart`
- `kelivo/lib/desktop/add_provider_dialog.dart`

---

### 模块 C: 设置页面 - 数据管理

**分支**: `settings-data`
**工作目录**: `cometix-settings-data`

**任务清单**:

1. **备份页面功能实现**
   - [ ] WebDAV 配置表单
   - [ ] WebDAV 连接测试
   - [ ] 远程备份列表
   - [ ] 备份上传/下载
   - [ ] 本地文件导出
   - [ ] 本地文件导入
   - [ ] Cherry Studio 导入

2. **聊天存储页面**
   - [ ] 文件列表展示
   - [ ] 存储空间统计
   - [ ] 文件清理功能

3. **网络代理功能接入**
   - [ ] 代理配置持久化
   - [ ] 代理连接测试
   - [ ] HTTP Client 代理集成

4. **快捷短语功能完善**
   - [ ] 短语编辑对话框
   - [ ] 短语排序
   - [ ] 短语导入/导出

**参考文件**:
- `kelivo/lib/desktop/setting/backup_pane.dart`
- `kelivo/lib/desktop/setting/network_proxy_pane.dart`
- `kelivo/lib/desktop/setting/quick_phrases_pane.dart`
- `kelivo/lib/core/providers/backup_provider.dart`

---

### 模块 D: 核心 Provider 层

**分支**: `providers-core`
**工作目录**: `cometix-providers`

**任务清单**:

1. **SettingsProvider 创建**
   - [ ] 主题设置
   - [ ] 显示设置
   - [ ] 模型设置
   - [ ] 代理设置
   - [ ] SharedPreferences 持久化

2. **AssistantProvider 创建**
   - [ ] 助手 CRUD
   - [ ] 助手模型 (Freezed)
   - [ ] 本地存储

3. **ModelProvider 创建**
   - [ ] 服务商管理
   - [ ] 模型列表
   - [ ] API Key 管理

4. **BackupProvider 创建**
   - [ ] WebDAV 客户端
   - [ ] 备份/恢复逻辑

**参考文件**:
- `kelivo/lib/core/providers/settings_provider.dart`
- `kelivo/lib/core/providers/assistant_provider.dart`
- `kelivo/lib/core/providers/model_provider.dart`
- `kelivo/lib/core/providers/backup_provider.dart`

---

### 模块 E: 核心 Service 层

**分支**: `services-core`
**工作目录**: `cometix-services`

**任务清单**:

1. **ChatApiService 重构**
   - [ ] 多服务商支持
   - [ ] OpenAI 兼容 API
   - [ ] Anthropic API
   - [ ] 流式响应统一处理

2. **SearchService 创建**
   - [ ] 搜索服务接口
   - [ ] Bing 搜索实现
   - [ ] DuckDuckGo 实现
   - [ ] 其他搜索引擎

3. **BackupService 创建**
   - [ ] WebDAV 客户端
   - [ ] 本地备份

4. **TTSService 创建** (可选)
   - [ ] 系统 TTS
   - [ ] 网络 TTS

**参考文件**:
- `kelivo/lib/core/services/api/chat_api_service.dart`
- `kelivo/lib/core/services/search/search_service.dart`
- `kelivo/lib/core/services/backup/data_sync.dart`

---

## 五、开发优先级

### P0 - 必须完成 (核心功能)

1. SettingsProvider (数据持久化基础)
2. 服务商管理 (多模型支持基础)
3. 助手管理完善

### P1 - 重要功能

4. 备份功能
5. 搜索服务
6. 显示设置完善

### P2 - 增强功能

7. MCP 完善
8. 快捷短语完善
9. 网络代理

### P3 - 可选功能

10. TTS 服务
11. 热键系统

---

## 六、并行开发流程

### 6.1 启动开发

```bash
# 终端 A - 通用设置
cd D:\ai\cometix-settings-general\gemini_chat_flutter
code .
# Claude Code: 执行模块 A 任务

# 终端 B - 模型与服务
cd D:\ai\cometix-settings-model\gemini_chat_flutter
code .
# Claude Code: 执行模块 B 任务

# 终端 C - 数据管理
cd D:\ai\cometix-settings-data\gemini_chat_flutter
code .
# Claude Code: 执行模块 C 任务
```

### 6.2 合并流程

```bash
# 回到主仓库
cd D:\ai\cometix

# 合并各分支
git checkout main
git merge settings-general --no-ff -m "feat: 通用设置功能完善"
git merge settings-model --no-ff -m "feat: 模型与服务设置"
git merge settings-data --no-ff -m "feat: 数据管理功能"

# 清理工作树
git worktree remove ../cometix-settings-general
git worktree remove ../cometix-settings-model
git worktree remove ../cometix-settings-data
```

---

## 七、各窗口 Claude Code 提示词模板

### 窗口 A 提示词

```
你正在开发 Cometix Flutter 项目的【通用设置】模块。

参考项目: D:\ai\cometix\kelivo
当前项目: D:\ai\cometix-settings-general\gemini_chat_flutter

任务:
1. 重构 DisplaySettingsPage - 添加主题色板、字体设置、触感反馈
2. 重构 AssistantSettingsPage - 添加助手详情编辑
3. 完善 AboutPage - 实现链接跳转

参考文件:
- kelivo/lib/desktop/desktop_settings_page.dart
- kelivo/lib/features/assistant/pages/assistant_settings_edit_page.dart

请按照现有代码风格，使用 shadcn_flutter 组件。
```

### 窗口 B 提示词

```
你正在开发 Cometix Flutter 项目的【模型与服务】模块。

参考项目: D:\ai\cometix\kelivo
当前项目: D:\ai\cometix-settings-model\gemini_chat_flutter

任务:
1. 重构 DefaultModelPage - 支持多种模型类型选择
2. 重构 ProvidersPage - 添加服务商管理功能
3. 重构 SearchSettingsPage - 支持多搜索引擎
4. 完善 MCPSettingsPage - 添加配置编辑

参考文件:
- kelivo/lib/desktop/setting/default_model_pane.dart
- kelivo/lib/desktop/setting/search_services_pane.dart
- kelivo/lib/desktop/add_provider_dialog.dart

请按照现有代码风格，使用 shadcn_flutter 组件。
```

### 窗口 C 提示词

```
你正在开发 Cometix Flutter 项目的【数据管理】模块。

参考项目: D:\ai\cometix\kelivo
当前项目: D:\ai\cometix-settings-data\gemini_chat_flutter

任务:
1. 实现 BackupSettingsPage 功能 - WebDAV 配置和备份
2. 完善 ChatStoragePage - 文件管理
3. 接入 ProxySettingsPage 功能 - 代理配置持久化
4. 完善 QuickPhraseSettingsPage - 编辑对话框

参考文件:
- kelivo/lib/desktop/setting/backup_pane.dart
- kelivo/lib/desktop/setting/network_proxy_pane.dart
- kelivo/lib/core/providers/backup_provider.dart

请按照现有代码风格，使用 shadcn_flutter 组件。
```

---

## 八、注意事项

1. **代码风格**: 保持与现有项目一致，使用 shadcn_flutter 组件
2. **状态管理**: 使用 Riverpod，新 Provider 放在 `lib/providers/`
3. **数据模型**: 使用 Freezed，放在 `lib/models/`
4. **注释语言**: 代码注释使用中文
5. **合并冲突**: 各模块尽量修改不同文件，减少冲突

---

## 九、文件修改范围预估

| 模块 | 新增文件 | 修改文件 |
|------|----------|----------|
| A-通用设置 | 2-3 | settings_pages.dart |
| B-模型服务 | 3-4 | settings_pages.dart |
| C-数据管理 | 2-3 | settings_pages.dart |
| D-Provider | 4-5 | - |
| E-Service | 3-4 | gemini_service.dart |

---

**文档结束**
