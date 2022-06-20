import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hg_framework/ability/export.dart';
import 'package:hg_framework/app/app_logic.dart';
import 'package:hg_framework/entity/theme_template.dart';

import '../view/util/app_scroll_behavior.dart';

/// 主程序
abstract class App extends StatelessWidget with WidgetsBindingObserver {
  AppLogic get logic => AppLogic.instance;

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
    return LayoutBuilder(
      builder: (context, constraints) {
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
            ThemeTemplate template = logic.themeConfig.templateInUse.value;
            return GetMaterialApp(
              scrollBehavior: const AppScrollBehavior(),
              debugShowCheckedModeBanner: false,
              title: logic.config.appName,
              theme: template.toFlexColorThemeLight().toTheme,
              darkTheme: template.toFlexColorThemeDark().toTheme,
              themeMode: template.themeMode.value.mode,
              navigatorObservers: [
                Observer(RouteHelper.observer, ObserverRouting()),
              ],
              home: buildHome(),
              builder: EasyLoading.init(),
              locale: const Locale('zh', 'CN'),
              supportedLocales: const <Locale>[Locale('zh', 'CN')],
              localizationsDelegates: const [
                // 本地化的代理类
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            );
          },
        );
      },
    );
  }

  Widget buildHome();
}
