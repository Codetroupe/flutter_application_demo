# flutter_application_demo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Github Actions
 
> 查询所有分支获取commitId
```bash
git branch -v -a
```

> 查询所有tag
```bash
git tag
```

> 基于commitId创建tag
```bash
git tag v1.0.1 commitId
```

> 删除tag
```bash
git tag -d v1.0.1
```

> 推送tag到仓库触发构建(内容在yml文件)
```bash
git push origin v1.0.1 
```


## Builder
```bash
flutter build windows
```
```bash
flutter build apk
```
```bash
flutter build appbundle
```
```bash
flutter build ios
```
```bash
flutter build web
```
```bash
flutter build macos
```
```bash
flutter build linux
```

- --release: 构建发布版本的应用，而不是调试版本。
- --target-platform: 指定目标平台，例如android-arm, android-arm64, ios, web, windows, macos, linux-x64等。
- --build-number: 设置构建号，这对于追踪特定构建很有用。
- --dart-define: 定义编译时常量，格式为KEY=VALUE。
- --split-per-abi: 针对Android，为每个ABI创建单独的APK。
- --obfuscate: 混淆Dart代码（仅用于Android和iOS）。
- --tree-shake-icons: 移除未使用的图标（仅用于Android和iOS）。

