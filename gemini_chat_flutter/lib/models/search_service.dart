import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_service.freezed.dart';
part 'search_service.g.dart';

/// 搜索服务选项基类
@freezed
class SearchServiceOptions with _$SearchServiceOptions {
  const factory SearchServiceOptions.bingLocal({
    required String id,
  }) = BingLocalOptions;

  const factory SearchServiceOptions.duckDuckGo({
    required String id,
    @Default('us-en') String region,
  }) = DuckDuckGoOptions;

  const factory SearchServiceOptions.tavily({
    required String id,
    required String apiKey,
  }) = TavilyOptions;

  const factory SearchServiceOptions.exa({
    required String id,
    required String apiKey,
  }) = ExaOptions;

  const factory SearchServiceOptions.zhipu({
    required String id,
    required String apiKey,
  }) = ZhipuOptions;

  const factory SearchServiceOptions.searxng({
    required String id,
    required String url,
    @Default('') String engines,
    @Default('en-US') String language,
    @Default('') String username,
    @Default('') String password,
  }) = SearXNGOptions;

  const factory SearchServiceOptions.linkup({
    required String id,
    required String apiKey,
  }) = LinkUpOptions;

  const factory SearchServiceOptions.brave({
    required String id,
    required String apiKey,
  }) = BraveOptions;

  const factory SearchServiceOptions.metaso({
    required String id,
    required String apiKey,
  }) = MetasoOptions;

  const factory SearchServiceOptions.jina({
    required String id,
    required String apiKey,
  }) = JinaOptions;

  const factory SearchServiceOptions.ollama({
    required String id,
    required String apiKey,
  }) = OllamaOptions;

  const factory SearchServiceOptions.perplexity({
    required String id,
    required String apiKey,
  }) = PerplexityOptions;

  const factory SearchServiceOptions.bocha({
    required String id,
    required String apiKey,
  }) = BochaOptions;

  factory SearchServiceOptions.fromJson(Map<String, dynamic> json) =>
      _$SearchServiceOptionsFromJson(json);

  /// 默认选项（Bing Local）
  static SearchServiceOptions get defaultOption =>
      const SearchServiceOptions.bingLocal(id: 'default-bing');
}

/// 通用搜索配置
@freezed
class SearchCommonOptions with _$SearchCommonOptions {
  const factory SearchCommonOptions({
    @Default(5) int resultSize, // 结果数量 1-20
    @Default(10000) int timeout, // 超时时间（毫秒）1000-30000
  }) = _SearchCommonOptions;

  factory SearchCommonOptions.fromJson(Map<String, dynamic> json) =>
      _$SearchCommonOptionsFromJson(json);
}
