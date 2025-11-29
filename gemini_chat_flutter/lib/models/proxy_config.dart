import 'package:freezed_annotation/freezed_annotation.dart';

part 'proxy_config.freezed.dart';
part 'proxy_config.g.dart';

/// 代理类型
enum ProxyType {
  http,
  https,
  socks5,
}

/// 代理配置
@freezed
class ProxyConfig with _$ProxyConfig {
  const factory ProxyConfig({
    @Default(false) bool enabled, // 是否启用代理
    @Default(ProxyType.http) ProxyType type, // 代理类型
    @Default('') String host, // 代理服务器地址
    @Default('8080') String port, // 代理端口
    @Default('') String username, // 用户名（可选）
    @Default('') String password, // 密码（可选）
  }) = _ProxyConfig;

  factory ProxyConfig.fromJson(Map<String, dynamic> json) =>
      _$ProxyConfigFromJson(json);
}
