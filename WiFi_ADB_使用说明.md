# WiFi ADB 连接脚本使用说明

## 📁 脚本文件

### 1. `connect_wifi_adb.bat` - 完整功能脚本

**功能**：
- ✅ 首次配对（需要配对码）
- ✅ 直接连接（已配对过）
- ✅ 重新配置持久化连接（切换到 5555 端口）
- ✅ 断开所有连接
- ✅ 查看已连接设备

**使用场景**：
- 首次连接新设备
- 更换 WiFi 网络后重新连接
- 设备 IP 地址变更
- 需要重新配置端口

### 2. `quick_connect.bat` - 快速连接脚本

**功能**：
- 一键连接到 `192.168.10.43:5555`（你的小米手机）

**使用场景**：
- 日常开发快速连接
- IP 地址未变更时使用

---

## 🚀 使用步骤

### 首次配对（第一次使用）

1. **在手机上操作**：
   - 打开 **设置 → 开发者选项 → 无线调试**
   - 点击 **"使用配对码配对设备"**
   - 记录显示的：
     - IP 地址（例如：`192.168.10.43`）
     - 配对端口（例如：`33095`）
     - 配对码（6位数字，例如：`892838`）

2. **运行脚本**：
   - 双击 `connect_wifi_adb.bat`
   - 选择 `[1] 首次配对`
   - 按提示输入 IP、端口和配对码

3. **配对成功后**：
   - 脚本会自动连接设备
   - 显示已连接设备列表

### 日常快速连接

**方法 1：使用快速连接脚本**
```bash
双击 quick_connect.bat
```

**方法 2：使用完整脚本**
```bash
双击 connect_wifi_adb.bat
选择 [2] 直接连接
输入 IP: 192.168.10.43
输入端口: 5555
```

**方法 3：命令行直接连接**
```bash
adb connect 192.168.10.43:5555
```

### 重新配置持久化连接

如果设备重启或端口变更，需要重新配置：

1. 双击 `connect_wifi_adb.bat`
2. 选择 `[3] 重新配置持久化连接`
3. 确认操作
4. 输入设备 IP 地址

---

## 📝 常见问题

### Q1: 连接失败怎么办？

**检查清单**：
- ✅ 手机和电脑在同一 WiFi 网络
- ✅ 手机已开启"无线调试"
- ✅ IP 地址正确（可能会变化）
- ✅ 防火墙未阻止 ADB 连接

**解决方法**：
1. 在手机上查看当前 IP 地址（设置 → 开发者选项 → 无线调试）
2. 使用 `connect_wifi_adb.bat` 重新配对或连接

### Q2: 如何查看设备 IP 地址？

**手机端**：
- 设置 → 开发者选项 → 无线调试
- 页面顶部显示 IP 地址和端口

**电脑端**：
```bash
adb devices -l
```

### Q3: 设备断开连接怎么办？

**原因**：
- WiFi 网络切换
- 手机休眠
- IP 地址变更

**解决**：
- 运行 `quick_connect.bat` 重新连接
- 如果失败，使用 `connect_wifi_adb.bat` 重新配置

### Q4: 如何在不同项目中使用？

**方法 1：复制脚本到项目目录**
```bash
copy D:\ai\cometix\connect_wifi_adb.bat D:\your_project\
copy D:\ai\cometix\quick_connect.bat D:\your_project\
```

**方法 2：添加到系统 PATH**
1. 将 `D:\ai\cometix` 添加到系统环境变量 PATH
2. 在任意目录打开命令行，直接运行：
   ```bash
   connect_wifi_adb.bat
   ```

**方法 3：创建快捷方式**
- 右键脚本 → 发送到 → 桌面快捷方式
- 双击桌面快捷方式即可运行

---

## 🔧 高级用法

### 修改默认 IP 地址

编辑 `quick_connect.bat`，修改第 7 行：
```batch
adb connect 你的IP地址:5555
```

### 同时连接多个设备

```bash
adb connect 192.168.10.43:5555
adb connect 192.168.10.44:5555
adb devices -l
```

### 指定设备运行 Flutter

```bash
flutter run -d 192.168.10.43:5555
```

---

## 📚 相关命令

### ADB 常用命令

```bash
# 查看已连接设备
adb devices -l

# 连接设备
adb connect <IP>:<端口>

# 断开设备
adb disconnect <IP>:<端口>

# 断开所有设备
adb disconnect

# 切换到 TCP/IP 模式
adb tcpip 5555

# 安装 APK
adb install -r app-debug.apk

# 查看日志
adb logcat
```

### Flutter 常用命令

```bash
# 查看设备
flutter devices

# 运行应用
flutter run

# 指定设备运行
flutter run -d 192.168.10.43:5555

# 构建 Debug APK
flutter build apk --debug

# 构建 Release APK
flutter build apk --release

# 热重载（应用运行时按 r）
# 热重启（应用运行时按 R）
```

---

## 🎯 最佳实践

### 开发流程

1. **启动开发环境**：
   ```bash
   # 1. 连接设备
   quick_connect.bat

   # 2. 进入项目目录
   cd D:\ai\cometix\gemini_chat_flutter

   # 3. 运行应用
   flutter run
   ```

2. **日常开发**：
   - 修改代码后按 `r` 热重载
   - 需要重启时按 `R` 热重启
   - 无需重新构建和安装

3. **构建发布版本**：
   ```bash
   flutter build apk --release
   ```

### 省电技巧

- 开发时保持手机屏幕常亮（开发者选项 → 不锁定屏幕）
- 使用 WiFi 调试可以拔掉 USB 线，避免过度充电

---

## 📞 技术支持

如有问题，请检查：
1. ADB 版本：`adb version`
2. Flutter 版本：`flutter --version`
3. 设备连接状态：`adb devices -l`

---

**创建日期**：2025-11-28
**适用设备**：小米 22041216C (Android 14)
**默认 IP**：192.168.10.43:5555
