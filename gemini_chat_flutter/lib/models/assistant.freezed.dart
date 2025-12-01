// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assistant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Assistant _$AssistantFromJson(Map<String, dynamic> json) {
  return _Assistant.fromJson(json);
}

/// @nodoc
mixin _$Assistant {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get systemPrompt => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError; // 模型配置
  String? get modelProvider => throw _privateConstructorUsedError;
  String? get modelId => throw _privateConstructorUsedError; // 参数配置
  double get temperature => throw _privateConstructorUsedError;
  double get topP => throw _privateConstructorUsedError;
  int get contextMessageCount => throw _privateConstructorUsedError; // 输出配置
  bool get streamOutput => throw _privateConstructorUsedError; // 记忆配置
  bool get enableMemory => throw _privateConstructorUsedError;
  bool get useHistoryChat => throw _privateConstructorUsedError;
  List<String> get memories => throw _privateConstructorUsedError; // 助手专属快捷短语
  List<String> get quickPhrases => throw _privateConstructorUsedError;

  /// Serializes this Assistant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Assistant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssistantCopyWith<Assistant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssistantCopyWith<$Res> {
  factory $AssistantCopyWith(Assistant value, $Res Function(Assistant) then) =
      _$AssistantCopyWithImpl<$Res, Assistant>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String systemPrompt,
    bool enabled,
    String? modelProvider,
    String? modelId,
    double temperature,
    double topP,
    int contextMessageCount,
    bool streamOutput,
    bool enableMemory,
    bool useHistoryChat,
    List<String> memories,
    List<String> quickPhrases,
  });
}

/// @nodoc
class _$AssistantCopyWithImpl<$Res, $Val extends Assistant>
    implements $AssistantCopyWith<$Res> {
  _$AssistantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Assistant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? systemPrompt = null,
    Object? enabled = null,
    Object? modelProvider = freezed,
    Object? modelId = freezed,
    Object? temperature = null,
    Object? topP = null,
    Object? contextMessageCount = null,
    Object? streamOutput = null,
    Object? enableMemory = null,
    Object? useHistoryChat = null,
    Object? memories = null,
    Object? quickPhrases = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            systemPrompt: null == systemPrompt
                ? _value.systemPrompt
                : systemPrompt // ignore: cast_nullable_to_non_nullable
                      as String,
            enabled: null == enabled
                ? _value.enabled
                : enabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            modelProvider: freezed == modelProvider
                ? _value.modelProvider
                : modelProvider // ignore: cast_nullable_to_non_nullable
                      as String?,
            modelId: freezed == modelId
                ? _value.modelId
                : modelId // ignore: cast_nullable_to_non_nullable
                      as String?,
            temperature: null == temperature
                ? _value.temperature
                : temperature // ignore: cast_nullable_to_non_nullable
                      as double,
            topP: null == topP
                ? _value.topP
                : topP // ignore: cast_nullable_to_non_nullable
                      as double,
            contextMessageCount: null == contextMessageCount
                ? _value.contextMessageCount
                : contextMessageCount // ignore: cast_nullable_to_non_nullable
                      as int,
            streamOutput: null == streamOutput
                ? _value.streamOutput
                : streamOutput // ignore: cast_nullable_to_non_nullable
                      as bool,
            enableMemory: null == enableMemory
                ? _value.enableMemory
                : enableMemory // ignore: cast_nullable_to_non_nullable
                      as bool,
            useHistoryChat: null == useHistoryChat
                ? _value.useHistoryChat
                : useHistoryChat // ignore: cast_nullable_to_non_nullable
                      as bool,
            memories: null == memories
                ? _value.memories
                : memories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            quickPhrases: null == quickPhrases
                ? _value.quickPhrases
                : quickPhrases // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AssistantImplCopyWith<$Res>
    implements $AssistantCopyWith<$Res> {
  factory _$$AssistantImplCopyWith(
    _$AssistantImpl value,
    $Res Function(_$AssistantImpl) then,
  ) = __$$AssistantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String systemPrompt,
    bool enabled,
    String? modelProvider,
    String? modelId,
    double temperature,
    double topP,
    int contextMessageCount,
    bool streamOutput,
    bool enableMemory,
    bool useHistoryChat,
    List<String> memories,
    List<String> quickPhrases,
  });
}

