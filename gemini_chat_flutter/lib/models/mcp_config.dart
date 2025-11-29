import 'package:freezed_annotation/freezed_annotation.dart';

part 'mcp_config.freezed.dart';
part 'mcp_config.g.dart';

/// MCP 服务器配置
@freezed
class MCPServerConfig with _$MCPServerConfig {
  const factory MCPServerConfig({
    required String id, // 唯一标识
    required String name, // 服务器名称
    required String command, // 启动命令
    @Default([]) List<String> args, // 命令参数
    @Default({}) Map<String, String> env, // 环境变量
    @Default(false) bool enabled, // 是否启用
    @Default('') String description, // 描述
    @Default([]) List<String> tools, // 可用工具列表
    @Default('stopped') String status, // 状态：running, stopped, error
  }) = _MCPServerConfig;

  factory MCPServerConfig.fromJson(Map<String, dynamic> json) =>
      _$MCPServerConfigFromJson(json);
}
