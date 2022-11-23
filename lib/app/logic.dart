import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/ability/toast/overlay.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:theme/theme.dart';
import 'package:window_manager/window_manager.dart';

/// 应用生命周期监听器 adder
class _AppLifecycleHelper {
  /// 当前app状态
  AppLifecycleState appLifecycleState = AppLifecycleState.resumed;

  /// 生命周期监听器
  final Map<String, ValueChanged<AppLifecycleState>> _appLifecycleListener = {};

  /// 监听生命周期改变
  void listenAppLifecycleUpdate(String key, ValueChanged<AppLifecycleState> callback) => _appLifecycleListener[key] = callback;

  /// 移除监听
  void removeAppLifecycleListener(String key) => _appLifecycleListener.remove(key);
}

/// 应用内通知助手
class _NotificationHelper {
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
      OverlayHelper().showOverlay(
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

              Animation<double> animation = Tween<double>(begin: (DeviceInfoHelper().isDesktop ? 400 : Get.width), end: 0).animate(CurvedAnimation(
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
                width: DeviceInfoHelper().isDesktop ? 400 : Get.width,
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
      OverlayHelper().closeOverlay("in_app_notification");
    }
    inAppNotificationUpdateFlag++;
  }
}

/// 主页控制器
class AppLogic extends GetxController with AppInitPlugin, AppRebuildPlugin, _AppLifecycleHelper, _NotificationHelper, WindowListener {
  AppLogic._();

  static AppLogic? _instance;

  factory AppLogic() => _instance ??= Get.put<AppLogic>(AppLogic._());

  /// 应用配置
  AppConfig get config => AppRunner().appConfig;

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
    await PrefsHelper().prefs.setDouble("window_height", windowHeight.value);
    await PrefsHelper().prefs.setDouble("window_width", windowWidth.value);
  }

  @override
  Future<bool> init(AppConfig config) async {
    LogHelper.info("[AppLogic]:初始化");
    windowManager.addListener(this);
    windowHeight.value = Get.height;
    windowWidth.value = Get.width;
    for (var value in _onAppInitCallback.values) {
      try {
        FutureOr res = value();
        if (res is Future) await res;
      } catch (e) {
        LogHelper.error(e.toString());
      }
    }
    return true;
  }

  @override
  onReady() async {
    for (var value in _onReadyCallback.values) {
      try {
        FutureOr res = value();
        if (res is Future) await res;
      } catch (e) {
        LogHelper.error(e.toString());
      }
    }
  }

  @override
  onClose() async {
    for (var value in _onCloseCallback.values) {
      try {
        FutureOr res = value();
        if (res is Future) await res;
      } catch (e) {
        LogHelper.error(e.toString());
      }
    }
  }

  /// 系统亮度调整 用于WidgetsBindingObserver的方法调用
  @mustCallSuper
  void didChangePlatformBrightness() {
    Brightness brightness = window.platformBrightness;
    if (appLifecycleState != AppLifecycleState.resumed) return;
    if (ThemeHelper().brightness == brightness) return;
    ThemeHelper().brightness = brightness;
    log("brightness changed $brightness");
    ThemeHelper().reRender();
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

  @override
  FutureOr<bool> rebuild(AppConfig config) async {
    update();
    for (var callback in _onRefreshCallback.values) {
      try {
        callback.call();
      } catch (e) {
        LogHelper.error(e.toString());
      }
    }
    return true;
  }
}
