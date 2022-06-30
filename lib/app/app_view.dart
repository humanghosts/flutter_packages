import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hg_framework/ability/export.dart';
import 'package:hg_framework/app/app_logic.dart';
import 'package:hg_framework/entity/theme_template.dart';

import '../view/util/app_scroll_behavior.dart';
import '../view/util/trick_provider.dart';

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
            ThemeData light = template.toFlexColorThemeLight().toTheme;
            ThemeData dark = template.toFlexColorThemeDark().toTheme;
            ThemeData themeData;
            ThemeMode mode = template.themeMode.value.mode;
            switch (mode) {
              case ThemeMode.system:
                themeData = logic.isDarkMode ? dark : light;
                break;
              case ThemeMode.light:
                themeData = light;
                break;
              case ThemeMode.dark:
                themeData = dark;
                break;
            }
            logic.themeData = themeData;
            return GetMaterialApp(
              scrollBehavior: const AppScrollBehavior(),
              debugShowCheckedModeBanner: false,
              title: logic.config.appName,
              theme: light,
              darkTheme: dark,
              themeMode: mode,
              navigatorObservers: [
                Observer(RouteHelper.observer, ObserverRouting()),
              ],
              home: Stack(
                children: [
                  buildHome(context),
                  buildNotification(),
                ],
              ),
              builder: EasyLoading.init(),
              locale: logic.config.locale,
              supportedLocales: logic.config.supportedLocales,
              localizationsDelegates: logic.config.localizationsDelegates,
            );
          },
        );
      },
    );
  }

  Widget buildHome(BuildContext context);

  /// 构建蒙版
  Widget buildNotification() {
    return Positioned(
      top: 0,
      right: 0,
      child: Obx(() {
        logic.inAppNotificationUpdateFlag.value;
        Map<int, Set<String>> indexKeys = logic.indexNotificationKeys;
        if (indexKeys.isEmpty) return Container();
        // 子通知
        List<Widget> children = [];
        // 通知
        List<int> indexList = indexKeys.keys.toList();
        indexList.sort();
        for (int index in indexList) {
          Set<String>? overlayKeySet = indexKeys[index];
          if (null == overlayKeySet || overlayKeySet.isEmpty) continue;
          for (String overlayKey in overlayKeySet) {
            Widget? overlayWidget = logic.indexNotificationWidget[overlayKey];
            if (null == overlayWidget) continue;

            // 动画控制器
            AnimationController controller = logic.notificationController.putIfAbsent(
                overlayKey,
                () => AnimationController(
                      duration: AppLogic.appConfig.animationConfig.middleAnimationDuration,
                      vsync: SimpleTickerProvider(),
                    ));

            Animation<double> animation =
                Tween<double>(begin: (AppLogic.isDesktop ? 400 : Get.width), end: 0).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
            // 立即播放动画
            Future.delayed(Duration.zero, () => controller.forward());

            children.add(AnimatedBuilder(
              key: ValueKey(overlayKey),
              animation: controller,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(animation.value, 0),
                  child: child,
                );
              },
              child: Dismissible(
                key: ValueKey(overlayKey),
                child: overlayWidget,
                onDismissed: (direction) {
                  logic.closeNotification(overlayKey);
                },
              ),
            ));
          }
        }
        if (children.isEmpty) return Container();
        return Container(
          width: AppLogic.isDesktop ? 400 : Get.width,
          padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
          child: SingleChildScrollView(
            child: Column(children: children),
          ),
        );
      }),
    );
  }
}
