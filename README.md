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
使用Flutter开发一个应用虽然很快也很简单。但是很多配置很繁，很多插件代码也很浮躁，如果每个应用都需要重写一遍，会很难受。  
所以我决定把业务无关代码剥离出来，做一个可扩展的应用框架，帮助快速构建应用，提供一些开箱即用的功能和用于代码简化的模版。  
由于打包的时候只会打包使用到的代码，所以无需担心功能太多导致太重，使得产物变大。  
以下是这个框架支持的功能，基本上是全平台支持：
- 通知。
  - 本地通知，支持通知池，防止因为设备通知数量限制导致通知无法发出。(功能基于flutter_local_notification)，
  - 应用内横幅通知，支持设置通知显示时间，可手动关闭通知。
- toast。
  - 普通toast
  - 用户可选择的toast(桌面设备使用CupertinoActionDialog，移动设备使用CupertinoActionSheet)
- 菜单选择，桌面设备使用popup menu，移动设备使用CupertinoActionSheet
- 设备信息，支持区分web和客户端，支持平板，支持切换移动模式和桌面模式(功能基于device_info_plus和user_agent_analyzer)
- 简单易用的事件分发(开发中)
- 日志集成(基于logger 开发中)
- 路由集成(基于Get)支持路由跳转监听
- 音频播放集成(基于flutter_sound)
- shared_preferences集成，无需手动初始化
- 自定义主题支持(基于flex_color_scheme)
- 实体类支持，简化实体类和界面开发
- 数据库orm支持(目前仅支持sembast数据库)
- 加强版的GetXController
- 加强版的View
- 一些工具类
- 一些组件
  - 自适应的脚手架(adaptive_scaffold)
  - 可点击组件(clickable)
  - 可拖拽组件(draggable)
  - 树形组件(tree_view)
  - 可拖拽的弹框(dialog)
- 高度自定义的App启动和App配置，简化应用代码。

# 快速开始
## 创建应用
新建应用类继承`App`，实现方法`buildHome`。
```Dart
class MyApp extends App {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget buildHome(BuildContext context) {
    // 返回应用主页
    return Scaffold(
      body: Center(
        child: Clickable(
          onPressed: () {},
          tooltip:"tap it",
          child: const Text('hello flutter'),
        ),
      ),
    );
  }
}
```
## 配置应用
新建应用配置类继承`AppConfig`，需要提供应用名称和应用版本。
```Dart
/// 快速获取应用配置
MyAppCofnig get appConfig => MyAppConfig();
/// 应用配置
class MyAppConfig extends AppConfig {
  /// 单例模式代码
  MyAppConfig._();
  static MyAppConfig? _instance;
  factory MyAppConfig() => _instance ??= MyAppConfig._();

  @override
  String get appName => "example";

  @override
  String get appVersion => "0.0.1";
}
```

## 启动应用
在main方法中使用`AppRunner`传入应用和应用配置来运行应用。
```Dart
void main() {
  /// 传入应用和应用配置来运行应用
  AppHelper.run(const MyApp(), appConfig);
}
```
# 应用`App`
TODO

# 应用配置`AppConfig`
应用配置类`AppConfig`类是一个抽象类，可以随意继承覆盖，添加需要的配置。
主要的作用的是集成所有应用层面的配置，主要包括应用名称、版本、插件的初始化。

## 插件初始化
许多插件，尤其是涉及到平台功能的插件，或者数据库，需要在应用启动的时候初始化。
有时候插件之间还会有依赖。
`AppConfig`提供一个用于按顺序初始化插件的场所。
默认的初始化插件有：
1. 基于shared_preferences的PrefsHelper
2. 基于device_info_plus的DeviceInfoHelper
3. 基于Window_manager的WindowHelper
4. 简化实体编写的entity包及其EntityHelper

可以覆写`registerPlugin`方法决定要初始化哪些插件。
也可以添加自定义插件。

## 自定义启动插件
1. 创建新插件，继承或混入`AppPlugin`。
```Dart
/// 继承AppConfigItem的新设置类
class NewPlugin extends AppPlugin{}

/// 混入AppConfigItem的需要初始化的助手类
class NewHelper with AppPlugin{}
```
2. 为了方便操作，建议将其设置为单例模式。可以使用常规的单例模式代码，也可以使用`framework`提供的`SingletonCache`实现单例模式。(为了简化代码，不过只少写了一行，还行)。
```Dart
  /// 私有化构造方法
  NewPlugin._();

  /// 常规单例模式代码
  static NewPlugin? _instance;
  factory NewPlugin()=>_instance??=NewPlugin._();

  /// 使用SingletonCache实现单例
  factory NewPlugin() => SingletonCache.putIfAbsent(NewPlugin._());
```
3. 实现init方法 init方法中编写插件初始化需要做的事情即可。
```Dart
  @override
  FutureOr<void> init(AppConfig config) {}
```
4. 注册新创建的插件，覆写`AppConfig`中`registerPlugin`方法，注册新添加的插件。
```Dart
class MyAppConfig extends AppConfig{
    /// 省略其他代码
    @override
    FutureOr<void> registerPlugin() {
      // ...省略其他代码
      // 添加新创建的插件
      addPlugin('newPlugin', NewPlugin());
    }
}
```
# 编写页面
TODO
# 使用插件
## 实体类
## 数据库和ORM
## 设备信息
## 日志
## 事件
## 通知
## 路由
## shared_preferences
## 音频
## toast