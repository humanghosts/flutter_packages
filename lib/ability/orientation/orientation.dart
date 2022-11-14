import 'dart:async';

import 'package:flutter/services.dart';
import 'package:hg_framework/app/config.dart';
import 'package:hg_framework/hg_framework.dart';

/// 设备方向助手
/// TODO 暂时用不上，代码可能有问题
class OrientationHelper with AppInitPlugin {
  OrientationHelper._({List<DeviceOrientation>? orientations}) : _orientations = orientations ?? const [DeviceOrientation.portraitUp];

  factory OrientationHelper({List<DeviceOrientation>? orientations}) => SingletonCache.putIfAbsent(OrientationHelper._(orientations: orientations));

  // --- 屏幕方向 ---
  /// 当前屏幕方向 使用这个参数的原因是，当应用禁用左右旋转之后，mediaQuery的方向就不会变化了
  /// 这个参数即使是锁定旋转也可以生效
  DeviceOrientation? deviceOrientation;

  List<DeviceOrientation>? _orientations;

  /// 屏幕方向监听
  final Map<String, ValueChanged<DeviceOrientation>> _orientationListener = {};

  @override
  FutureOr<void> init(AppConfig config) async {
    // 设置设备可用方向
    if (null == _orientations) return;
    await SystemChrome.setPreferredOrientations(_orientations!);
  }

  /// 监听屏幕方向更新
  void listenOrientationUpdate(String key, ValueChanged<DeviceOrientation> callback) => _orientationListener[key] = callback;

  /// 移除屏幕方法监听器
  void removeOrientationUpdateListener(String key) => _orientationListener.remove(key);

  /// 初始化
  void _onWidgetBuildOrientation() {
    if (DeviceInfoHelper().isDesktop || DeviceInfoHelper().isWeb) return;
  }

  /// 关闭
  void _onCloseOrientation() {}

  /// 监听屏幕方向
  void _listenDeviceOrientation(DeviceOrientation deviceOrientation) {
    if (this.deviceOrientation == deviceOrientation) return;
    this.deviceOrientation = deviceOrientation;
    _onDeviceOrientationChanged(deviceOrientation);
  }

  /// 屏幕方向改变回调
  void _onDeviceOrientationChanged(DeviceOrientation deviceOrientation) {
    for (var value in _orientationListener.values) {
      try {
        value(deviceOrientation);
      } catch (e) {
        LogHelper.error(e.toString());
      }
    }
  }
}
