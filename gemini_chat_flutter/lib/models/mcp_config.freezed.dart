// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mcp_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MCPServerConfig _$MCPServerConfigFromJson(Map<String, dynamic> json) {
  return _MCPServerConfig.fromJson(json);
}

/// @nodoc
mixin _$MCPServerConfig {
  String get id => throw _privateConstructorUsedError; // 唯一标识
  String get name => throw _privateConstructorUsedError; // 服务器名称
  String get command => throw _privateConstructorUsedError; // 启动命令
  List<String> get args => throw _privateConstructorUsedError; // 命令参数
  Map<String, String> get env => throw _privateConstructorUsedError; // 环境变量
  bool get enabled => throw _privateConstructorUsedError; // 是否启用
  String get description => throw _privateConstructorUsedError; // 描述
  List<String> get tools => throw _privateConstructorUsedError; // 可用工具列表
  String get status => throw _privateConstructorUsedError;

  /// Serializes this MCPServerConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MCPServerConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MCPServerConfigCopyWith<MCPServerConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MCPServerConfigCopyWith<$Res> {
  factory $MCPServerConfigCopyWith(
    MCPServerConfig value,
    $Res Function(MCPServerConfig) then,
  ) = _$MCPServerConfigCopyWithImpl<$Res, MCPServerConfig>;
  @useResult
  $Res call({
    String id,
    String name,
    String command,
    List<String> args,
    Map<String, String> env,
    bool enabled,
    String description,
    List<String> tools,
    String status,
  });
}

/// @nodoc
class _$MCPServerConfigCopyWithImpl<$Res, $Val extends MCPServerConfig>
    implements $MCPServerConfigCopyWith<$Res> {
  _$MCPServerConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MCPServerConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? command = null,
    Object? args = null,
    Object? env = null,
    Object? enabled = null,
    Object? description = null,
    Object? tools = null,
    Object? status = null,
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
            command: null == command
                ? _value.command
                : command // ignore: cast_nullable_to_non_nullable
                      as String,
            args: null == args
                ? _value.args
                : args // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            env: null == env
                ? _value.env
                : env // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            enabled: null == enabled
                ? _value.enabled
                : enabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            tools: null == tools
                ? _value.tools
                : tools // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MCPServerConfigImplCopyWith<$Res>
    implements $MCPServerConfigCopyWith<$Res> {
  factory _$$MCPServerConfigImplCopyWith(
    _$MCPServerConfigImpl value,
    $Res Function(_$MCPServerConfigImpl) then,
  ) = __$$MCPServerConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String command,
    List<String> args,
    Map<String, String> env,
    bool enabled,
    String description,
    List<String> tools,
    String status,
  });
}

/// @nodoc
class __$$MCPServerConfigImplCopyWithImpl<$Res>
    extends _$MCPServerConfigCopyWithImpl<$Res, _$MCPServerConfigImpl>
    implements _$$MCPServerConfigImplCopyWith<$Res> {
  __$$MCPServerConfigImplCopyWithImpl(
    _$MCPServerConfigImpl _value,
    $Res Function(_$MCPServerConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MCPServerConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? command = null,
    Object? args = null,
    Object? env = null,
    Object? enabled = null,
    Object? description = null,
    Object? tools = null,
    Object? status = null,
  }) {
    return _then(
      _$MCPServerConfigImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        command: null == command
            ? _value.command
            : command // ignore: cast_nullable_to_non_nullable
                  as String,
        args: null == args
            ? _value._args
            : args // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        env: null == env
            ? _value._env
            : env // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        enabled: null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        tools: null == tools
            ? _value._tools
            : tools // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MCPServerConfigImpl implements _MCPServerConfig {
  const _$MCPServerConfigImpl({
    required this.id,
    required this.name,
    required this.command,
    final List<String> args = const [],
    final Map<String, String> env = const {},
    this.enabled = false,
    this.description = '',
    final List<String> tools = const [],
    this.status = 'stopped',
  }) : _args = args,
       _env = env,
       _tools = tools;

  factory _$MCPServerConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MCPServerConfigImplFromJson(json);

  @override
  final String id;
  // 唯一标识
  @override
  final String name;
  // 服务器名称
  @override
  final String command;
  // 启动命令
  final List<String> _args;
  // 启动命令
  @override
  @JsonKey()
  List<String> get args {
    if (_args is EqualUnmodifiableListView) return _args;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_args);
  }

  // 命令参数
  final Map<String, String> _env;
  // 命令参数
  @override
  @JsonKey()
  Map<String, String> get env {
    if (_env is EqualUnmodifiableMapView) return _env;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_env);
  }

  // 环境变量
  @override
  @JsonKey()
  final bool enabled;
  // 是否启用
  @override
  @JsonKey()
  final String description;
  // 描述
  final List<String> _tools;
  // 描述
  @override
  @JsonKey()
  List<String> get tools {
    if (_tools is EqualUnmodifiableListView) return _tools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tools);
  }

  // 可用工具列表
  @override
  @JsonKey()
  final String status;

  @override
  String toString() {
    return 'MCPServerConfig(id: $id, name: $name, command: $command, args: $args, env: $env, enabled: $enabled, description: $description, tools: $tools, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MCPServerConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.command, command) || other.command == command) &&
            const DeepCollectionEquality().equals(other._args, _args) &&
            const DeepCollectionEquality().equals(other._env, _env) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tools, _tools) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    command,
    const DeepCollectionEquality().hash(_args),
    const DeepCollectionEquality().hash(_env),
    enabled,
    description,
    const DeepCollectionEquality().hash(_tools),
    status,
  );

  /// Create a copy of MCPServerConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MCPServerConfigImplCopyWith<_$MCPServerConfigImpl> get copyWith =>
      __$$MCPServerConfigImplCopyWithImpl<_$MCPServerConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MCPServerConfigImplToJson(this);
  }
}

abstract class _MCPServerConfig implements MCPServerConfig {
  const factory _MCPServerConfig({
    required final String id,
    required final String name,
    required final String command,
    final List<String> args,
    final Map<String, String> env,
    final bool enabled,
    final String description,
    final List<String> tools,
    final String status,
  }) = _$MCPServerConfigImpl;

  factory _MCPServerConfig.fromJson(Map<String, dynamic> json) =
      _$MCPServerConfigImpl.fromJson;

  @override
  String get id; // 唯一标识
  @override
  String get name; // 服务器名称
  @override
  String get command; // 启动命令
  @override
  List<String> get args; // 命令参数
  @override
  Map<String, String> get env; // 环境变量
  @override
  bool get enabled; // 是否启用
  @override
  String get description; // 描述
  @override
  List<String> get tools; // 可用工具列表
  @override
  String get status;

  /// Create a copy of MCPServerConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MCPServerConfigImplCopyWith<_$MCPServerConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
