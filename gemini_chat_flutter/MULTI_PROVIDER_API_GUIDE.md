# 多服务商 API 集成使用指南

## 概述

本项目已实现多服务商 AI API 统一集成，支持以下服务商：

- **OpenAI** (GPT-4, GPT-3.5 等)
- **Anthropic** (Claude 3.5 Sonnet, Claude 3 Opus 等)
- **Google Gemini** (Gemini 2.0 Flash, Gemini 1.5 Pro 等)
- **Azure OpenAI**
- **Groq** (OpenAI 兼容)
- **Together AI** (OpenAI 兼容)
- **DeepSeek** (OpenAI 兼容)
- **Moonshot AI** (OpenAI 兼容)
- **Zhipu AI** (OpenAI 兼容)

---

## 架构设计

### 核心组件

1. **AIService 接口** (`lib/services/ai_service.dart`)
   - 定义统一的 AI 服务接口
   - 所有服务商实现此接口

2. **具体实现**
   - `OpenAIService` - OpenAI 及兼容服务商
   - `AnthropicService` - Anthropic Claude
   - `GeminiService` - Google Gemini

3. **AIServiceFactory** (`lib/services/ai_service_factory.dart`)
   - 根据配置动态创建服务实例
   - 支持自定义 Base URL

4. **AIServiceProvider** (`lib/providers/ai_service_provider.dart`)
   - Riverpod Provider 集成
   - 自动从设置中读取配置

---

## 使用方法

### 1. 配置服务商

在设置页面（`lib/screens/providers_page.dart`）中配置服务商：

```dart
// 示例：配置 OpenAI
final openaiConfig = ProviderConfig(
  key: 'openai',
  name: 'OpenAI',
  apiKeys: ['sk-your-api-key-here'],
  baseUrl: 'https://api.openai.com/v1',
  models: ['gpt-4', 'gpt-3.5-turbo'],
  enabled: true,
);
```

### 2. 在代码中使用

#### 方式 A：使用默认 Provider（推荐）

```dart
// 在 Widget 中
final aiService = ref.read(aiServiceProvider);

// 流式响应
await for (final chunk in aiService.sendMessageStream(
  history: messages,
  newMessage: 'Hello',
  systemPrompt: 'You are a helpful assistant',
  temperature: 0.7,
  topP: 1.0,
)) {
  print(chunk);
}

// 非流式响应
final response = await aiService.sendMessage(
  history: messages,
  newMessage: 'Hello',
);
```

#### 方式 B：使用 Factory 直接创建

```dart
// 从配置创建
final service = AIServiceFactory.create(
  providerConfig: providerConfig,
  modelId: 'gpt-4',
);

// 简单创建
final service = AIServiceFactory.createSimple(
  providerKey: 'openai',
  apiKey: 'sk-xxx',
  modelId: 'gpt-4',
);
```

#### 方式 C：使用 Family Provider

```dart
final service = ref.watch(aiServiceFromConfigProvider(providerConfig));
```

---

## API 参数说明

### sendMessageStream / sendMessage

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| `history` | `List<Message>` | ✅ | 历史消息列表 |
| `newMessage` | `String` | ✅ | 新消息内容 |
| `systemPrompt` | `String?` | ❌ | 系统提示词 |
| `temperature` | `double?` | ❌ | 温度参数 (0.0-2.0) |
| `topP` | `double?` | ❌ | Top-P 参数 (0.0-1.0) |
| `maxTokens` | `int?` | ❌ | 最大 token 数 |

---

## 服务商特性对比

| 服务商 | 流式响应 | 系统提示词 | 温度参数 | Top-P | Max Tokens |
|--------|---------|-----------|---------|-------|-----------|
| OpenAI | ✅ | ✅ | ✅ | ✅ | ✅ |
| Anthropic | ✅ | ✅ | ✅ | ✅ | ✅ |
| Gemini | ✅ | ✅ | ✅ | ✅ | ✅ |
| Azure OpenAI | ✅ | ✅ | ✅ | ✅ | ✅ |
| Groq | ✅ | ✅ | ✅ | ✅ | ✅ |

---

## 错误处理

