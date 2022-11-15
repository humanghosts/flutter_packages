import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';

export 'app.dart';
export 'config.dart';
export 'logic.dart';
export 'plugin.dart';

/// 应用助手
class AppRunner {
  AppRunner._();

  factory AppRunner() => SingletonCache.putIfAbsent(AppRunner._());

  late final App _app;
  late final AppConfig _config;
  bool _hasRun = false;

  /// 运行应用
  void run(App app, AppConfig config) {
    if (_hasRun) return;
    _app = app;
    _config = config;
    // 监控应用
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        // 初始化
        FutureOr<void> initRun = config.appInit.run();
        if (initRun is Future) await initRun;
        // 运行应用
        runApp(app);
        _hasRun = true;
      },
      (error, stackTrace) {
        LogHelper.wtf(error.toString(), error: error, stackTrace: stackTrace);
      },
      zoneSpecification: const ZoneSpecification(),
    );
  }

  /// 重新构建应用
  Future<void> rebuild() async {
    FutureOr<void> reBuild = _config.appRebuild.run();
    if (reBuild is Future) await reBuild;
  }

  /// 应用控制器
  AppLogic get appLogic => _app.logic;

  /// 应用个配置
  AppConfig get appConfig => _config;
}

/// 快捷获取控制器
AppLogic get appLogic => AppRunner().appLogic;

/// 快捷获取配置
AppConfig get appConfig => AppRunner().appConfig;

/// 主程序
abstract class App extends StatelessWidget with WidgetsBindingObserver {
  /// 应用控制器
  AppLogic get logic => AppLogic();

  const App({Key? key}) : super(key: key);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    logic.didChangeAppLifecycleState(state);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    logic.didChangePlatformBrightness();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    log("didChangeLocales");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLogic>(
      init: logic,
      autoRemove: false,
      initState: (state) {
        WidgetsBinding.instance.addObserver(this);
      },
      dispose: (state) {
        WidgetsBinding.instance.removeObserver(this);
      },
      builder: (logic) {
        logic.config.appBuild.run();
        return Obx(() {
          ThemeHelper().themeUpdateFlag.value;
          return buildApp(context);
        });
      },
    );
  }

  /// 构建应用
  Widget buildApp(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: logic.config.appName,
      theme: ThemeHelper().lightTheme,
      darkTheme: ThemeHelper().darkTheme,
      themeMode: ThemeHelper().themeMode,
      navigatorObservers: [
        Observer(RouteHelper.observer, ObserverRouting()),
      ],
      home: buildHome(context),
      locale: logic.config.locale,
      supportedLocales: logic.config.supportedLocales,
      localizationsDelegates: logic.config.localizationsDelegates,
    );
  }

  /// 构建主页
  Widget buildHome(BuildContext context);
}
