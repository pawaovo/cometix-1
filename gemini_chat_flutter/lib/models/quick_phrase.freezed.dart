// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quick_phrase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuickPhrase _$QuickPhraseFromJson(Map<String, dynamic> json) {
  return _QuickPhrase.fromJson(json);
}

/// @nodoc
mixin _$QuickPhrase {
  String get id => throw _privateConstructorUsedError;
  String get phrase => throw _privateConstructorUsedError;
  String get shortcut => throw _privateConstructorUsedError;

  /// Serializes this QuickPhrase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuickPhrase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickPhraseCopyWith<QuickPhrase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickPhraseCopyWith<$Res> {
  factory $QuickPhraseCopyWith(
    QuickPhrase value,
    $Res Function(QuickPhrase) then,
  ) = _$QuickPhraseCopyWithImpl<$Res, QuickPhrase>;
  @useResult
  $Res call({String id, String phrase, String shortcut});
}

/// @nodoc
class _$QuickPhraseCopyWithImpl<$Res, $Val extends QuickPhrase>
    implements $QuickPhraseCopyWith<$Res> {
  _$QuickPhraseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickPhrase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phrase = null,
    Object? shortcut = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            phrase: null == phrase
                ? _value.phrase
                : phrase // ignore: cast_nullable_to_non_nullable
                      as String,
            shortcut: null == shortcut
                ? _value.shortcut
                : shortcut // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuickPhraseImplCopyWith<$Res>
    implements $QuickPhraseCopyWith<$Res> {
  factory _$$QuickPhraseImplCopyWith(
    _$QuickPhraseImpl value,
    $Res Function(_$QuickPhraseImpl) then,
  ) = __$$QuickPhraseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String phrase, String shortcut});
}

/// @nodoc
class __$$QuickPhraseImplCopyWithImpl<$Res>
    extends _$QuickPhraseCopyWithImpl<$Res, _$QuickPhraseImpl>
    implements _$$QuickPhraseImplCopyWith<$Res> {
  __$$QuickPhraseImplCopyWithImpl(
    _$QuickPhraseImpl _value,
    $Res Function(_$QuickPhraseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuickPhrase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phrase = null,
    Object? shortcut = null,
  }) {
    return _then(
      _$QuickPhraseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        phrase: null == phrase
            ? _value.phrase
            : phrase // ignore: cast_nullable_to_non_nullable
                  as String,
        shortcut: null == shortcut
            ? _value.shortcut
            : shortcut // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickPhraseImpl implements _QuickPhrase {
  const _$QuickPhraseImpl({
    required this.id,
    required this.phrase,
    required this.shortcut,
  });

  factory _$QuickPhraseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickPhraseImplFromJson(json);

  @override
  final String id;
  @override
  final String phrase;
  @override
  final String shortcut;

  @override
  String toString() {
    return 'QuickPhrase(id: $id, phrase: $phrase, shortcut: $shortcut)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickPhraseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phrase, phrase) || other.phrase == phrase) &&
            (identical(other.shortcut, shortcut) ||
                other.shortcut == shortcut));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, phrase, shortcut);

  /// Create a copy of QuickPhrase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickPhraseImplCopyWith<_$QuickPhraseImpl> get copyWith =>
      __$$QuickPhraseImplCopyWithImpl<_$QuickPhraseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickPhraseImplToJson(this);
  }
}

abstract class _QuickPhrase implements QuickPhrase {
  const factory _QuickPhrase({
    required final String id,
    required final String phrase,
    required final String shortcut,
  }) = _$QuickPhraseImpl;

  factory _QuickPhrase.fromJson(Map<String, dynamic> json) =
      _$QuickPhraseImpl.fromJson;

  @override
  String get id;
  @override
  String get phrase;
  @override
  String get shortcut;

  /// Create a copy of QuickPhrase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickPhraseImplCopyWith<_$QuickPhraseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
