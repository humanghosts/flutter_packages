import 'dart:developer';

import 'package:flutter/material.dart';
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

  /// 构建蒙版
  Widget buildOverlay() {
    return Obx(() {
      debugPrint("蒙版更新次数${logic.overlayUpdateFlag.value}");
      Map<int, Set<String>> indexOverlay = logic.indexOverlay;
      if (indexOverlay.isEmpty) return Container();
      // stack子组件
      List<Widget> children = [];
      // 蒙版顺讯
      List<int> indexList = indexOverlay.keys.toList();
      indexList.sort();
      for (int index in indexList) {
        Set<String>? overlayKeySet = indexOverlay[index];
        if (null == overlayKeySet || overlayKeySet.isEmpty) continue;
        for (String overlayKey in overlayKeySet) {
          Widget? overlayWidget = logic.overlayWidget[overlayKey];
          if (null == overlayWidget) continue;
          children.add(overlayWidget);
        }
      }
      if (children.isEmpty) return Container();
      return Stack(children: children);
    });
  }
}
