// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProviderConfig _$ProviderConfigFromJson(Map<String, dynamic> json) {
  return _ProviderConfig.fromJson(json);
}

/// @nodoc
mixin _$ProviderConfig {
  String get key =>
      throw _privateConstructorUsedError; // 服务商唯一标识（如 'openai', 'anthropic'）
  String get name => throw _privateConstructorUsedError; // 显示名称
  List<String> get apiKeys => throw _privateConstructorUsedError; // API Keys 列表
  String get baseUrl => throw _privateConstructorUsedError; // 自定义 Base URL
  List<String> get models => throw _privateConstructorUsedError; // 可用模型列表
  Map<String, dynamic> get modelOverrides =>
      throw _privateConstructorUsedError; // 模型覆盖配置
  bool get enabled => throw _privateConstructorUsedError; // 是否启用
  int get selectedKeyIndex => throw _privateConstructorUsedError;

  /// Serializes this ProviderConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProviderConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProviderConfigCopyWith<ProviderConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProviderConfigCopyWith<$Res> {
  factory $ProviderConfigCopyWith(
    ProviderConfig value,
    $Res Function(ProviderConfig) then,
  ) = _$ProviderConfigCopyWithImpl<$Res, ProviderConfig>;
  @useResult
  $Res call({
    String key,
    String name,
    List<String> apiKeys,
    String baseUrl,
    List<String> models,
    Map<String, dynamic> modelOverrides,
    bool enabled,
    int selectedKeyIndex,
  });
}

