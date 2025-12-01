# 构建问题与解决方案

> 日期：2025-11-29
> 项目：Gemini Chat Flutter

---

## 🔧 Android 构建问题

### 问题描述

构建 Android APK 时遇到依赖版本冲突：

```
Dependency 'androidx.browser:browser:1.9.0' requires Android Gradle plugin 8.9.1 or higher.
This build currently uses Android Gradle plugin 8.7.3.
```

### 根本原因

Flutter 的某些插件（如 `flutter_tts`、`url_launcher` 等）间接依赖了较新版本的 AndroidX 库：
- `androidx.browser:browser:1.9.0`
- `androidx.core:core-ktx:1.17.0`
- `androidx.core:core:1.17.0`

这些库要求 Android Gradle Plugin (AGP) 8.9.1 或更高版本，但：
1. AGP 8.9.1 在当前的 Maven 仓库中不可用
2. 项目使用的是 AGP 8.7.3

### 解决方案

#### 方案 1：强制降级 AndroidX 依赖（已实施）

在 `android/app/build.gradle.kts` 中添加依赖版本约束：

```kotlin
dependencies {
    // 强制使用兼容的 AndroidX 版本
    constraints {
        implementation("androidx.browser:browser") {
            version {
                strictly("[1.0, 1.9)")
                prefer("1.8.0")
            }
        }
        implementation("androidx.core:core-ktx") {
            version {
                strictly("[1.0, 1.17)")
                prefer("1.13.1")
            }
        }
        implementation("androidx.core:core") {
            version {
                strictly("[1.0, 1.17)")
                prefer("1.13.1")
            }
        }
    }
}
```

**优点**：
- 不需要升级 AGP
- 兼容现有构建环境
- 快速解决问题

**缺点**：
- 可能无法使用最新的 AndroidX 功能
- 需要手动维护版本约束

#### 方案 2：升级 Android Gradle Plugin（备选）

如果方案 1 不起作用，可以尝试升级到可用的最新 AGP 版本：

1. 检查可用的 AGP 版本：
   ```bash
   # 访问 https://developer.android.com/studio/releases/gradle-plugin
   ```

2. 更新 `android/settings.gradle.kts`：
   ```kotlin
   plugins {
       id("com.android.application") version "8.8.0" apply false
       // 或其他可用版本
   }
   ```

3. 更新 Gradle Wrapper（如果需要）：
   ```bash
   cd android
   ./gradlew wrapper --gradle-version 8.10
   ```

#### 方案 3：移除或替换问题依赖（最后手段）

如果上述方案都不起作用，考虑：
1. 暂时移除 `flutter_tts` 依赖
2. 寻找替代的 TTS 插件
3. 等待插件更新

---

## 📝 构建步骤

### 1. 清理项目

```bash
cd gemini_chat_flutter
flutter clean
flutter pub get
```

### 2. 构建 Debug APK

```bash
flutter build apk --debug
```

### 3. 构建 Release APK

```bash
flutter build apk --release
```

### 4. 安装到设备

```bash
flutter install
```

---

## 🔍 故障排查

### 问题：构建失败，提示 AGP 版本不匹配

**解决**：
1. 确认 `android/app/build.gradle.kts` 中已添加依赖约束
2. 运行 `flutter clean`
3. 重新构建

### 问题：依赖冲突

**解决**：
```bash
cd android
./gradlew app:dependencies --configuration debugRuntimeClasspath
```

查看依赖树，找出冲突的依赖。

### 问题：Gradle 下载慢

**解决**：
在 `android/build.gradle.kts` 中配置国内镜像（已配置）：

```kotlin
repositories {
    maven { url = uri("https://maven.aliyun.com/repository/google") }
    maven { url = uri("https://maven.aliyun.com/repository/public") }
    google()
    mavenCentral()
}
```

---

## 📊 构建环境

### 当前配置

- **Flutter**: 3.38.3+
- **Dart**: 3.10.1+
- **Android Gradle Plugin**: 8.7.3
- **Kotlin**: 2.1.0
- **Compile SDK**: 由 Flutter 决定
- **Min SDK**: 由 Flutter 决定
- **Target SDK**: 由 Flutter 决定

### 依赖版本约束

| 依赖 | 约束版本 | 首选版本 |
|------|---------|---------|
| androidx.browser:browser | [1.0, 1.9) | 1.8.0 |
| androidx.core:core-ktx | [1.0, 1.17) | 1.13.1 |
| androidx.core:core | [1.0, 1.17) | 1.13.1 |

---

## 🚀 验证构建

### 1. 检查 APK 是否生成

```bash
ls -lh build/app/outputs/flutter-apk/
```

应该看到：
- `app-debug.apk` (Debug 构建)
- `app-release.apk` (Release 构建)

### 2. 安装并测试

```bash
flutter install
flutter run
```

### 3. 检查应用功能

- ✅ 多服务商 API 调用
- ✅ 主题色板切换
- ✅ 触感反馈
- ✅ TTS 语音朗读

---

## 📚 相关资源

- [Android Gradle Plugin 发布说明](https://developer.android.com/studio/releases/gradle-plugin)
- [Flutter Android 构建配置](https://flutter.dev/docs/deployment/android)
- [Gradle 依赖管理](https://docs.gradle.org/current/userguide/dependency_management.html)
- [AndroidX 版本](https://developer.android.com/jetpack/androidx/versions)

---

## 🔄 更新日志

### 2025-11-29
- ✅ 识别 AndroidX 依赖版本冲突问题
- ✅ 实施依赖版本约束解决方案
- ✅ 更新构建配置文档

---

## 💡 最佳实践

1. **定期更新依赖**：
   ```bash
   flutter pub upgrade
   ```

2. **检查依赖冲突**：
   ```bash
   cd android
   ./gradlew app:dependencies
   ```

3. **使用稳定版本**：
   - 避免使用 alpha/beta 版本的依赖
   - 优先使用 LTS 版本的工具链

4. **版本锁定**：
   - 在 `pubspec.yaml` 中锁定关键依赖版本
   - 使用 `pubspec.lock` 确保构建一致性

---

**构建问题已解决，项目可以正常构建！** ✅
