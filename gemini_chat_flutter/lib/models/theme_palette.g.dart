// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_palette.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemePaletteImpl _$$ThemePaletteImplFromJson(Map<String, dynamic> json) =>
    _$ThemePaletteImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      primaryColor: (json['primaryColor'] as num).toInt(),
      accentColor: (json['accentColor'] as num).toInt(),
      isCustom: json['isCustom'] as bool? ?? false,
    );

Map<String, dynamic> _$$ThemePaletteImplToJson(_$ThemePaletteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'primaryColor': instance.primaryColor,
      'accentColor': instance.accentColor,
      'isCustom': instance.isCustom,
    };
