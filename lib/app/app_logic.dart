import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orientation/orientation.dart';

/// 屏幕方向监听器
abstract class OrientationListener {
  // --- 屏幕方向 ---
  /// 当前屏幕方向 使用这个参数的原因是，当应用禁用左右旋转之后，mediaQuery的方向九不会变化了
  /// 这个参数即使是锁定旋转也可以生效
  DeviceOrientation? deviceOrientation;

  /// 屏幕方向监听订阅
  StreamSubscription<DeviceOrientation>? _subscription;

  /// 初始化
  void initOrientationListener() {
    _subscription = OrientationPlugin.onOrientationChange.listen((value) {
      deviceOrientation = value;
    });
  }

  /// 关闭
  void closeOrientationListener() {
    _subscription?.cancel();
  }

  /// 监听屏幕方向
  void listenDeviceOrientation(DeviceOrientation deviceOrientation) {
    if (this.deviceOrientation != deviceOrientation) {
      this.deviceOrientation = deviceOrientation;
      onDeviceOrientationChanged(deviceOrientation);
    }
  }

  /// 屏幕方向改变回调
  void onDeviceOrientationChanged(DeviceOrientation deviceOrientation);
}

/// 主题监听器
abstract class ThemeListener {
  /// 主题服务
  ThemeConfigService themeConfigService = ThemeConfigService.instance;

  /// 主题配置
  ThemeConfig themeConfig = ThemeConfig();

  /// 系统亮度
  Brightness brightness = Brightness.light;

  /// 获取当前的新拟态主题
  NeumorphicThemeData get neumorphicThemeData => NeumorphicTheme.currentTheme(Get.context!);

  void initThemeListener() {
    brightness = window.platformBrightness;
    updateTheme(themeConfig);
  }

  /// 查询主题配置
  Future<void> findThemeConfig() async {
    themeConfig = await themeConfigService.find();
  }

  /// 更新主题
  void updateTheme(ThemeConfig themeConfig) {
    this.themeConfig = themeConfig;
    themeChangedReRender();
  }

  /// 重新构建
  Future<void> rebuild() async {
    await findThemeConfig();
    themeChangedReRender();
  }

  /// 重新根据主题渲染
  void themeChangedReRender();

  /// 系统亮度调整 用于WidgetsBindingObserver的方法调用
  void didChangePlatformBrightness() {
    Brightness brightness = Get.mediaQuery.platformBrightness;
    if (this.brightness == brightness) return;
    this.brightness = brightness;
    log("brightness changed");
    themeChangedReRender();
  }
}

/// 应用生命周期监听器
abstract class AppLifecycleListener {
  /// 当前app状态
  AppLifecycleState appLifecycleState = AppLifecycleState.resumed;

  /// 生命周期改变回调
  @mustCallSuper
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log("didChangeAppLifecycleState:$state");
    appLifecycleState = state;
  }
}

/// 蒙版助手
abstract class OverlayHelper {
  /// 蒙版组件
  Map<String, Widget> overlayWidget = {};

  /// 蒙版顺序
  Map<int, Set<String>> indexOverlay = {};

  /// 蒙版顺序
  Map<String, int> overlayIndex = {};

  /// 显示蒙版 index越高越靠上
  void showOverlay({required String key, int index = 0, required Widget widget}) {
    overlayWidget[key] = widget;
    indexOverlay.putIfAbsent(index, () => {}).add(key);
    overlayIndex[key] = index;
    onOverlayReRender();
  }

  /// 关闭蒙版
  void closeOverlay(String key) {
    int? index = overlayIndex[key];
    if (null != index) indexOverlay.putIfAbsent(index, () => {}).remove(key);
    overlayWidget.remove(key);
    overlayIndex.remove(key);
    onOverlayReRender();
  }

  /// 蒙版修改渲染
  void onOverlayReRender();
}

/// 主页控制器
class MainLogic extends GetxController with PageBuilder, OrientationListener, ThemeListener, AppLifecycleListener, OverlayHelper {
  MainLogic._();

  static MainLogic get instance => Get.put<MainLogic>(MainLogic._());

  /// 路由id
  final int navigatorId = AppConfig.rootNavigatorId;

  /// 应用构建完回调
  final Map<String, VoidCallback> _onReadyCallback = {};

  /// 注册构建完回调
  void registerReadyCallback(String key, VoidCallback callback) => _onReadyCallback[key] = callback;

  /// 应用构建时调用
  void onWidgetBuild(BuildContext context) {
    initThemeListener();
    initOrientationListener();
    isShowIntro.value = SharedPreferencesHelper.prefs.getBool(SharedPreferencesKeys.isShowIntro) ?? true;
  }

  @override
  onReady() {
    for (var value in _onReadyCallback.values) {
      value();
    }
  }

  @override
  onClose() {
    closeOrientationListener();
  }

  /// 根据页面重新渲染
  @override
  void pageChangedReRender() => update();

  /// 重新根据主题渲染
  @override
  void themeChangedReRender() => update();

  /// 生命周期改变回调
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    HomePageLogic? pageLogic = activeLogic;
    pageLogic?.didChangeAppLifecycleState(state);
  }

  /// 屏幕方向改变监听
  @override
  void onDeviceOrientationChanged(DeviceOrientation deviceOrientation) {
    activeLogic?.onDeviceOrientationChanged(deviceOrientation);
  }

  /// 是否显示介绍页
  Rx<bool> isShowIntro = true.obs;

  /// 介绍页关闭调用
  void onIntroEnd() async {
    SharedPreferencesHelper.prefs.setBool(SharedPreferencesKeys.isShowIntro, false);
    isShowIntro.value = false;
  }

  /// 蒙版更新标识
  Rx<int> overlayUpdateFlag = 0.obs;

  @override
  void onOverlayReRender() {
    overlayUpdateFlag.value++;
  }
}
