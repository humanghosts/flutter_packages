import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:window_manager/window_manager.dart';

/// 主题监听器
abstract class ThemeHelper {
  /// 主题服务
  ThemeConfigService get themeConfigService => ThemeConfigService.instance;

  /// 主题模板服务
  ThemeTemplateService get themeTemplateService => ThemeTemplateService.instance;

  /// 当前主题配置
  ThemeConfig themeConfig = ThemeConfig();

  /// 当前系统亮度
  Brightness brightness = Brightness.light;

  /// 当前主题模板
  ThemeTemplate get themeTemplate => themeConfig.templateInUse.value;

  /// 当前主题数据
  late ThemeData themeData;

  late ThemeData lightTheme;
  late ThemeData darkTheme;
  late ThemeMode themeMode;

  /// 更新标识
  RxInt themeUpdateFlag = 0.obs;

  /// 主题更新监听器
  final Map<String, VoidCallback> _themeListener = {};

  /// 是否浅色模式
  bool get isLightMode => brightness == Brightness.light;

  /// 是否深色模式
  bool get isDarkMode => brightness == Brightness.dark;

  /// 监听主题更新
  void listenThemeUpdate(String key, VoidCallback callback) => _themeListener[key] = callback;

  /// 移除主题更新监听器
  void removeThemeUpdateListener(String key) => _themeListener.remove(key);

  /// 应用渲染时调用
  void _onWidgetBuildTheme() {
    brightness = window.platformBrightness;
    _setArgs();
  }

  /// 设置主题参数
  void _setArgs() {
    lightTheme = themeTemplate.toFlexColorThemeLight().toTheme;
    darkTheme = themeTemplate.toFlexColorThemeDark().toTheme;
    themeMode = themeTemplate.themeMode.value.mode;
    switch (themeMode) {
      case ThemeMode.system:
        themeData = isLightMode ? lightTheme : darkTheme;
        break;
      case ThemeMode.light:
        themeData = lightTheme;
        break;
      case ThemeMode.dark:
        themeData = darkTheme;
        break;
    }
    SystemChrome.setSystemUIOverlayStyle(
      FlexColorScheme.themedSystemNavigationBar(
        Get.context,
        systemNavBarStyle: themeTemplate.sysNavBarStyle.value.style,
        useDivider: themeTemplate.useSysNavDivider.value,
        opacity: themeTemplate.sysNavBarOpacity.value,
      ),
    );
  }

  /// 查询主题配置 在应用启动时候初始化完数据库调用
  Future<void> _onAppInitTheme() async {
    themeConfig = await themeConfigService.find();
  }

  /// 保存主题配置
  Future<void> saveConfig() async {
    await themeConfigService.save(themeConfig);
  }

  /// 更新主题
  Future<void> updateThemeTemplate(ThemeTemplate template) async {
    String id = template.id.value;
    String inUseId = themeConfig.templateInUse.value.id.value;
    await themeTemplateService.save(template);
    if (id == inUseId) themeChangedReRender();
  }

  /// 删除主题
  Future<bool> removeThemeTemplate(ThemeTemplate template) async {
    String id = template.id.value;
    String inUseId = themeConfig.templateInUse.value.id.value;
    if (id == inUseId) {
      ToastHelper.inAppNotification(
        leading: Icon(Icons.sms_failed_outlined, color: appLogic.themeData.errorColor),
        title: "无法删除",
        message: "主题${template.name.value ?? "未命名"}正在使用中",
      );
      return false;
    }
    await ThemeConfigService.instance.transaction((tx) async {
      await themeTemplateService.remove(template, tx: tx);
      themeConfig.templateList.removeWhere((element) => element.id.value == template.id.value);
      themeConfigService.save(themeConfig);
    });
    return true;
  }

  /// 使用主题
  Future<void> useThemeTemplate(ThemeTemplate template) async {
    themeConfig.templateInUse.value = template;
    await themeConfigService.save(themeConfig);
    themeChangedReRender();
  }

  /// 添加一个主题
  /// [addToUse] 表示是否同时使用这个主题
  Future<void> addThemeTemplate(ThemeTemplate template, {bool addToUse = false}) async {
    Set<String> templateIdMap = themeConfig.templateList.value.map((e) => e.id.value).toSet();
    String id = template.id.value;
    if (templateIdMap.contains(id)) return;
    themeConfig.templateList.add(template);
    if (addToUse) {
      await useThemeTemplate(template);
    } else {
      await themeConfigService.save(themeConfig);
    }
  }

  /// 重新根据主题渲染
  void themeChangedReRender() {
    themeUpdateFlag++;
    _setArgs();
    for (var value in _themeListener.values) {
      try {
        value();
      } catch (e) {
        LogHelper.error(e.toString());
      }
    }
  }
}

/// 应用生命周期监听器
abstract class AppLifecycleHelper {
  /// 当前app状态
  AppLifecycleState appLifecycleState = AppLifecycleState.resumed;

  /// 生命周期监听器
  final Map<String, ValueChanged<AppLifecycleState>> _appLifecycleListener = {};

