// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SearchServiceOptions _$SearchServiceOptionsFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'bingLocal':
      return BingLocalOptions.fromJson(json);
    case 'duckDuckGo':
      return DuckDuckGoOptions.fromJson(json);
    case 'tavily':
      return TavilyOptions.fromJson(json);
    case 'exa':
      return ExaOptions.fromJson(json);
    case 'zhipu':
      return ZhipuOptions.fromJson(json);
    case 'searxng':
      return SearXNGOptions.fromJson(json);
    case 'linkup':
      return LinkUpOptions.fromJson(json);
    case 'brave':
      return BraveOptions.fromJson(json);
    case 'metaso':
      return MetasoOptions.fromJson(json);
    case 'jina':
      return JinaOptions.fromJson(json);
    case 'ollama':
      return OllamaOptions.fromJson(json);
    case 'perplexity':
      return PerplexityOptions.fromJson(json);
    case 'bocha':
      return BochaOptions.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'SearchServiceOptions',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$SearchServiceOptions {
  String get id => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this SearchServiceOptions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchServiceOptionsCopyWith<SearchServiceOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchServiceOptionsCopyWith<$Res> {
  factory $SearchServiceOptionsCopyWith(
    SearchServiceOptions value,
    $Res Function(SearchServiceOptions) then,
  ) = _$SearchServiceOptionsCopyWithImpl<$Res, SearchServiceOptions>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$SearchServiceOptionsCopyWithImpl<
  $Res,
  $Val extends SearchServiceOptions
>
    implements $SearchServiceOptionsCopyWith<$Res> {
  _$SearchServiceOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BingLocalOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$BingLocalOptionsImplCopyWith(
    _$BingLocalOptionsImpl value,
    $Res Function(_$BingLocalOptionsImpl) then,
  ) = __$$BingLocalOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$BingLocalOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$BingLocalOptionsImpl>
    implements _$$BingLocalOptionsImplCopyWith<$Res> {
  __$$BingLocalOptionsImplCopyWithImpl(
    _$BingLocalOptionsImpl _value,
    $Res Function(_$BingLocalOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$BingLocalOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BingLocalOptionsImpl implements BingLocalOptions {
  const _$BingLocalOptionsImpl({required this.id, final String? $type})
    : $type = $type ?? 'bingLocal';

  factory _$BingLocalOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BingLocalOptionsImplFromJson(json);

  @override
  final String id;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.bingLocal(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BingLocalOptionsImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BingLocalOptionsImplCopyWith<_$BingLocalOptionsImpl> get copyWith =>
      __$$BingLocalOptionsImplCopyWithImpl<_$BingLocalOptionsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return bingLocal(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return bingLocal?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (bingLocal != null) {
      return bingLocal(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return bingLocal(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return bingLocal?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (bingLocal != null) {
      return bingLocal(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BingLocalOptionsImplToJson(this);
  }
}

abstract class BingLocalOptions implements SearchServiceOptions {
  const factory BingLocalOptions({required final String id}) =
      _$BingLocalOptionsImpl;

  factory BingLocalOptions.fromJson(Map<String, dynamic> json) =
      _$BingLocalOptionsImpl.fromJson;

  @override
  String get id;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BingLocalOptionsImplCopyWith<_$BingLocalOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DuckDuckGoOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$DuckDuckGoOptionsImplCopyWith(
    _$DuckDuckGoOptionsImpl value,
    $Res Function(_$DuckDuckGoOptionsImpl) then,
  ) = __$$DuckDuckGoOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String region});
}

/// @nodoc
class __$$DuckDuckGoOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$DuckDuckGoOptionsImpl>
    implements _$$DuckDuckGoOptionsImplCopyWith<$Res> {
  __$$DuckDuckGoOptionsImplCopyWithImpl(
    _$DuckDuckGoOptionsImpl _value,
    $Res Function(_$DuckDuckGoOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? region = null}) {
    return _then(
      _$DuckDuckGoOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        region: null == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DuckDuckGoOptionsImpl implements DuckDuckGoOptions {
  const _$DuckDuckGoOptionsImpl({
    required this.id,
    this.region = 'us-en',
    final String? $type,
  }) : $type = $type ?? 'duckDuckGo';

  factory _$DuckDuckGoOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DuckDuckGoOptionsImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String region;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.duckDuckGo(id: $id, region: $region)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuckDuckGoOptionsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.region, region) || other.region == region));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, region);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DuckDuckGoOptionsImplCopyWith<_$DuckDuckGoOptionsImpl> get copyWith =>
      __$$DuckDuckGoOptionsImplCopyWithImpl<_$DuckDuckGoOptionsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return duckDuckGo(id, region);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return duckDuckGo?.call(id, region);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (duckDuckGo != null) {
      return duckDuckGo(id, region);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return duckDuckGo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return duckDuckGo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (duckDuckGo != null) {
      return duckDuckGo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DuckDuckGoOptionsImplToJson(this);
  }
}

abstract class DuckDuckGoOptions implements SearchServiceOptions {
  const factory DuckDuckGoOptions({
    required final String id,
    final String region,
  }) = _$DuckDuckGoOptionsImpl;

  factory DuckDuckGoOptions.fromJson(Map<String, dynamic> json) =
      _$DuckDuckGoOptionsImpl.fromJson;

  @override
  String get id;
  String get region;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DuckDuckGoOptionsImplCopyWith<_$DuckDuckGoOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TavilyOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$TavilyOptionsImplCopyWith(
    _$TavilyOptionsImpl value,
    $Res Function(_$TavilyOptionsImpl) then,
  ) = __$$TavilyOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String apiKey});
}

/// @nodoc
class __$$TavilyOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$TavilyOptionsImpl>
    implements _$$TavilyOptionsImplCopyWith<$Res> {
  __$$TavilyOptionsImplCopyWithImpl(
    _$TavilyOptionsImpl _value,
    $Res Function(_$TavilyOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? apiKey = null}) {
    return _then(
      _$TavilyOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKey: null == apiKey
            ? _value.apiKey
            : apiKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TavilyOptionsImpl implements TavilyOptions {
  const _$TavilyOptionsImpl({
    required this.id,
    required this.apiKey,
    final String? $type,
  }) : $type = $type ?? 'tavily';

  factory _$TavilyOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TavilyOptionsImplFromJson(json);

  @override
  final String id;
  @override
  final String apiKey;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.tavily(id: $id, apiKey: $apiKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TavilyOptionsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, apiKey);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TavilyOptionsImplCopyWith<_$TavilyOptionsImpl> get copyWith =>
      __$$TavilyOptionsImplCopyWithImpl<_$TavilyOptionsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return tavily(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return tavily?.call(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (tavily != null) {
      return tavily(id, apiKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return tavily(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return tavily?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (tavily != null) {
      return tavily(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TavilyOptionsImplToJson(this);
  }
}

abstract class TavilyOptions implements SearchServiceOptions {
  const factory TavilyOptions({
    required final String id,
    required final String apiKey,
  }) = _$TavilyOptionsImpl;

  factory TavilyOptions.fromJson(Map<String, dynamic> json) =
      _$TavilyOptionsImpl.fromJson;

  @override
  String get id;
  String get apiKey;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TavilyOptionsImplCopyWith<_$TavilyOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExaOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$ExaOptionsImplCopyWith(
    _$ExaOptionsImpl value,
    $Res Function(_$ExaOptionsImpl) then,
  ) = __$$ExaOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String apiKey});
}

/// @nodoc
class __$$ExaOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$ExaOptionsImpl>
    implements _$$ExaOptionsImplCopyWith<$Res> {
  __$$ExaOptionsImplCopyWithImpl(
    _$ExaOptionsImpl _value,
    $Res Function(_$ExaOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? apiKey = null}) {
    return _then(
      _$ExaOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKey: null == apiKey
            ? _value.apiKey
            : apiKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExaOptionsImpl implements ExaOptions {
  const _$ExaOptionsImpl({
    required this.id,
    required this.apiKey,
    final String? $type,
  }) : $type = $type ?? 'exa';

  factory _$ExaOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExaOptionsImplFromJson(json);

  @override
  final String id;
  @override
  final String apiKey;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.exa(id: $id, apiKey: $apiKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExaOptionsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, apiKey);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExaOptionsImplCopyWith<_$ExaOptionsImpl> get copyWith =>
      __$$ExaOptionsImplCopyWithImpl<_$ExaOptionsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return exa(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return exa?.call(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (exa != null) {
      return exa(id, apiKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return exa(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return exa?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (exa != null) {
      return exa(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ExaOptionsImplToJson(this);
  }
}

abstract class ExaOptions implements SearchServiceOptions {
  const factory ExaOptions({
    required final String id,
    required final String apiKey,
  }) = _$ExaOptionsImpl;

  factory ExaOptions.fromJson(Map<String, dynamic> json) =
      _$ExaOptionsImpl.fromJson;

  @override
  String get id;
  String get apiKey;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExaOptionsImplCopyWith<_$ExaOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ZhipuOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$ZhipuOptionsImplCopyWith(
    _$ZhipuOptionsImpl value,
    $Res Function(_$ZhipuOptionsImpl) then,
  ) = __$$ZhipuOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String apiKey});
}

/// @nodoc
class __$$ZhipuOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$ZhipuOptionsImpl>
    implements _$$ZhipuOptionsImplCopyWith<$Res> {
  __$$ZhipuOptionsImplCopyWithImpl(
    _$ZhipuOptionsImpl _value,
    $Res Function(_$ZhipuOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? apiKey = null}) {
    return _then(
      _$ZhipuOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKey: null == apiKey
            ? _value.apiKey
            : apiKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ZhipuOptionsImpl implements ZhipuOptions {
  const _$ZhipuOptionsImpl({
    required this.id,
    required this.apiKey,
    final String? $type,
  }) : $type = $type ?? 'zhipu';

  factory _$ZhipuOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ZhipuOptionsImplFromJson(json);

  @override
  final String id;
  @override
  final String apiKey;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.zhipu(id: $id, apiKey: $apiKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ZhipuOptionsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, apiKey);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ZhipuOptionsImplCopyWith<_$ZhipuOptionsImpl> get copyWith =>
      __$$ZhipuOptionsImplCopyWithImpl<_$ZhipuOptionsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return zhipu(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return zhipu?.call(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (zhipu != null) {
      return zhipu(id, apiKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return zhipu(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return zhipu?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (zhipu != null) {
      return zhipu(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ZhipuOptionsImplToJson(this);
  }
}

abstract class ZhipuOptions implements SearchServiceOptions {
  const factory ZhipuOptions({
    required final String id,
    required final String apiKey,
  }) = _$ZhipuOptionsImpl;

  factory ZhipuOptions.fromJson(Map<String, dynamic> json) =
      _$ZhipuOptionsImpl.fromJson;

  @override
  String get id;
  String get apiKey;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ZhipuOptionsImplCopyWith<_$ZhipuOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearXNGOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$SearXNGOptionsImplCopyWith(
    _$SearXNGOptionsImpl value,
    $Res Function(_$SearXNGOptionsImpl) then,
  ) = __$$SearXNGOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String url,
    String engines,
    String language,
    String username,
    String password,
  });
}

/// @nodoc
class __$$SearXNGOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$SearXNGOptionsImpl>
    implements _$$SearXNGOptionsImplCopyWith<$Res> {
  __$$SearXNGOptionsImplCopyWithImpl(
    _$SearXNGOptionsImpl _value,
    $Res Function(_$SearXNGOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? engines = null,
    Object? language = null,
    Object? username = null,
    Object? password = null,
  }) {
    return _then(
      _$SearXNGOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        engines: null == engines
            ? _value.engines
            : engines // ignore: cast_nullable_to_non_nullable
                  as String,
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SearXNGOptionsImpl implements SearXNGOptions {
  const _$SearXNGOptionsImpl({
    required this.id,
    required this.url,
    this.engines = '',
    this.language = 'en-US',
    this.username = '',
    this.password = '',
    final String? $type,
  }) : $type = $type ?? 'searxng';

  factory _$SearXNGOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearXNGOptionsImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  @JsonKey()
  final String engines;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String password;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.searxng(id: $id, url: $url, engines: $engines, language: $language, username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearXNGOptionsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.engines, engines) || other.engines == engines) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, url, engines, language, username, password);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearXNGOptionsImplCopyWith<_$SearXNGOptionsImpl> get copyWith =>
      __$$SearXNGOptionsImplCopyWithImpl<_$SearXNGOptionsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return searxng(id, url, engines, language, username, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return searxng?.call(id, url, engines, language, username, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (searxng != null) {
      return searxng(id, url, engines, language, username, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return searxng(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return searxng?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (searxng != null) {
      return searxng(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SearXNGOptionsImplToJson(this);
  }
}

abstract class SearXNGOptions implements SearchServiceOptions {
  const factory SearXNGOptions({
    required final String id,
    required final String url,
    final String engines,
    final String language,
    final String username,
    final String password,
  }) = _$SearXNGOptionsImpl;

  factory SearXNGOptions.fromJson(Map<String, dynamic> json) =
      _$SearXNGOptionsImpl.fromJson;

  @override
  String get id;
  String get url;
  String get engines;
  String get language;
  String get username;
  String get password;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearXNGOptionsImplCopyWith<_$SearXNGOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LinkUpOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$LinkUpOptionsImplCopyWith(
    _$LinkUpOptionsImpl value,
    $Res Function(_$LinkUpOptionsImpl) then,
  ) = __$$LinkUpOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String apiKey});
}

/// @nodoc
class __$$LinkUpOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$LinkUpOptionsImpl>
    implements _$$LinkUpOptionsImplCopyWith<$Res> {
  __$$LinkUpOptionsImplCopyWithImpl(
    _$LinkUpOptionsImpl _value,
    $Res Function(_$LinkUpOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? apiKey = null}) {
    return _then(
      _$LinkUpOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKey: null == apiKey
            ? _value.apiKey
            : apiKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LinkUpOptionsImpl implements LinkUpOptions {
  const _$LinkUpOptionsImpl({
    required this.id,
    required this.apiKey,
    final String? $type,
  }) : $type = $type ?? 'linkup';

  factory _$LinkUpOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkUpOptionsImplFromJson(json);

  @override
  final String id;
  @override
  final String apiKey;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.linkup(id: $id, apiKey: $apiKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkUpOptionsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, apiKey);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkUpOptionsImplCopyWith<_$LinkUpOptionsImpl> get copyWith =>
      __$$LinkUpOptionsImplCopyWithImpl<_$LinkUpOptionsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return linkup(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return linkup?.call(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (linkup != null) {
      return linkup(id, apiKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return linkup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return linkup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (linkup != null) {
      return linkup(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkUpOptionsImplToJson(this);
  }
}

abstract class LinkUpOptions implements SearchServiceOptions {
  const factory LinkUpOptions({
    required final String id,
    required final String apiKey,
  }) = _$LinkUpOptionsImpl;

  factory LinkUpOptions.fromJson(Map<String, dynamic> json) =
      _$LinkUpOptionsImpl.fromJson;

  @override
  String get id;
  String get apiKey;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkUpOptionsImplCopyWith<_$LinkUpOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BraveOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$BraveOptionsImplCopyWith(
    _$BraveOptionsImpl value,
    $Res Function(_$BraveOptionsImpl) then,
  ) = __$$BraveOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String apiKey});
}

/// @nodoc
class __$$BraveOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$BraveOptionsImpl>
    implements _$$BraveOptionsImplCopyWith<$Res> {
  __$$BraveOptionsImplCopyWithImpl(
    _$BraveOptionsImpl _value,
    $Res Function(_$BraveOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? apiKey = null}) {
    return _then(
      _$BraveOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKey: null == apiKey
            ? _value.apiKey
            : apiKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BraveOptionsImpl implements BraveOptions {
  const _$BraveOptionsImpl({
    required this.id,
    required this.apiKey,
    final String? $type,
  }) : $type = $type ?? 'brave';

  factory _$BraveOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BraveOptionsImplFromJson(json);

  @override
  final String id;
  @override
  final String apiKey;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.brave(id: $id, apiKey: $apiKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BraveOptionsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, apiKey);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BraveOptionsImplCopyWith<_$BraveOptionsImpl> get copyWith =>
      __$$BraveOptionsImplCopyWithImpl<_$BraveOptionsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return brave(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return brave?.call(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (brave != null) {
      return brave(id, apiKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return brave(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return brave?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (brave != null) {
      return brave(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BraveOptionsImplToJson(this);
  }
}

abstract class BraveOptions implements SearchServiceOptions {
  const factory BraveOptions({
    required final String id,
    required final String apiKey,
  }) = _$BraveOptionsImpl;

  factory BraveOptions.fromJson(Map<String, dynamic> json) =
      _$BraveOptionsImpl.fromJson;

  @override
  String get id;
  String get apiKey;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BraveOptionsImplCopyWith<_$BraveOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MetasoOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$MetasoOptionsImplCopyWith(
    _$MetasoOptionsImpl value,
    $Res Function(_$MetasoOptionsImpl) then,
  ) = __$$MetasoOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String apiKey});
}

/// @nodoc
class __$$MetasoOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$MetasoOptionsImpl>
    implements _$$MetasoOptionsImplCopyWith<$Res> {
  __$$MetasoOptionsImplCopyWithImpl(
    _$MetasoOptionsImpl _value,
    $Res Function(_$MetasoOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? apiKey = null}) {
    return _then(
      _$MetasoOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKey: null == apiKey
            ? _value.apiKey
            : apiKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MetasoOptionsImpl implements MetasoOptions {
  const _$MetasoOptionsImpl({
    required this.id,
    required this.apiKey,
    final String? $type,
  }) : $type = $type ?? 'metaso';

  factory _$MetasoOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetasoOptionsImplFromJson(json);

  @override
  final String id;
  @override
  final String apiKey;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.metaso(id: $id, apiKey: $apiKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetasoOptionsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, apiKey);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MetasoOptionsImplCopyWith<_$MetasoOptionsImpl> get copyWith =>
      __$$MetasoOptionsImplCopyWithImpl<_$MetasoOptionsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return metaso(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return metaso?.call(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (metaso != null) {
      return metaso(id, apiKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return metaso(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return metaso?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (metaso != null) {
      return metaso(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MetasoOptionsImplToJson(this);
  }
}

abstract class MetasoOptions implements SearchServiceOptions {
  const factory MetasoOptions({
    required final String id,
    required final String apiKey,
  }) = _$MetasoOptionsImpl;

  factory MetasoOptions.fromJson(Map<String, dynamic> json) =
      _$MetasoOptionsImpl.fromJson;

  @override
  String get id;
  String get apiKey;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MetasoOptionsImplCopyWith<_$MetasoOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$JinaOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$JinaOptionsImplCopyWith(
    _$JinaOptionsImpl value,
    $Res Function(_$JinaOptionsImpl) then,
  ) = __$$JinaOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String apiKey});
}

/// @nodoc
class __$$JinaOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$JinaOptionsImpl>
    implements _$$JinaOptionsImplCopyWith<$Res> {
  __$$JinaOptionsImplCopyWithImpl(
    _$JinaOptionsImpl _value,
    $Res Function(_$JinaOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? apiKey = null}) {
    return _then(
      _$JinaOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKey: null == apiKey
            ? _value.apiKey
            : apiKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JinaOptionsImpl implements JinaOptions {
  const _$JinaOptionsImpl({
    required this.id,
    required this.apiKey,
    final String? $type,
  }) : $type = $type ?? 'jina';

  factory _$JinaOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$JinaOptionsImplFromJson(json);

  @override
  final String id;
  @override
  final String apiKey;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.jina(id: $id, apiKey: $apiKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JinaOptionsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, apiKey);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JinaOptionsImplCopyWith<_$JinaOptionsImpl> get copyWith =>
      __$$JinaOptionsImplCopyWithImpl<_$JinaOptionsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return jina(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return jina?.call(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (jina != null) {
      return jina(id, apiKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return jina(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return jina?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (jina != null) {
      return jina(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$JinaOptionsImplToJson(this);
  }
}

abstract class JinaOptions implements SearchServiceOptions {
  const factory JinaOptions({
    required final String id,
    required final String apiKey,
  }) = _$JinaOptionsImpl;

  factory JinaOptions.fromJson(Map<String, dynamic> json) =
      _$JinaOptionsImpl.fromJson;

  @override
  String get id;
  String get apiKey;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JinaOptionsImplCopyWith<_$JinaOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OllamaOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$OllamaOptionsImplCopyWith(
    _$OllamaOptionsImpl value,
    $Res Function(_$OllamaOptionsImpl) then,
  ) = __$$OllamaOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String apiKey});
}

/// @nodoc
class __$$OllamaOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$OllamaOptionsImpl>
    implements _$$OllamaOptionsImplCopyWith<$Res> {
  __$$OllamaOptionsImplCopyWithImpl(
    _$OllamaOptionsImpl _value,
    $Res Function(_$OllamaOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? apiKey = null}) {
    return _then(
      _$OllamaOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKey: null == apiKey
            ? _value.apiKey
            : apiKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OllamaOptionsImpl implements OllamaOptions {
  const _$OllamaOptionsImpl({
    required this.id,
    required this.apiKey,
    final String? $type,
  }) : $type = $type ?? 'ollama';

  factory _$OllamaOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OllamaOptionsImplFromJson(json);

  @override
  final String id;
  @override
  final String apiKey;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.ollama(id: $id, apiKey: $apiKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OllamaOptionsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, apiKey);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OllamaOptionsImplCopyWith<_$OllamaOptionsImpl> get copyWith =>
      __$$OllamaOptionsImplCopyWithImpl<_$OllamaOptionsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return ollama(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return ollama?.call(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (ollama != null) {
      return ollama(id, apiKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return ollama(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return ollama?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (ollama != null) {
      return ollama(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$OllamaOptionsImplToJson(this);
  }
}

abstract class OllamaOptions implements SearchServiceOptions {
  const factory OllamaOptions({
    required final String id,
    required final String apiKey,
  }) = _$OllamaOptionsImpl;

  factory OllamaOptions.fromJson(Map<String, dynamic> json) =
      _$OllamaOptionsImpl.fromJson;

  @override
  String get id;
  String get apiKey;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OllamaOptionsImplCopyWith<_$OllamaOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PerplexityOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$PerplexityOptionsImplCopyWith(
    _$PerplexityOptionsImpl value,
    $Res Function(_$PerplexityOptionsImpl) then,
  ) = __$$PerplexityOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String apiKey});
}

/// @nodoc
class __$$PerplexityOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$PerplexityOptionsImpl>
    implements _$$PerplexityOptionsImplCopyWith<$Res> {
  __$$PerplexityOptionsImplCopyWithImpl(
    _$PerplexityOptionsImpl _value,
    $Res Function(_$PerplexityOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? apiKey = null}) {
    return _then(
      _$PerplexityOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKey: null == apiKey
            ? _value.apiKey
            : apiKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PerplexityOptionsImpl implements PerplexityOptions {
  const _$PerplexityOptionsImpl({
    required this.id,
    required this.apiKey,
    final String? $type,
  }) : $type = $type ?? 'perplexity';

  factory _$PerplexityOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerplexityOptionsImplFromJson(json);

  @override
  final String id;
  @override
  final String apiKey;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.perplexity(id: $id, apiKey: $apiKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerplexityOptionsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, apiKey);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PerplexityOptionsImplCopyWith<_$PerplexityOptionsImpl> get copyWith =>
      __$$PerplexityOptionsImplCopyWithImpl<_$PerplexityOptionsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return perplexity(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return perplexity?.call(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (perplexity != null) {
      return perplexity(id, apiKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return perplexity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return perplexity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (perplexity != null) {
      return perplexity(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PerplexityOptionsImplToJson(this);
  }
}

abstract class PerplexityOptions implements SearchServiceOptions {
  const factory PerplexityOptions({
    required final String id,
    required final String apiKey,
  }) = _$PerplexityOptionsImpl;

  factory PerplexityOptions.fromJson(Map<String, dynamic> json) =
      _$PerplexityOptionsImpl.fromJson;

  @override
  String get id;
  String get apiKey;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PerplexityOptionsImplCopyWith<_$PerplexityOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BochaOptionsImplCopyWith<$Res>
    implements $SearchServiceOptionsCopyWith<$Res> {
  factory _$$BochaOptionsImplCopyWith(
    _$BochaOptionsImpl value,
    $Res Function(_$BochaOptionsImpl) then,
  ) = __$$BochaOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String apiKey});
}

/// @nodoc
class __$$BochaOptionsImplCopyWithImpl<$Res>
    extends _$SearchServiceOptionsCopyWithImpl<$Res, _$BochaOptionsImpl>
    implements _$$BochaOptionsImplCopyWith<$Res> {
  __$$BochaOptionsImplCopyWithImpl(
    _$BochaOptionsImpl _value,
    $Res Function(_$BochaOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? apiKey = null}) {
    return _then(
      _$BochaOptionsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKey: null == apiKey
            ? _value.apiKey
            : apiKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BochaOptionsImpl implements BochaOptions {
  const _$BochaOptionsImpl({
    required this.id,
    required this.apiKey,
    final String? $type,
  }) : $type = $type ?? 'bocha';

  factory _$BochaOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BochaOptionsImplFromJson(json);

  @override
  final String id;
  @override
  final String apiKey;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SearchServiceOptions.bocha(id: $id, apiKey: $apiKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BochaOptionsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, apiKey);

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BochaOptionsImplCopyWith<_$BochaOptionsImpl> get copyWith =>
      __$$BochaOptionsImplCopyWithImpl<_$BochaOptionsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) bingLocal,
    required TResult Function(String id, String region) duckDuckGo,
    required TResult Function(String id, String apiKey) tavily,
    required TResult Function(String id, String apiKey) exa,
    required TResult Function(String id, String apiKey) zhipu,
    required TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )
    searxng,
    required TResult Function(String id, String apiKey) linkup,
    required TResult Function(String id, String apiKey) brave,
    required TResult Function(String id, String apiKey) metaso,
    required TResult Function(String id, String apiKey) jina,
    required TResult Function(String id, String apiKey) ollama,
    required TResult Function(String id, String apiKey) perplexity,
    required TResult Function(String id, String apiKey) bocha,
  }) {
    return bocha(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? bingLocal,
    TResult? Function(String id, String region)? duckDuckGo,
    TResult? Function(String id, String apiKey)? tavily,
    TResult? Function(String id, String apiKey)? exa,
    TResult? Function(String id, String apiKey)? zhipu,
    TResult? Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult? Function(String id, String apiKey)? linkup,
    TResult? Function(String id, String apiKey)? brave,
    TResult? Function(String id, String apiKey)? metaso,
    TResult? Function(String id, String apiKey)? jina,
    TResult? Function(String id, String apiKey)? ollama,
    TResult? Function(String id, String apiKey)? perplexity,
    TResult? Function(String id, String apiKey)? bocha,
  }) {
    return bocha?.call(id, apiKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? bingLocal,
    TResult Function(String id, String region)? duckDuckGo,
    TResult Function(String id, String apiKey)? tavily,
    TResult Function(String id, String apiKey)? exa,
    TResult Function(String id, String apiKey)? zhipu,
    TResult Function(
      String id,
      String url,
      String engines,
      String language,
      String username,
      String password,
    )?
    searxng,
    TResult Function(String id, String apiKey)? linkup,
    TResult Function(String id, String apiKey)? brave,
    TResult Function(String id, String apiKey)? metaso,
    TResult Function(String id, String apiKey)? jina,
    TResult Function(String id, String apiKey)? ollama,
    TResult Function(String id, String apiKey)? perplexity,
    TResult Function(String id, String apiKey)? bocha,
    required TResult orElse(),
  }) {
    if (bocha != null) {
      return bocha(id, apiKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BingLocalOptions value) bingLocal,
    required TResult Function(DuckDuckGoOptions value) duckDuckGo,
    required TResult Function(TavilyOptions value) tavily,
    required TResult Function(ExaOptions value) exa,
    required TResult Function(ZhipuOptions value) zhipu,
    required TResult Function(SearXNGOptions value) searxng,
    required TResult Function(LinkUpOptions value) linkup,
    required TResult Function(BraveOptions value) brave,
    required TResult Function(MetasoOptions value) metaso,
    required TResult Function(JinaOptions value) jina,
    required TResult Function(OllamaOptions value) ollama,
    required TResult Function(PerplexityOptions value) perplexity,
    required TResult Function(BochaOptions value) bocha,
  }) {
    return bocha(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BingLocalOptions value)? bingLocal,
    TResult? Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult? Function(TavilyOptions value)? tavily,
    TResult? Function(ExaOptions value)? exa,
    TResult? Function(ZhipuOptions value)? zhipu,
    TResult? Function(SearXNGOptions value)? searxng,
    TResult? Function(LinkUpOptions value)? linkup,
    TResult? Function(BraveOptions value)? brave,
    TResult? Function(MetasoOptions value)? metaso,
    TResult? Function(JinaOptions value)? jina,
    TResult? Function(OllamaOptions value)? ollama,
    TResult? Function(PerplexityOptions value)? perplexity,
    TResult? Function(BochaOptions value)? bocha,
  }) {
    return bocha?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BingLocalOptions value)? bingLocal,
    TResult Function(DuckDuckGoOptions value)? duckDuckGo,
    TResult Function(TavilyOptions value)? tavily,
    TResult Function(ExaOptions value)? exa,
    TResult Function(ZhipuOptions value)? zhipu,
    TResult Function(SearXNGOptions value)? searxng,
    TResult Function(LinkUpOptions value)? linkup,
    TResult Function(BraveOptions value)? brave,
    TResult Function(MetasoOptions value)? metaso,
    TResult Function(JinaOptions value)? jina,
    TResult Function(OllamaOptions value)? ollama,
    TResult Function(PerplexityOptions value)? perplexity,
    TResult Function(BochaOptions value)? bocha,
    required TResult orElse(),
  }) {
    if (bocha != null) {
      return bocha(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BochaOptionsImplToJson(this);
  }
}

abstract class BochaOptions implements SearchServiceOptions {
  const factory BochaOptions({
    required final String id,
    required final String apiKey,
  }) = _$BochaOptionsImpl;

  factory BochaOptions.fromJson(Map<String, dynamic> json) =
      _$BochaOptionsImpl.fromJson;

  @override
  String get id;
  String get apiKey;

  /// Create a copy of SearchServiceOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BochaOptionsImplCopyWith<_$BochaOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SearchCommonOptions _$SearchCommonOptionsFromJson(Map<String, dynamic> json) {
  return _SearchCommonOptions.fromJson(json);
}

/// @nodoc
mixin _$SearchCommonOptions {
  int get resultSize => throw _privateConstructorUsedError; // 结果数量 1-20
  int get timeout => throw _privateConstructorUsedError;

  /// Serializes this SearchCommonOptions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchCommonOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchCommonOptionsCopyWith<SearchCommonOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchCommonOptionsCopyWith<$Res> {
  factory $SearchCommonOptionsCopyWith(
    SearchCommonOptions value,
    $Res Function(SearchCommonOptions) then,
  ) = _$SearchCommonOptionsCopyWithImpl<$Res, SearchCommonOptions>;
  @useResult
  $Res call({int resultSize, int timeout});
}

/// @nodoc
class _$SearchCommonOptionsCopyWithImpl<$Res, $Val extends SearchCommonOptions>
    implements $SearchCommonOptionsCopyWith<$Res> {
  _$SearchCommonOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchCommonOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? resultSize = null, Object? timeout = null}) {
    return _then(
      _value.copyWith(
            resultSize: null == resultSize
                ? _value.resultSize
                : resultSize // ignore: cast_nullable_to_non_nullable
                      as int,
            timeout: null == timeout
                ? _value.timeout
                : timeout // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SearchCommonOptionsImplCopyWith<$Res>
    implements $SearchCommonOptionsCopyWith<$Res> {
  factory _$$SearchCommonOptionsImplCopyWith(
    _$SearchCommonOptionsImpl value,
    $Res Function(_$SearchCommonOptionsImpl) then,
  ) = __$$SearchCommonOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int resultSize, int timeout});
}

/// @nodoc
class __$$SearchCommonOptionsImplCopyWithImpl<$Res>
    extends _$SearchCommonOptionsCopyWithImpl<$Res, _$SearchCommonOptionsImpl>
    implements _$$SearchCommonOptionsImplCopyWith<$Res> {
  __$$SearchCommonOptionsImplCopyWithImpl(
    _$SearchCommonOptionsImpl _value,
    $Res Function(_$SearchCommonOptionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchCommonOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? resultSize = null, Object? timeout = null}) {
    return _then(
      _$SearchCommonOptionsImpl(
        resultSize: null == resultSize
            ? _value.resultSize
            : resultSize // ignore: cast_nullable_to_non_nullable
                  as int,
        timeout: null == timeout
            ? _value.timeout
            : timeout // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchCommonOptionsImpl implements _SearchCommonOptions {
  const _$SearchCommonOptionsImpl({this.resultSize = 5, this.timeout = 10000});

  factory _$SearchCommonOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchCommonOptionsImplFromJson(json);

  @override
  @JsonKey()
  final int resultSize;
  // 结果数量 1-20
  @override
  @JsonKey()
  final int timeout;

  @override
  String toString() {
    return 'SearchCommonOptions(resultSize: $resultSize, timeout: $timeout)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchCommonOptionsImpl &&
            (identical(other.resultSize, resultSize) ||
                other.resultSize == resultSize) &&
            (identical(other.timeout, timeout) || other.timeout == timeout));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, resultSize, timeout);

  /// Create a copy of SearchCommonOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchCommonOptionsImplCopyWith<_$SearchCommonOptionsImpl> get copyWith =>
      __$$SearchCommonOptionsImplCopyWithImpl<_$SearchCommonOptionsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchCommonOptionsImplToJson(this);
  }
}

abstract class _SearchCommonOptions implements SearchCommonOptions {
  const factory _SearchCommonOptions({
    final int resultSize,
    final int timeout,
  }) = _$SearchCommonOptionsImpl;

  factory _SearchCommonOptions.fromJson(Map<String, dynamic> json) =
      _$SearchCommonOptionsImpl.fromJson;

  @override
  int get resultSize; // 结果数量 1-20
  @override
  int get timeout;

  /// Create a copy of SearchCommonOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchCommonOptionsImplCopyWith<_$SearchCommonOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
