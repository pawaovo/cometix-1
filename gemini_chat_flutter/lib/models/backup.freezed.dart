// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WebDavConfig _$WebDavConfigFromJson(Map<String, dynamic> json) {
  return _WebDavConfig.fromJson(json);
}

/// @nodoc
mixin _$WebDavConfig {
  String get url => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  bool get includeChats => throw _privateConstructorUsedError;
  bool get includeFiles => throw _privateConstructorUsedError;

  /// Serializes this WebDavConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebDavConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebDavConfigCopyWith<WebDavConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebDavConfigCopyWith<$Res> {
  factory $WebDavConfigCopyWith(
    WebDavConfig value,
    $Res Function(WebDavConfig) then,
  ) = _$WebDavConfigCopyWithImpl<$Res, WebDavConfig>;
  @useResult
  $Res call({
    String url,
    String username,
    String password,
    String path,
    bool includeChats,
    bool includeFiles,
  });
}

/// @nodoc
class _$WebDavConfigCopyWithImpl<$Res, $Val extends WebDavConfig>
    implements $WebDavConfigCopyWith<$Res> {
  _$WebDavConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebDavConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? username = null,
    Object? password = null,
    Object? path = null,
    Object? includeChats = null,
    Object? includeFiles = null,
  }) {
    return _then(
      _value.copyWith(
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            path: null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String,
            includeChats: null == includeChats
                ? _value.includeChats
                : includeChats // ignore: cast_nullable_to_non_nullable
                      as bool,
            includeFiles: null == includeFiles
                ? _value.includeFiles
                : includeFiles // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WebDavConfigImplCopyWith<$Res>
    implements $WebDavConfigCopyWith<$Res> {
  factory _$$WebDavConfigImplCopyWith(
    _$WebDavConfigImpl value,
    $Res Function(_$WebDavConfigImpl) then,
  ) = __$$WebDavConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String url,
    String username,
    String password,
    String path,
    bool includeChats,
    bool includeFiles,
  });
}

/// @nodoc
class __$$WebDavConfigImplCopyWithImpl<$Res>
    extends _$WebDavConfigCopyWithImpl<$Res, _$WebDavConfigImpl>
    implements _$$WebDavConfigImplCopyWith<$Res> {
  __$$WebDavConfigImplCopyWithImpl(
    _$WebDavConfigImpl _value,
    $Res Function(_$WebDavConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WebDavConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? username = null,
    Object? password = null,
    Object? path = null,
    Object? includeChats = null,
    Object? includeFiles = null,
  }) {
    return _then(
      _$WebDavConfigImpl(
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        path: null == path
            ? _value.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String,
        includeChats: null == includeChats
            ? _value.includeChats
            : includeChats // ignore: cast_nullable_to_non_nullable
                  as bool,
        includeFiles: null == includeFiles
            ? _value.includeFiles
            : includeFiles // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WebDavConfigImpl implements _WebDavConfig {
  const _$WebDavConfigImpl({
    this.url = '',
    this.username = '',
    this.password = '',
    this.path = 'cometix_backups',
    this.includeChats = true,
    this.includeFiles = true,
  });

  factory _$WebDavConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebDavConfigImplFromJson(json);

  @override
  @JsonKey()
  final String url;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final String path;
  @override
  @JsonKey()
  final bool includeChats;
  @override
  @JsonKey()
  final bool includeFiles;

  @override
  String toString() {
    return 'WebDavConfig(url: $url, username: $username, password: $password, path: $path, includeChats: $includeChats, includeFiles: $includeFiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebDavConfigImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.includeChats, includeChats) ||
                other.includeChats == includeChats) &&
            (identical(other.includeFiles, includeFiles) ||
                other.includeFiles == includeFiles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    url,
    username,
    password,
    path,
    includeChats,
    includeFiles,
  );

  /// Create a copy of WebDavConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebDavConfigImplCopyWith<_$WebDavConfigImpl> get copyWith =>
      __$$WebDavConfigImplCopyWithImpl<_$WebDavConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebDavConfigImplToJson(this);
  }
}

abstract class _WebDavConfig implements WebDavConfig {
  const factory _WebDavConfig({
    final String url,
    final String username,
    final String password,
    final String path,
    final bool includeChats,
    final bool includeFiles,
  }) = _$WebDavConfigImpl;

  factory _WebDavConfig.fromJson(Map<String, dynamic> json) =
      _$WebDavConfigImpl.fromJson;

  @override
  String get url;
  @override
  String get username;
  @override
  String get password;
  @override
  String get path;
  @override
  bool get includeChats;
  @override
  bool get includeFiles;

  /// Create a copy of WebDavConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebDavConfigImplCopyWith<_$WebDavConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BackupFileItem _$BackupFileItemFromJson(Map<String, dynamic> json) {
  return _BackupFileItem.fromJson(json);
}

/// @nodoc
mixin _$BackupFileItem {
  @UriConverter()
  Uri get href => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  DateTime? get lastModified => throw _privateConstructorUsedError;

  /// Serializes this BackupFileItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BackupFileItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BackupFileItemCopyWith<BackupFileItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackupFileItemCopyWith<$Res> {
  factory $BackupFileItemCopyWith(
    BackupFileItem value,
    $Res Function(BackupFileItem) then,
  ) = _$BackupFileItemCopyWithImpl<$Res, BackupFileItem>;
  @useResult
  $Res call({
    @UriConverter() Uri href,
    String displayName,
    int size,
    DateTime? lastModified,
  });
}

/// @nodoc
class _$BackupFileItemCopyWithImpl<$Res, $Val extends BackupFileItem>
    implements $BackupFileItemCopyWith<$Res> {
  _$BackupFileItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BackupFileItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? href = null,
    Object? displayName = null,
    Object? size = null,
    Object? lastModified = freezed,
  }) {
    return _then(
      _value.copyWith(
            href: null == href
                ? _value.href
                : href // ignore: cast_nullable_to_non_nullable
                      as Uri,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            size: null == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as int,
            lastModified: freezed == lastModified
                ? _value.lastModified
                : lastModified // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BackupFileItemImplCopyWith<$Res>
    implements $BackupFileItemCopyWith<$Res> {
  factory _$$BackupFileItemImplCopyWith(
    _$BackupFileItemImpl value,
    $Res Function(_$BackupFileItemImpl) then,
  ) = __$$BackupFileItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @UriConverter() Uri href,
    String displayName,
    int size,
    DateTime? lastModified,
  });
}

/// @nodoc
class __$$BackupFileItemImplCopyWithImpl<$Res>
    extends _$BackupFileItemCopyWithImpl<$Res, _$BackupFileItemImpl>
    implements _$$BackupFileItemImplCopyWith<$Res> {
  __$$BackupFileItemImplCopyWithImpl(
    _$BackupFileItemImpl _value,
    $Res Function(_$BackupFileItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BackupFileItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? href = null,
    Object? displayName = null,
    Object? size = null,
    Object? lastModified = freezed,
  }) {
    return _then(
      _$BackupFileItemImpl(
        href: null == href
            ? _value.href
            : href // ignore: cast_nullable_to_non_nullable
                  as Uri,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        size: null == size
            ? _value.size
            : size // ignore: cast_nullable_to_non_nullable
                  as int,
        lastModified: freezed == lastModified
            ? _value.lastModified
            : lastModified // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BackupFileItemImpl implements _BackupFileItem {
  const _$BackupFileItemImpl({
    @UriConverter() required this.href,
    this.displayName = '',
    this.size = 0,
    this.lastModified,
  });

  factory _$BackupFileItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$BackupFileItemImplFromJson(json);

  @override
  @UriConverter()
  final Uri href;
  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey()
  final int size;
  @override
  final DateTime? lastModified;

  @override
  String toString() {
    return 'BackupFileItem(href: $href, displayName: $displayName, size: $size, lastModified: $lastModified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BackupFileItemImpl &&
            (identical(other.href, href) || other.href == href) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, href, displayName, size, lastModified);

  /// Create a copy of BackupFileItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BackupFileItemImplCopyWith<_$BackupFileItemImpl> get copyWith =>
      __$$BackupFileItemImplCopyWithImpl<_$BackupFileItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BackupFileItemImplToJson(this);
  }
}

abstract class _BackupFileItem implements BackupFileItem {
  const factory _BackupFileItem({
    @UriConverter() required final Uri href,
    final String displayName,
    final int size,
    final DateTime? lastModified,
  }) = _$BackupFileItemImpl;

  factory _BackupFileItem.fromJson(Map<String, dynamic> json) =
      _$BackupFileItemImpl.fromJson;

  @override
  @UriConverter()
  Uri get href;
  @override
  String get displayName;
  @override
  int get size;
  @override
  DateTime? get lastModified;

  /// Create a copy of BackupFileItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BackupFileItemImplCopyWith<_$BackupFileItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
