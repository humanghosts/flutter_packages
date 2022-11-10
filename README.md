<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

帮助快速构建应用，提供一些开箱即用的功能。
- 通知
  - 本地通知(基于flutter_local_notification)，支持通知池，防止因为设备通知数量限制导致通知无法发出
  - 应用内通知(支持设置通知显示时间，可手动关闭通知)
- toast
  - toast
  - 可选择的toast(桌面设备使用CupertinoActionDialog，移动设备使用CupertinoActionSheet)
- 平台化菜单(桌面设备使用popup menu，移动设备使用CupertinoActionSheet)
- 设备信息(支持区分web和客户端，支持平板，基于device_info_plus和user_agent_analyzer)
- 简单易用的事件分发
- 日志集成(基于logger)
- 路由集成(基于Get)
  - 路由跳转
  - 路由跳转监听
- 音频播放集成(基于flutter_sound)
- shared_preferences集成，无需手动初始化
- 自定义主题支持(基于flex_color_scheme)
- 数据库orm支持(基于hg_orm,hg_entity,sembast)
- 加强版的GetXController
- 加强版的View
- 一些工具类
- 一些组件
  - 自适应的脚手架(adaptive_scaffold)
  - 可点击组件(clickable)
  - 可拖拽组件(draggable)
  - 树形组件(tree_view)
  - 可拖拽的弹框(dialog)
  - 等
- 高度自定义的App启动和App配置



##


## Getting started

```dart
class MyAppConfig extends AppConfig {
  MyAppConfig._();

  static MyAppConfig? _instance;

  static MyAppConfig get instance => _instance ??= MyAppConfig._();

  @override
  String get appName => "样例";

  @override
  String get appVersion => "1";

  @override
  DatabaseConfig get databaseConfig => SembastConfig(path: 'example_hg_framework.db');
}

void main() {
  AppHelper.run(const MyApp(), MyAppConfig.instance);
}

class MyApp extends App {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget buildHome(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Clickable(
          onPressed: () {},
          tooltip:"tap it",
          child: const Text('hello'),
        ),
      ),
    );
  }
}
```

## 应用启动配置扩展
1. 创建新的配置类，继承或混入`AppConfigItem`。
```Dart
/// 继承AppConfigItem的新设置类
class NewConfigItem extends AppConfigItem{}

/// 混入AppConfigItem的需要初始化的助手类
class NewHelperNeedInit with AppConfigItem{}
```
2. 为了方便操作，将其设置为单例模式。可以使用常规的单例模式代码，也可以使用`framework`提供的`SingletonCache`实现单例模式。(为了简化代码，不过只少写了一行，还行)。
```Dart
  /// 私有化构造方法
  NewConfigItem._();

  /// 常规单例模式代码
  static NewConfigItem? _instance;
  factory NewConfigItem()=>_instance??=NewConfigItem._();

  /// 使用SingletonCache实现单例
  factory NewConfigItem() => SingletonCache.putIfAbsent(NewConfigItem._());
```
3. 实现init方法
```Dart
  @override
  FutureOr<void> init() {}
```