所有服务都会抛出 `AIServiceException`：

```dart
try {
  final response = await aiService.sendMessage(...);
} on AIServiceException catch (e) {
  print('错误: ${e.message}');
  print('错误码: ${e.code}');
}
```

---

## 添加新服务商

### 步骤 1：实现 AIService 接口

```dart
class NewProviderService implements AIService {
  @override
  String get providerId => 'new_provider';

  @override
  String get providerName => 'New Provider';

  @override
  Stream<String> sendMessageStream({...}) async* {
    // 实现流式响应
  }

  @override
  Future<String> sendMessage({...}) async {
    // 实现非流式响应
  }

  @override
  Future<bool> validateApiKey(String apiKey) async {
    // 实现 API Key 验证
  }

  @override
  Future<List<String>> getAvailableModels() async {
    // 返回可用模型列表
  }
}
```

### 步骤 2：在 Factory 中注册

编辑 `lib/services/ai_service_factory.dart`：

```dart
case 'new_provider':
  return NewProviderService(
    apiKey: apiKey,
    model: model,
    baseUrl: providerConfig.baseUrl,
  );
```

### 步骤 3：添加默认配置

编辑 `lib/models/provider_config.dart`：

```dart
static String _getDefaultName(String key) {
  const names = {
    // ...
    'new_provider': 'New Provider',
  };
  return names[key] ?? key;
}

static String _getDefaultBaseUrl(String key) {
  const urls = {
    // ...
    'new_provider': 'https://api.newprovider.com/v1',
  };
  return urls[key] ?? '';
}
```

---

## 测试

### 单元测试示例

```dart
test('OpenAI Service 流式响应', () async {
  final service = OpenAIService(
    apiKey: 'test-key',
    model: 'gpt-4',
  );

  final chunks = <String>[];
  await for (final chunk in service.sendMessageStream(
    history: [],
    newMessage: 'Hello',
  )) {
    chunks.add(chunk);
  }

  expect(chunks.isNotEmpty, true);
});
```

---

## 常见问题

### Q: 如何切换服务商？

A: 在设置页面选择不同的服务商和模型，应用会自动切换。

### Q: 支持自定义 Base URL 吗？

A: 支持。在服务商配置中设置 `baseUrl` 字段。

### Q: 如何添加多个 API Key？

A: 在 `ProviderConfig.apiKeys` 列表中添加多个 Key，使用 `selectedKeyIndex` 选择当前使用的 Key。

### Q: 流式响应失败怎么办？

A: 检查网络连接、API Key 是否有效、Base URL 是否正确。查看错误日志获取详细信息。

---

## 性能优化建议

1. **复用服务实例**：避免频繁创建新实例
2. **使用流式响应**：提升用户体验
3. **设置合理的 maxTokens**：控制响应长度
4. **启用缓存**：对于重复请求使用缓存

---

## 安全注意事项

1. **API Key 保护**：不要在代码中硬编码 API Key
2. **使用 .env 文件**：敏感信息存储在 `.env` 中
3. **HTTPS 连接**：确保所有 API 调用使用 HTTPS
4. **错误信息脱敏**：不要在错误消息中暴露 API Key

---

## 更新日志

### v1.0.0 (2025-11-29)
- ✅ 实现 OpenAI Service
- ✅ 实现 Anthropic Service
- ✅ 重构 Gemini Service
- ✅ 创建 AIServiceFactory
- ✅ 集成 Riverpod Provider
- ✅ 更新 ChatScreen 以支持多服务商

---

## 相关文件

- `lib/services/ai_service.dart` - 统一接口定义
- `lib/services/openai_service.dart` - OpenAI 实现
- `lib/services/anthropic_service.dart` - Anthropic 实现
- `lib/services/gemini_service.dart` - Gemini 实现
- `lib/services/ai_service_factory.dart` - 服务工厂
- `lib/providers/ai_service_provider.dart` - Riverpod Provider
- `lib/models/provider_config.dart` - 配置数据模型
- `lib/screens/chat_screen.dart` - 聊天界面集成

---

## 贡献

欢迎提交 Issue 和 Pull Request！