/// @nodoc
class __$$AssistantImplCopyWithImpl<$Res>
    extends _$AssistantCopyWithImpl<$Res, _$AssistantImpl>
    implements _$$AssistantImplCopyWith<$Res> {
  __$$AssistantImplCopyWithImpl(
    _$AssistantImpl _value,
    $Res Function(_$AssistantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Assistant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? systemPrompt = null,
    Object? enabled = null,
    Object? modelProvider = freezed,
    Object? modelId = freezed,
    Object? temperature = null,
    Object? topP = null,
    Object? contextMessageCount = null,
    Object? streamOutput = null,
    Object? enableMemory = null,
    Object? useHistoryChat = null,
    Object? memories = null,
    Object? quickPhrases = null,
  }) {
    return _then(
      _$AssistantImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        systemPrompt: null == systemPrompt
            ? _value.systemPrompt
            : systemPrompt // ignore: cast_nullable_to_non_nullable
                  as String,
        enabled: null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        modelProvider: freezed == modelProvider
            ? _value.modelProvider
            : modelProvider // ignore: cast_nullable_to_non_nullable
                  as String?,
        modelId: freezed == modelId
            ? _value.modelId
            : modelId // ignore: cast_nullable_to_non_nullable
                  as String?,
        temperature: null == temperature
            ? _value.temperature
            : temperature // ignore: cast_nullable_to_non_nullable
                  as double,
        topP: null == topP
            ? _value.topP
            : topP // ignore: cast_nullable_to_non_nullable
                  as double,
        contextMessageCount: null == contextMessageCount
            ? _value.contextMessageCount
            : contextMessageCount // ignore: cast_nullable_to_non_nullable
                  as int,
        streamOutput: null == streamOutput
            ? _value.streamOutput
            : streamOutput // ignore: cast_nullable_to_non_nullable
                  as bool,
        enableMemory: null == enableMemory
            ? _value.enableMemory
            : enableMemory // ignore: cast_nullable_to_non_nullable
                  as bool,
        useHistoryChat: null == useHistoryChat
            ? _value.useHistoryChat
            : useHistoryChat // ignore: cast_nullable_to_non_nullable
                  as bool,
        memories: null == memories
            ? _value._memories
            : memories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        quickPhrases: null == quickPhrases
            ? _value._quickPhrases
            : quickPhrases // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssistantImpl implements _Assistant {
  const _$AssistantImpl({
    required this.id,
    required this.name,
    this.description,
    this.systemPrompt = '',
    this.enabled = true,
    this.modelProvider,
    this.modelId,
    this.temperature = 0.7,
    this.topP = 1.0,
    this.contextMessageCount = 10,
    this.streamOutput = true,
    this.enableMemory = false,
    this.useHistoryChat = false,
    final List<String> memories = const [],
    final List<String> quickPhrases = const [],
  }) : _memories = memories,
       _quickPhrases = quickPhrases;

  factory _$AssistantImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssistantImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final String systemPrompt;
  @override
  @JsonKey()
  final bool enabled;
  // 模型配置
  @override
  final String? modelProvider;
  @override
  final String? modelId;
  // 参数配置
  @override
  @JsonKey()
  final double temperature;
  @override
  @JsonKey()
  final double topP;
  @override
  @JsonKey()
  final int contextMessageCount;
  // 输出配置
  @override
  @JsonKey()
  final bool streamOutput;
  // 记忆配置
  @override
  @JsonKey()
  final bool enableMemory;
  @override
  @JsonKey()
  final bool useHistoryChat;
  final List<String> _memories;
  @override
  @JsonKey()
  List<String> get memories {
    if (_memories is EqualUnmodifiableListView) return _memories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memories);
  }

  // 助手专属快捷短语
  final List<String> _quickPhrases;
  // 助手专属快捷短语
  @override
  @JsonKey()
  List<String> get quickPhrases {
    if (_quickPhrases is EqualUnmodifiableListView) return _quickPhrases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quickPhrases);
  }

  @override
  String toString() {
    return 'Assistant(id: $id, name: $name, description: $description, systemPrompt: $systemPrompt, enabled: $enabled, modelProvider: $modelProvider, modelId: $modelId, temperature: $temperature, topP: $topP, contextMessageCount: $contextMessageCount, streamOutput: $streamOutput, enableMemory: $enableMemory, useHistoryChat: $useHistoryChat, memories: $memories, quickPhrases: $quickPhrases)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.systemPrompt, systemPrompt) ||
                other.systemPrompt == systemPrompt) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.modelProvider, modelProvider) ||
                other.modelProvider == modelProvider) &&
            (identical(other.modelId, modelId) || other.modelId == modelId) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.topP, topP) || other.topP == topP) &&
            (identical(other.contextMessageCount, contextMessageCount) ||
                other.contextMessageCount == contextMessageCount) &&
            (identical(other.streamOutput, streamOutput) ||
                other.streamOutput == streamOutput) &&
            (identical(other.enableMemory, enableMemory) ||
                other.enableMemory == enableMemory) &&
            (identical(other.useHistoryChat, useHistoryChat) ||
                other.useHistoryChat == useHistoryChat) &&
            const DeepCollectionEquality().equals(other._memories, _memories) &&
            const DeepCollectionEquality().equals(
              other._quickPhrases,
              _quickPhrases,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    systemPrompt,
    enabled,
    modelProvider,
    modelId,
    temperature,
    topP,
    contextMessageCount,
    streamOutput,
    enableMemory,
    useHistoryChat,
    const DeepCollectionEquality().hash(_memories),
    const DeepCollectionEquality().hash(_quickPhrases),
  );

  /// Create a copy of Assistant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssistantImplCopyWith<_$AssistantImpl> get copyWith =>
      __$$AssistantImplCopyWithImpl<_$AssistantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssistantImplToJson(this);
  }
}

abstract class _Assistant implements Assistant {
  const factory _Assistant({
    required final String id,
    required final String name,
    final String? description,
    final String systemPrompt,
    final bool enabled,
    final String? modelProvider,
    final String? modelId,
    final double temperature,
    final double topP,
    final int contextMessageCount,
    final bool streamOutput,
    final bool enableMemory,
    final bool useHistoryChat,
    final List<String> memories,
    final List<String> quickPhrases,
  }) = _$AssistantImpl;

  factory _Assistant.fromJson(Map<String, dynamic> json) =
      _$AssistantImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get systemPrompt;
  @override
  bool get enabled; // 模型配置
  @override
  String? get modelProvider;
  @override
  String? get modelId; // 参数配置
  @override
  double get temperature;
  @override
  double get topP;
  @override
  int get contextMessageCount; // 输出配置
  @override
  bool get streamOutput; // 记忆配置
  @override
  bool get enableMemory;
  @override
  bool get useHistoryChat;
  @override
  List<String> get memories; // 助手专属快捷短语
  @override
  List<String> get quickPhrases;

  /// Create a copy of Assistant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssistantImplCopyWith<_$AssistantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
