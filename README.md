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
使用Flutter开发一个应用虽然很快也很简单。但是很多配置很繁，很多插件代码也很复杂，如果每个应用都需要重写一遍，会很难受。  
所以我决定把业务无关代码剥离出来，做一个可扩展的应用框架，帮助快速构建应用，提供一些开箱即用的功能和用于代码简化的模版。
由于打包的时候只会打包使用到的代码，所以无需担心功能太多导致太重，使得产物变大。
整个框架都是建立在GetX之上的。  
以下是这个框架支持的功能，基本上是全平台支持：
- 通知。
  - 本地通知，支持通知池，防止因为设备通知数量限制导致通知无法发出。(功能基于flutter_local_notification、local_notifier)，
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
  AppRunner().run(const MyApp(), MyAppConfig());
}
```
# 应用`App`
TODO

# 应用配置`AppConfig`
应用配置类`AppConfig`类是一个抽象类，可以随意继承覆盖，添加需要的配置。
主要的作用的是集成所有应用层面的配置，主要包括应用名称、版本、国际化、资源、动画等配置。
提供应用初始化、应用构建、应用重建的插件处理。
所有配置都是基于`getter`方法的，重写简单，不调用没有成本。建议使用单例对象提供配置。

## 应用初始化插件
许多插件，尤其是涉及到平台功能的插件，或者数据库，需要在应用启动的时候初始化。
有时候插件之间还会有依赖。
`AppConfig`提供一个用于按顺序初始化插件的场所——`AppInit`配置，和一些默认实现，可以覆写`appInit`方法来修改默认行为。  
`AppInit`支持注册`AppInitPlugin`类型插件。  

默认注册的插件有：
1. 基于`shared_preferences`的`PrefsHelper`
2. 基于`device_info_plus`的`DeviceInfoHelper`
3. 基于`Window_manager`的`WindowHelper`
4. 简化实体编写的entity包及其`EntityHelper`
5. 暂时只支持`sembast`的数据库和ORM的`DatabaseHelper`
6. 基于`flex_coloc_scheme`的`ThemeHelper`
7. 基于`flutter_local_notifications`和`local_notifier`的`NotificationHelper`
8. 应用控制器`AppLogic`

其中除了`DeviceInfoHelper`和`AppLogic`是必须初始化的之外，其余所有均可以通过覆写`registerPlugin`方法修改。插件注册是顺序初始化，可以指定插件初始化顺序。

## 应用构建插件
有些插件需要在应用构建的时候做一些事情。
`AppConfig`中的`AppBuild`提供了统一管理这些插件的能力。

应用构建的时候将会调用`AppConfig.appBuild.run`，同样可以覆写`AppConfig`中的`appbuild`方法来修改默认行为。

`AppBuild`支持注册`AppBuildPlugin`类型的插件。

默认的构建插件有:
1. 主题插件`ThemeHelper`，主要用于获取当前设备的主题模式。

同样可以通过覆写`registerPlugin`方法修改插件的执行类型和执行顺序。

## 应用重建插件
有时候应用在运行过程中需要刷新所有数据，或者说重新构建。比如同步本地数据库之后，所有构建内容都要基于新的数据进行变化。
`AppConfig`中的`appRebuild`提供了统一管理这些插件的能力。

可以使用`AppRunner().rebuild()`来重新构建应用。

`AppRebuild`支持注册`AppRebuildPlugin`类型的插件。

默认的重建插件有：
1. 数据库插件`DatabaseHelper`
2. 主题插件`ThemeHelper`
3. 通知插件`NotificationHelper`
4. 应用控制器`AppLogic`

同样可以通过覆写`registerPlugin`方法修改插件的执行类型和执行顺序。

## 预置的一些插件
框架中提供了一些预置的插件。详细使用方式可参考文档后面的**使用插件**
插件代码在`ability`包下。

1. 数据库和ORM支持插件`DatabaseHelper`
2. 桌面窗口插件`WindowHelper`
3. 设备信息插件`DeviceInfoHelper`
4. 实体支持插件`EntityHelper`
5. 通知插件`NotificationHelper`
6. 本地存储插件`PrefsHelper`
7. 主题插件`ThemeHelper`
8. 提示插件`ToastHelper`和`OverlayHelper`
9. 音频插件`SoundHelper`
    

## 自定义插件
除了使用预提供的插件之外，也可以添加自定义插件。
1. 创建新插件，继承或混入想要实现的插件功能。   
如果需要初始化，混入`AppInitPlugin`  
如果需要构建回调，混入`AppBuildPlugin`  
如果需要重建回调，混入`AppRebuildPlugin`
```Dart
/// 创建新插件，混入需要的Plugin
class NewHelper with AppInitPlugin, AppBuildPlugin, AppRebuildPlugin{}
```
1. 为了方便操作，建议将插件设置为单例模式。可以使用常规的单例模式代码，也可以使用框架提供的`SingletonCache`实现单例模式。(为了简化代码，不过只少写了一行，还行)。
```Dart
  /// 私有化构造方法
  NewHelper._();

  /// 常规单例模式代码
  static NewHelper? _instance;
  factory NewHelper()=>_instance??=NewHelper._();

  /// 使用SingletonCache实现单例
  factory NewHelper() => SingletonCache.putIfAbsent(NewHelper._());
```
3. 实现混入插件中的方法。
```Dart
  @override
  FutureOr<bool> init(AppConfig config) {}
  @override
  FutureOr<bool> build(AppConfig config) {}
  @override
  FutureOr<bool> rebuild(AppConfig config) {}
```
4. 注册新创建的插件
创建新的插件注册类，继承`AppInit`、`AppBuild`或`AppRebuild`。
重写类中的`registerPlugin`方法，将新的插件使用`addPlugin`注册。
```Dart
/// 创建新的处理类
class MyAppInit extends AppInit {
  MyAppInit._() : super.create();

  factory MyAppInit() => SingletonCache.putIfAbsent(MyAppInit._());

  /// 注册插件
  @override
  FutureOr<void> registerPlugin() async{
    FutureOr superRegister = super.registerPlugin();
    if(superRegister is Future) await superRegister;
    addPlugin("new", NewHelper());
  }
}
/// 覆盖原来的处理类
class MyAppConfig extends AppConfig{
    /// 省略其他代码
    @override
    AppInit get appInit => MyAppInit();
}
```
# 编写页面
TODO
# 使用插件
TODO
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

# TODO
文档完善
cloud功能移除
插件功能独立性完善和测试，插件之间做到互相不依赖依然可以使用。
通用性组件完善