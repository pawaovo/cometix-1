// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProxyConfigImpl _$$ProxyConfigImplFromJson(
  Map<String, dynamic> json,
) => _$ProxyConfigImpl(
  enabled: json['enabled'] as bool? ?? false,
  type: $enumDecodeNullable(_$ProxyTypeEnumMap, json['type']) ?? ProxyType.http,
  host: json['host'] as String? ?? '',
  port: json['port'] as String? ?? '8080',
  username: json['username'] as String? ?? '',
  password: json['password'] as String? ?? '',
);

Map<String, dynamic> _$$ProxyConfigImplToJson(_$ProxyConfigImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'type': _$ProxyTypeEnumMap[instance.type]!,
      'host': instance.host,
      'port': instance.port,
      'username': instance.username,
      'password': instance.password,
    };

const _$ProxyTypeEnumMap = {
  ProxyType.http: 'http',
  ProxyType.https: 'https',
  ProxyType.socks5: 'socks5',
};