  /// 监听生命周期改变
  void listenAppLifecycleUpdate(String key, ValueChanged<AppLifecycleState> callback) => _appLifecycleListener[key] = callback;

  /// 移除监听
  void removeAppLifecycleListener(String key) => _appLifecycleListener.remove(key);
}

/// 蒙版助手
abstract class OverlayHelper {
  /// 蒙版关闭缓存
  Map<String, VoidCallback> closeFuncMap = {};

  /// 显示加载
  void showLoading(String key, {Widget? message, bool onlyDebug = false}) {
    if (onlyDebug && kDebugMode) return;
    showOverlay(
      key: key,
      widget: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitCircle(color: appLogic.themeData.iconTheme.color),
            if (null != message) message,
          ],
        ),
      ),
    );
  }

  /// 关闭加载
  void closeLoading(String key) => closeOverlay(key);

  /// 显示蒙版 index越高越靠上
  void showOverlay({required String key, required Widget widget, Widget? background}) {
    if (closeFuncMap.containsKey(key)) return;
    ToastHelper.overlayBuilder(
      (context) {
        return widget;
      },
      backgroundBuilder: (context) {
        return background ??
            BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
              child: const SizedBox.shrink(),
            );
      },
      close: (action) => closeFuncMap[key] = action,
    );
  }

  /// 关闭蒙版
  void closeOverlay(String key) {
    closeFuncMap[key]?.call();
    closeFuncMap.remove(key);
  }
}

/// 应用内通知助手
abstract class InAppNotificationHelper {
  /// 通知更新标识
  RxInt inAppNotificationUpdateFlag = 0.obs;

  /// ID:组件
  Map<String, Widget> indexNotificationWidget = {};

  /// 顺序:ID_SET
  Map<int, Set<String>> indexNotificationKeys = {};

  /// ID:顺序
  Map<String, int> notificationKeyIndex = {};

  /// 动画控制器
  Map<String, AnimationController> notificationController = {};

  /// 通知
  void showNotification(String key, Widget widget, [int? index]) {
    int order = index ?? indexNotificationKeys.length;
    indexNotificationWidget[key] = widget;
    notificationKeyIndex[key] = order;
    indexNotificationKeys.putIfAbsent(order, () => {}).add(key);
    if (indexNotificationWidget.length == 1) {
      appLogic.showOverlay(
        key: "in_app_notification",
        widget: Obx(() {
          inAppNotificationUpdateFlag.value;
          Map<int, Set<String>> indexKeys = indexNotificationKeys;
          if (indexKeys.isEmpty) return const SizedBox.shrink();
          // 子通知
          List<Widget> children = [];
          // 通知
          List<int> indexList = indexKeys.keys.toList();
          indexList.sort();
          for (int index in indexList) {
            Set<String>? overlayKeySet = indexKeys[index];
            if (null == overlayKeySet || overlayKeySet.isEmpty) continue;
            for (String overlayKey in overlayKeySet) {
              Widget? overlayWidget = indexNotificationWidget[overlayKey];
              if (null == overlayWidget) continue;

              // 动画控制器
              AnimationController controller = notificationController.putIfAbsent(
                overlayKey,
                () => AnimationController(
                  duration: appConfig.animationConfig.middleAnimationDuration,
                  vsync: SimpleTickerProvider(),
                ),
              );

              Animation<double> animation = Tween<double>(begin: (DeviceInfoHelper.isDesktop ? 400 : Get.width), end: 0).animate(CurvedAnimation(
                parent: controller,
                curve: Curves.easeOut,
              ));
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
                    closeNotification(overlayKey);
                  },
                ),
              ));
            }
          }
          if (children.isEmpty) return const SizedBox.shrink();
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: DeviceInfoHelper.isDesktop ? 400 : Get.width,
                padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
                child: SingleChildScrollView(
                  child: Column(children: children),
                ),
              ),
            ],
          );
        }),
        background: const SizedBox.shrink(),
      );
    }
    inAppNotificationUpdateFlag++;
  }

  /// 关闭通知
  void closeNotification(String key) async {
    if (!indexNotificationWidget.containsKey(key)) return;
    int order = notificationKeyIndex[key]!;
    indexNotificationWidget.remove(key);
    notificationKeyIndex.remove(key);
    indexNotificationKeys[order]?.remove(key);
    await notificationController[key]?.reverse();
    if (indexNotificationWidget.isEmpty) {
      appLogic.closeOverlay("in_app_notification");
    }
    inAppNotificationUpdateFlag++;
  }
}

/// 快捷获取控制器
AppLogic get appLogic => AppLogic();

/// 快捷获取配置
AppConfig get appConfig => appLogic.config;

/// 快捷获取模版数据
ThemeTemplate get currentThemeTemplate => appLogic.themeTemplate;

/// 主页控制器
class AppLogic extends GetxController with OrientationHelper, ThemeHelper, AppLifecycleHelper, OverlayHelper, InAppNotificationHelper, WindowListener {
  AppLogic._();

  AppLogic.forExtends();

  static AppLogic? _instance;

  factory AppLogic() {
    return _instance ??= Get.put<AppLogic>(AppLogic._());
  }

  /// 应用配置
  late final AppConfig config;

