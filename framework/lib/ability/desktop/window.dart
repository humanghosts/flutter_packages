import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:window_manager/window_manager.dart';

/// 桌面模式窗口助手
class WindowHelper with AppInitPlugin {
  WindowHelper._({this.options});

  factory WindowHelper({WindowOptions? options}) => SingletonCache.putIfAbsent(WindowHelper._(options: options));

  /// 第三方插件
  WindowManager get windowManager => WindowManager.instance;

  final WindowOptions? options;

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
