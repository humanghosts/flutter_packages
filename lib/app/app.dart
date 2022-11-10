import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';

import 'config/app.dart';

/// 应用助手
class AppRunner {
  /// 运行应用
  static run(App app, AppConfig config) {
    // 监控应用
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await config.setConfig();
        await config.init();
        runApp(app);
      },
      (error, stackTrace) {
        LogHelper.wtf(error.toString(), error: error, stackTrace: stackTrace);
      },
      zoneSpecification: const ZoneSpecification(),
    );
  }
}

/// 主程序
abstract class App extends StatelessWidget with WidgetsBindingObserver {
  AppLogic get logic => appLogic;

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
        logic.onWidgetBuild(context);
        return buildApp(context);
      },
    );
  }

  Widget buildApp(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: logic.config.appName,
      theme: logic.lightTheme,
      darkTheme: logic.darkTheme,
      themeMode: logic.themeMode,
      navigatorObservers: [
        Observer(RouteHelper.observer, ObserverRouting()),
      ],
      home: buildHome(context),
      locale: logic.config.locale,
      supportedLocales: logic.config.supportedLocales,
      localizationsDelegates: logic.config.localizationsDelegates,
    );
  }

  Widget buildHome(BuildContext context);
}
