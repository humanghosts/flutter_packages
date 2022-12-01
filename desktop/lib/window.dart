import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hgs_device_info/device_info.dart';
import 'package:hgs_framework/framework.dart';
import 'package:hgs_prefs/prefs.dart';
import 'package:window_manager/window_manager.dart';

/// 桌面模式窗口助手
class WindowHelper with AppInitPlugin, WindowListener {
  WindowHelper._({this.options});

  factory WindowHelper({WindowOptions? options}) => SingletonCache.putIfAbsent(WindowHelper._(options: options));

  /// 第三方插件
  WindowManager get windowManager => WindowManager.instance;

  final WindowOptions? options;

  /// 窗口高度
  final RxDouble windowHeight = 1024.0.obs;

  /// 窗口宽度
  final RxDouble windowWidth = 1024.0.obs;

  @override
  void onWindowResize() async {
    super.onWindowResize();
    windowHeight.value = Get.height;
    windowWidth.value = Get.width;
    if (!PrefsHelper().isInit) return;
    await PrefsHelper().prefs.setDouble("window_height", windowHeight.value);
    await PrefsHelper().prefs.setDouble("window_width", windowWidth.value);
  }

  @override
  FutureOr<bool> init(AppConfig config) async {
    bool isDesktop = DeviceInfoHelper().isDesktopDeviceApp;
    if (!isDesktop) return false;
    await windowManager.ensureInitialized();
    await windowManager.waitUntilReadyToShow(options, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setTitle(config.appName);
    });
    windowManager.addListener(this);
    double? height;
    double? width;
    if (PrefsHelper().isInit) {
      height = PrefsHelper().prefs.getDouble("window_height");
      width = PrefsHelper().prefs.getDouble("window_width");
    }
    windowHeight.value = height ?? Get.height;
    windowWidth.value = width ?? Get.width;
    return true;
  }
}

extension WindowOpeionsEx on WindowOptions {
  WindowOptions copyWith({
    Size? size,
    bool? center,
    Size? minimumSize,
    Size? maximumSize,
    bool? alwaysOnTop,
    bool? fullScreen,
    Color? backgroundColor,
    bool? skipTaskbar,
    String? title,
    TitleBarStyle? titleBarStyle,
  }) {
    return WindowOptions(
      size: size ?? this.size,
      center: center ?? this.center,
      minimumSize: minimumSize ?? this.minimumSize,
      maximumSize: maximumSize ?? this.maximumSize,
      alwaysOnTop: alwaysOnTop ?? this.alwaysOnTop,
      fullScreen: fullScreen ?? this.fullScreen,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      skipTaskbar: skipTaskbar ?? this.skipTaskbar,
      title: title ?? this.title,
      titleBarStyle: titleBarStyle ?? this.titleBarStyle,
    );
  }

  WindowOptions copyWithIfNull({
    Size? size,
    bool? center,
    Size? minimumSize,
    Size? maximumSize,
    bool? alwaysOnTop,
    bool? fullScreen,
    Color? backgroundColor,
    bool? skipTaskbar,
    String? title,
    TitleBarStyle? titleBarStyle,
  }) {
    return WindowOptions(
      size: this.size ?? size,
      center: this.center ?? center,
      minimumSize: this.minimumSize ?? minimumSize,
      maximumSize: this.maximumSize ?? maximumSize,
      alwaysOnTop: this.alwaysOnTop ?? alwaysOnTop,
      fullScreen: this.fullScreen ?? fullScreen,
      backgroundColor: this.backgroundColor ?? backgroundColor,
      skipTaskbar: this.skipTaskbar ?? skipTaskbar,
      title: this.title ?? title,
      titleBarStyle: this.titleBarStyle ?? titleBarStyle,
    );
  }
}
