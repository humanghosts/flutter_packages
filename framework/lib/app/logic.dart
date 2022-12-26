import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hgs_framework/framework.dart';

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

/// 主页控制器
class AppLogic extends GetxController with AppInitPlugin, AppRebuildPlugin, _AppLifecycleHelper {
  AppLogic._();

  AppLogic.create();

  static AppLogic? _instance;

  factory AppLogic() => _instance ??= Get.put<AppLogic>(AppLogic._());

  /// 应用配置
  AppConfig get config => AppHelper().appConfig;

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
  void listenOnRebuild(String key, FutureOr<void> Function() callback) => _onRefreshCallback[key] = callback;

  /// 监听销毁
  void listenOnClose(String key, FutureOr<void> Function() callback) => _onCloseCallback[key] = callback;

  /// 移除应用构建监听器
  void removeAppInitListener(String key) => _onAppInitCallback.remove(key);

  /// 移除重建监听器
  void removeRebuildListener(String key) => _onRefreshCallback.remove(key);

  /// 移除构建监听器
  void removeOnReadyListener(String key) => _onReadyCallback.remove(key);

  /// 移除销毁监听器
  void removeOnCloseListener(String key) => _onCloseCallback.remove(key);

  @override
  Future<bool> init(AppConfig config) async {
    log("[AppLogic]:初始化");
    for (var value in _onAppInitCallback.values) {
      try {
        FutureOr res = value();
        if (res is Future) await res;
      } catch (e) {
        log(e.toString());
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
        log(e.toString());
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
        log(e.toString());
      }
    }
  }

  /// 系统亮度调整 用于WidgetsBindingObserver的方法调用
  @mustCallSuper
  void didChangePlatformBrightness() {
    Brightness brightness = window.platformBrightness;
    if (appLifecycleState != AppLifecycleState.resumed) return;
    if (config.themeConfig.brightness == brightness) return;
    config.themeConfig.brightness = brightness;
    log("brightness changed $brightness");
    config.themeConfig.reRender();
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
        log(e.toString());
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
        log(e.toString());
      }
    }
    return true;
  }
}