/// @nodoc
class _$ProviderConfigCopyWithImpl<$Res, $Val extends ProviderConfig>
    implements $ProviderConfigCopyWith<$Res> {
  _$ProviderConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProviderConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? name = null,
    Object? apiKeys = null,
    Object? baseUrl = null,
    Object? models = null,
    Object? modelOverrides = null,
    Object? enabled = null,
    Object? selectedKeyIndex = null,
  }) {
    return _then(
      _value.copyWith(
            key: null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            apiKeys: null == apiKeys
                ? _value.apiKeys
                : apiKeys // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            baseUrl: null == baseUrl
                ? _value.baseUrl
                : baseUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            models: null == models
                ? _value.models
                : models // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            modelOverrides: null == modelOverrides
                ? _value.modelOverrides
                : modelOverrides // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            enabled: null == enabled
                ? _value.enabled
                : enabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedKeyIndex: null == selectedKeyIndex
                ? _value.selectedKeyIndex
                : selectedKeyIndex // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProviderConfigImplCopyWith<$Res>
    implements $ProviderConfigCopyWith<$Res> {
  factory _$$ProviderConfigImplCopyWith(
    _$ProviderConfigImpl value,
    $Res Function(_$ProviderConfigImpl) then,
  ) = __$$ProviderConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String key,
    String name,
    List<String> apiKeys,
    String baseUrl,
    List<String> models,
    Map<String, dynamic> modelOverrides,
    bool enabled,
    int selectedKeyIndex,
  });
}

/// @nodoc
class __$$ProviderConfigImplCopyWithImpl<$Res>
    extends _$ProviderConfigCopyWithImpl<$Res, _$ProviderConfigImpl>
    implements _$$ProviderConfigImplCopyWith<$Res> {
  __$$ProviderConfigImplCopyWithImpl(
    _$ProviderConfigImpl _value,
    $Res Function(_$ProviderConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProviderConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? name = null,
    Object? apiKeys = null,
    Object? baseUrl = null,
    Object? models = null,
    Object? modelOverrides = null,
    Object? enabled = null,
    Object? selectedKeyIndex = null,
  }) {
    return _then(
      _$ProviderConfigImpl(
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        apiKeys: null == apiKeys
            ? _value._apiKeys
            : apiKeys // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        baseUrl: null == baseUrl
            ? _value.baseUrl
            : baseUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        models: null == models
            ? _value._models
            : models // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        modelOverrides: null == modelOverrides
            ? _value._modelOverrides
            : modelOverrides // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        enabled: null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedKeyIndex: null == selectedKeyIndex
            ? _value.selectedKeyIndex
            : selectedKeyIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProviderConfigImpl implements _ProviderConfig {
  const _$ProviderConfigImpl({
    required this.key,
    required this.name,
    final List<String> apiKeys = const [],
    this.baseUrl = '',
    final List<String> models = const [],
    final Map<String, dynamic> modelOverrides = const {},
    this.enabled = true,
    this.selectedKeyIndex = 0,
  }) : _apiKeys = apiKeys,
       _models = models,
       _modelOverrides = modelOverrides;

  factory _$ProviderConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProviderConfigImplFromJson(json);

  @override
  final String key;
  // 服务商唯一标识（如 'openai', 'anthropic'）
  @override
  final String name;
  // 显示名称
  final List<String> _apiKeys;
  // 显示名称
  @override
  @JsonKey()
  List<String> get apiKeys {
    if (_apiKeys is EqualUnmodifiableListView) return _apiKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_apiKeys);
  }

  // API Keys 列表
  @override
  @JsonKey()
  final String baseUrl;
  // 自定义 Base URL
  final List<String> _models;
  // 自定义 Base URL
  @override
  @JsonKey()
  List<String> get models {
    if (_models is EqualUnmodifiableListView) return _models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_models);
  }

  // 可用模型列表
  final Map<String, dynamic> _modelOverrides;
  // 可用模型列表
  @override
  @JsonKey()
  Map<String, dynamic> get modelOverrides {
    if (_modelOverrides is EqualUnmodifiableMapView) return _modelOverrides;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_modelOverrides);
  }

  // 模型覆盖配置
  @override
  @JsonKey()
  final bool enabled;
  // 是否启用
  @override
  @JsonKey()
  final int selectedKeyIndex;

  @override
  String toString() {
    return 'ProviderConfig(key: $key, name: $name, apiKeys: $apiKeys, baseUrl: $baseUrl, models: $models, modelOverrides: $modelOverrides, enabled: $enabled, selectedKeyIndex: $selectedKeyIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProviderConfigImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._apiKeys, _apiKeys) &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            const DeepCollectionEquality().equals(other._models, _models) &&
            const DeepCollectionEquality().equals(
              other._modelOverrides,
              _modelOverrides,
            ) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.selectedKeyIndex, selectedKeyIndex) ||
                other.selectedKeyIndex == selectedKeyIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    key,
    name,
    const DeepCollectionEquality().hash(_apiKeys),
    baseUrl,
    const DeepCollectionEquality().hash(_models),
    const DeepCollectionEquality().hash(_modelOverrides),
    enabled,
    selectedKeyIndex,
  );

  /// Create a copy of ProviderConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProviderConfigImplCopyWith<_$ProviderConfigImpl> get copyWith =>
      __$$ProviderConfigImplCopyWithImpl<_$ProviderConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProviderConfigImplToJson(this);
  }
}

abstract class _ProviderConfig implements ProviderConfig {
  const factory _ProviderConfig({
    required final String key,
    required final String name,
    final List<String> apiKeys,
    final String baseUrl,
    final List<String> models,
    final Map<String, dynamic> modelOverrides,
    final bool enabled,
    final int selectedKeyIndex,
  }) = _$ProviderConfigImpl;

  factory _ProviderConfig.fromJson(Map<String, dynamic> json) =
      _$ProviderConfigImpl.fromJson;

  @override
  String get key; // 服务商唯一标识（如 'openai', 'anthropic'）
  @override
  String get name; // 显示名称
  @override
  List<String> get apiKeys; // API Keys 列表
  @override
  String get baseUrl; // 自定义 Base URL
  @override
  List<String> get models; // 可用模型列表
  @override
  Map<String, dynamic> get modelOverrides; // 模型覆盖配置
  @override
  bool get enabled; // 是否启用
  @override
  int get selectedKeyIndex;

  /// Create a copy of ProviderConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProviderConfigImplCopyWith<_$ProviderConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
