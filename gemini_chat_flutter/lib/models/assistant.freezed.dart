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
  String get avatar => throw _privateConstructorUsedError; // letter
  String? get description => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError; // Basic Settings
  double get temperature => throw _privateConstructorUsedError;
  double get topP => throw _privateConstructorUsedError;
  int get contextMessageCount => throw _privateConstructorUsedError;
  int? get thinkingBudget => throw _privateConstructorUsedError;
  dynamic get maxOutputTokens =>
      throw _privateConstructorUsedError; // 'unlimited' or number
  bool get useAvatar => throw _privateConstructorUsedError;
  bool get streamOutput => throw _privateConstructorUsedError;
  String get chatModel => throw _privateConstructorUsedError; // Prompt Settings
  String get systemPrompt =>
      throw _privateConstructorUsedError; // Memory Settings
  bool get enableMemory => throw _privateConstructorUsedError;
  bool get enableHistoryReference => throw _privateConstructorUsedError;
  List<String> get memories =>
      throw _privateConstructorUsedError; // Quick Phrases
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
    String avatar,
    String? description,
    bool isDefault,
    double temperature,
    double topP,
    int contextMessageCount,
    int? thinkingBudget,
    dynamic maxOutputTokens,
    bool useAvatar,
    bool streamOutput,
    String chatModel,
    String systemPrompt,
    bool enableMemory,
    bool enableHistoryReference,
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
    Object? avatar = null,
    Object? description = freezed,
    Object? isDefault = null,
    Object? temperature = null,
    Object? topP = null,
    Object? contextMessageCount = null,
    Object? thinkingBudget = freezed,
    Object? maxOutputTokens = freezed,
    Object? useAvatar = null,
    Object? streamOutput = null,
    Object? chatModel = null,
    Object? systemPrompt = null,
    Object? enableMemory = null,
    Object? enableHistoryReference = null,
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
            avatar: null == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDefault: null == isDefault
                ? _value.isDefault
                : isDefault // ignore: cast_nullable_to_non_nullable
                      as bool,
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
            thinkingBudget: freezed == thinkingBudget
                ? _value.thinkingBudget
                : thinkingBudget // ignore: cast_nullable_to_non_nullable
                      as int?,
            maxOutputTokens: freezed == maxOutputTokens
                ? _value.maxOutputTokens
                : maxOutputTokens // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            useAvatar: null == useAvatar
                ? _value.useAvatar
                : useAvatar // ignore: cast_nullable_to_non_nullable
                      as bool,
            streamOutput: null == streamOutput
                ? _value.streamOutput
                : streamOutput // ignore: cast_nullable_to_non_nullable
                      as bool,
            chatModel: null == chatModel
                ? _value.chatModel
                : chatModel // ignore: cast_nullable_to_non_nullable
                      as String,
            systemPrompt: null == systemPrompt
                ? _value.systemPrompt
                : systemPrompt // ignore: cast_nullable_to_non_nullable
                      as String,
            enableMemory: null == enableMemory
                ? _value.enableMemory
                : enableMemory // ignore: cast_nullable_to_non_nullable
                      as bool,
            enableHistoryReference: null == enableHistoryReference
                ? _value.enableHistoryReference
                : enableHistoryReference // ignore: cast_nullable_to_non_nullable
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
    String avatar,
    String? description,
    bool isDefault,
    double temperature,
    double topP,
    int contextMessageCount,
    int? thinkingBudget,
    dynamic maxOutputTokens,
    bool useAvatar,
    bool streamOutput,
    String chatModel,
    String systemPrompt,
    bool enableMemory,
    bool enableHistoryReference,
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
    Object? avatar = null,
    Object? description = freezed,
    Object? isDefault = null,
    Object? temperature = null,
    Object? topP = null,
    Object? contextMessageCount = null,
    Object? thinkingBudget = freezed,
    Object? maxOutputTokens = freezed,
    Object? useAvatar = null,
    Object? streamOutput = null,
    Object? chatModel = null,
    Object? systemPrompt = null,
    Object? enableMemory = null,
    Object? enableHistoryReference = null,
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
        avatar: null == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDefault: null == isDefault
            ? _value.isDefault
            : isDefault // ignore: cast_nullable_to_non_nullable
                  as bool,
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
        thinkingBudget: freezed == thinkingBudget
            ? _value.thinkingBudget
            : thinkingBudget // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxOutputTokens: freezed == maxOutputTokens
            ? _value.maxOutputTokens
            : maxOutputTokens // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        useAvatar: null == useAvatar
            ? _value.useAvatar
            : useAvatar // ignore: cast_nullable_to_non_nullable
                  as bool,
        streamOutput: null == streamOutput
            ? _value.streamOutput
            : streamOutput // ignore: cast_nullable_to_non_nullable
                  as bool,
        chatModel: null == chatModel
            ? _value.chatModel
            : chatModel // ignore: cast_nullable_to_non_nullable
                  as String,
        systemPrompt: null == systemPrompt
            ? _value.systemPrompt
            : systemPrompt // ignore: cast_nullable_to_non_nullable
                  as String,
        enableMemory: null == enableMemory
            ? _value.enableMemory
            : enableMemory // ignore: cast_nullable_to_non_nullable
                  as bool,
        enableHistoryReference: null == enableHistoryReference
            ? _value.enableHistoryReference
            : enableHistoryReference // ignore: cast_nullable_to_non_nullable
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
    required this.avatar,
    this.description,
    this.isDefault = false,
    this.temperature = 0.7,
    this.topP = 0.95,
    this.contextMessageCount = 10,
    this.thinkingBudget,
    this.maxOutputTokens = 'unlimited',
    this.useAvatar = true,
    this.streamOutput = true,
    this.chatModel = 'gemini-2.0-flash-exp',
    this.systemPrompt = '',
    this.enableMemory = false,
    this.enableHistoryReference = false,
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
  final String avatar;
  // letter
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isDefault;
  // Basic Settings
  @override
  @JsonKey()
  final double temperature;
  @override
  @JsonKey()
  final double topP;
  @override
  @JsonKey()
  final int contextMessageCount;
  @override
  final int? thinkingBudget;
  @override
  @JsonKey()
  final dynamic maxOutputTokens;
  // 'unlimited' or number
  @override
  @JsonKey()
  final bool useAvatar;
  @override
  @JsonKey()
  final bool streamOutput;
  @override
  @JsonKey()
  final String chatModel;
  // Prompt Settings
  @override
  @JsonKey()
  final String systemPrompt;
  // Memory Settings
  @override
  @JsonKey()
  final bool enableMemory;
  @override
  @JsonKey()
  final bool enableHistoryReference;
  final List<String> _memories;
  @override
  @JsonKey()
  List<String> get memories {
    if (_memories is EqualUnmodifiableListView) return _memories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memories);
  }

  // Quick Phrases
  final List<String> _quickPhrases;
  // Quick Phrases
  @override
  @JsonKey()
  List<String> get quickPhrases {
    if (_quickPhrases is EqualUnmodifiableListView) return _quickPhrases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quickPhrases);
  }

  @override
  String toString() {
    return 'Assistant(id: $id, name: $name, avatar: $avatar, description: $description, isDefault: $isDefault, temperature: $temperature, topP: $topP, contextMessageCount: $contextMessageCount, thinkingBudget: $thinkingBudget, maxOutputTokens: $maxOutputTokens, useAvatar: $useAvatar, streamOutput: $streamOutput, chatModel: $chatModel, systemPrompt: $systemPrompt, enableMemory: $enableMemory, enableHistoryReference: $enableHistoryReference, memories: $memories, quickPhrases: $quickPhrases)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssistantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.topP, topP) || other.topP == topP) &&
            (identical(other.contextMessageCount, contextMessageCount) ||
                other.contextMessageCount == contextMessageCount) &&
            (identical(other.thinkingBudget, thinkingBudget) ||
                other.thinkingBudget == thinkingBudget) &&
            const DeepCollectionEquality().equals(
              other.maxOutputTokens,
              maxOutputTokens,
            ) &&
            (identical(other.useAvatar, useAvatar) ||
                other.useAvatar == useAvatar) &&
            (identical(other.streamOutput, streamOutput) ||
                other.streamOutput == streamOutput) &&
            (identical(other.chatModel, chatModel) ||
                other.chatModel == chatModel) &&
            (identical(other.systemPrompt, systemPrompt) ||
                other.systemPrompt == systemPrompt) &&
            (identical(other.enableMemory, enableMemory) ||
                other.enableMemory == enableMemory) &&
            (identical(other.enableHistoryReference, enableHistoryReference) ||
                other.enableHistoryReference == enableHistoryReference) &&
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
    avatar,
    description,
    isDefault,
    temperature,
    topP,
    contextMessageCount,
    thinkingBudget,
    const DeepCollectionEquality().hash(maxOutputTokens),
    useAvatar,
    streamOutput,
    chatModel,
    systemPrompt,
    enableMemory,
    enableHistoryReference,
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
    required final String avatar,
    final String? description,
    final bool isDefault,
    final double temperature,
    final double topP,
    final int contextMessageCount,
    final int? thinkingBudget,
    final dynamic maxOutputTokens,
    final bool useAvatar,
    final bool streamOutput,
    final String chatModel,
    final String systemPrompt,
    final bool enableMemory,
    final bool enableHistoryReference,
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
  String get avatar; // letter
  @override
  String? get description;
  @override
  bool get isDefault; // Basic Settings
  @override
  double get temperature;
  @override
  double get topP;
  @override
  int get contextMessageCount;
  @override
  int? get thinkingBudget;
  @override
  dynamic get maxOutputTokens; // 'unlimited' or number
  @override
  bool get useAvatar;
  @override
  bool get streamOutput;
  @override
  String get chatModel; // Prompt Settings
  @override
  String get systemPrompt; // Memory Settings
  @override
  bool get enableMemory;
  @override
  bool get enableHistoryReference;
  @override
  List<String> get memories; // Quick Phrases
  @override
  List<String> get quickPhrases;

  /// Create a copy of Assistant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssistantImplCopyWith<_$AssistantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