  /// 应用初始化回调函数
  /// 调用点为[InitializeHelper.init]
  final Map<String, FutureOr<void> Function()> _onAppInitCallback = {};

  /// 应用构建完回调函数
  /// 调用点为[onReady]
  final Map<String, FutureOr<void> Function()> _onReadyCallback = {};

  /// 应用重新构建回调
  /// 调用点为[rebuild]
  final Map<String, FutureOr<void> Function()> _onRefreshCallback = {};

  /// 应用销毁回调
  /// 调用点为[onClose]
  final Map<String, FutureOr<void> Function()> _onCloseCallback = {};

  /// 注册构建完回调，用于为其他组件提供应用构建回调
  void listenOnAppInit(String key, FutureOr<void> Function() callback) => _onAppInitCallback[key] = callback;

  /// 注册构建完回调，用于为其他组件提供应用构建回调
  void listenOnReady(String key, FutureOr<void> Function() callback) => _onReadyCallback[key] = callback;

  /// 注册重建完回调，用于为其他组件提供应用构建回调
  void listenRefresh(String key, FutureOr<void> Function() callback) => _onRefreshCallback[key] = callback;

  /// 监听销毁
  void listenOnClose(String key, FutureOr<void> Function() callback) => _onCloseCallback[key] = callback;

  /// 移除应用构建监听器
  void removeAppInitListener(String key) => _onAppInitCallback.remove(key);

  /// 移除重建监听器
  void removeRefreshListener(String key) => _onRefreshCallback.remove(key);

  /// 移除构建监听器
  void removeOnReadyListener(String key) => _onReadyCallback.remove(key);

  /// 移除销毁监听器
  void removeOnCloseListener(String key) => _onCloseCallback.remove(key);

  /// 窗口高度
  final RxDouble windowHeight = 1024.0.obs;

  /// 窗口宽度
  final RxDouble windowWidth = 1024.0.obs;

  @override
  void onWindowResize() async {
    super.onWindowResize();
    windowHeight.value = Get.height;
    windowWidth.value = Get.width;
    await PrefsHelper.prefs.setDouble("window_height", windowHeight.value);
    await PrefsHelper.prefs.setDouble("window_width", windowWidth.value);
  }

  /// 应用初始化时调用
  /// 调用点为[InitializeHelper.init]
  Future<void> onAppInit(AppConfig appConfig) async {
    LogHelper.info("[AppLogic]:初始化");
    windowManager.addListener(this);
    config = appConfig;
    windowHeight.value = Get.height;
    windowWidth.value = Get.width;
    await _onAppInitTheme();
    for (var value in _onAppInitCallback.values) {
      try {
        FutureOr res = value();
        if (res is Future) {
          await res;
        }
      } catch (e) {
        LogHelper.error(e.toString());
      }
    }
  }

  /// 应用构建时调用
  /// 调用点为[App.build]
  void onWidgetBuild(BuildContext context) {
    _onWidgetBuildTheme();
    _onWidgetBuildOrientation();
  }

  @override
  onReady() async {
    for (var value in _onReadyCallback.values) {
      try {
        FutureOr res = value();
        if (res is Future) {
          await res;
        }
      } catch (e) {
        LogHelper.error(e.toString());
      }
    }
  }

  @override
  onClose() async {
    _onCloseOrientation();
    for (var value in _onCloseCallback.values) {
      try {
        FutureOr res = value();
        if (res is Future) {
          await res;
        }
      } catch (e) {
        LogHelper.error(e.toString());
      }
    }
  }

  /// 重新根据主题渲染
  @override
  void themeChangedReRender() {
    super.themeChangedReRender();
    update();
  }

  /// 系统亮度调整 用于WidgetsBindingObserver的方法调用
  @mustCallSuper
  void didChangePlatformBrightness() {
    Brightness brightness = window.platformBrightness;
    if (appLifecycleState != AppLifecycleState.resumed) return;
    if (this.brightness == brightness) return;
    this.brightness = brightness;
    log("brightness changed $brightness");
    themeChangedReRender();
  }

  /// 生命周期改变回调
  @mustCallSuper
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log("didChangeAppLifecycleState:$state");
    if (appLifecycleState == state) return;
    appLifecycleState = state;
    for (var value in _appLifecycleListener.values) {
      try {
        value(appLifecycleState);
      } catch (e) {
        LogHelper.error(e.toString());
      }
    }
    didChangePlatformBrightness();
  }

  /// 重新构建应用
  Future<void> rebuild() async {
    // 数据库刷新
    await DatabaseHelper.refresh();
    // 数据库版本变更
    int oldVersion = DatabaseHelper.database.oldVersion;
    int newVersion = DatabaseHelper.database.version;
    if (oldVersion != newVersion) await config.onDatabaseVersionChanged(oldVersion, newVersion);
    // 通知刷新
    await NotificationHelper.refresh();
    // 配置回调刷新
    appConfig.afterRefresh();
    // 主题刷新
    await _onAppInitTheme();
    update();
    for (var callback in _onRefreshCallback.values) {
      try {
        callback.call();
      } catch (e) {
        LogHelper.error(e.toString());
      }
    }
  }
}
