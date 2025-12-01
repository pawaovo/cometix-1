// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_palette.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ThemePalette _$ThemePaletteFromJson(Map<String, dynamic> json) {
  return _ThemePalette.fromJson(json);
}

/// @nodoc
mixin _$ThemePalette {
  String get id => throw _privateConstructorUsedError; // 色板唯一标识
  String get name => throw _privateConstructorUsedError; // 色板名称
  int get primaryColor =>
      throw _privateConstructorUsedError; // 主色（存储为 int，方便序列化）
  int get accentColor => throw _privateConstructorUsedError; // 强调色
  bool get isCustom => throw _privateConstructorUsedError;

  /// Serializes this ThemePalette to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThemePalette
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemePaletteCopyWith<ThemePalette> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemePaletteCopyWith<$Res> {
  factory $ThemePaletteCopyWith(
    ThemePalette value,
    $Res Function(ThemePalette) then,
  ) = _$ThemePaletteCopyWithImpl<$Res, ThemePalette>;
  @useResult
  $Res call({
    String id,
    String name,
    int primaryColor,
    int accentColor,
    bool isCustom,
  });
}

/// @nodoc
class _$ThemePaletteCopyWithImpl<$Res, $Val extends ThemePalette>
    implements $ThemePaletteCopyWith<$Res> {
  _$ThemePaletteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemePalette
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? primaryColor = null,
    Object? accentColor = null,
    Object? isCustom = null,
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
            primaryColor: null == primaryColor
                ? _value.primaryColor
                : primaryColor // ignore: cast_nullable_to_non_nullable
                      as int,
            accentColor: null == accentColor
                ? _value.accentColor
                : accentColor // ignore: cast_nullable_to_non_nullable
                      as int,
            isCustom: null == isCustom
                ? _value.isCustom
                : isCustom // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ThemePaletteImplCopyWith<$Res>
    implements $ThemePaletteCopyWith<$Res> {
  factory _$$ThemePaletteImplCopyWith(
    _$ThemePaletteImpl value,
    $Res Function(_$ThemePaletteImpl) then,
  ) = __$$ThemePaletteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    int primaryColor,
    int accentColor,
    bool isCustom,
  });
}

/// @nodoc
class __$$ThemePaletteImplCopyWithImpl<$Res>
    extends _$ThemePaletteCopyWithImpl<$Res, _$ThemePaletteImpl>
    implements _$$ThemePaletteImplCopyWith<$Res> {
  __$$ThemePaletteImplCopyWithImpl(
    _$ThemePaletteImpl _value,
    $Res Function(_$ThemePaletteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThemePalette
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? primaryColor = null,
    Object? accentColor = null,
    Object? isCustom = null,
  }) {
    return _then(
      _$ThemePaletteImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        primaryColor: null == primaryColor
            ? _value.primaryColor
            : primaryColor // ignore: cast_nullable_to_non_nullable
                  as int,
        accentColor: null == accentColor
            ? _value.accentColor
            : accentColor // ignore: cast_nullable_to_non_nullable
                  as int,
        isCustom: null == isCustom
            ? _value.isCustom
            : isCustom // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ThemePaletteImpl implements _ThemePalette {
  const _$ThemePaletteImpl({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.accentColor,
    this.isCustom = false,
  });

  factory _$ThemePaletteImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemePaletteImplFromJson(json);

  @override
  final String id;
  // 色板唯一标识
  @override
  final String name;
  // 色板名称
  @override
  final int primaryColor;
  // 主色（存储为 int，方便序列化）
  @override
  final int accentColor;
  // 强调色
  @override
  @JsonKey()
  final bool isCustom;

  @override
  String toString() {
    return 'ThemePalette(id: $id, name: $name, primaryColor: $primaryColor, accentColor: $accentColor, isCustom: $isCustom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemePaletteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.accentColor, accentColor) ||
                other.accentColor == accentColor) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, primaryColor, accentColor, isCustom);

  /// Create a copy of ThemePalette
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemePaletteImplCopyWith<_$ThemePaletteImpl> get copyWith =>
      __$$ThemePaletteImplCopyWithImpl<_$ThemePaletteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemePaletteImplToJson(this);
  }
}

abstract class _ThemePalette implements ThemePalette {
  const factory _ThemePalette({
    required final String id,
    required final String name,
    required final int primaryColor,
    required final int accentColor,
    final bool isCustom,
  }) = _$ThemePaletteImpl;

  factory _ThemePalette.fromJson(Map<String, dynamic> json) =
      _$ThemePaletteImpl.fromJson;

  @override
  String get id; // 色板唯一标识
  @override
  String get name; // 色板名称
  @override
  int get primaryColor; // 主色（存储为 int，方便序列化）
  @override
  int get accentColor; // 强调色
  @override
  bool get isCustom;

  /// Create a copy of ThemePalette
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemePaletteImplCopyWith<_$ThemePaletteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
