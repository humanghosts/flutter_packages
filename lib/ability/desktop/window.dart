import 'dart:async';

import 'package:hg_framework/app/config.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:window_manager/window_manager.dart';

/// 桌面模式窗口助手
class WindowHelper with AppPlugin {
  WindowHelper._();

  factory WindowHelper() => SingletonCache.putIfAbsent(WindowHelper._());

  /// 第三方插件
  WindowManager get windowManager => WindowManager.instance;

  @override
  FutureOr<void> init(AppConfig config, {WindowOptions? options}) async {
    bool isDesktop = DeviceInfoHelper().isDesktopDeviceApp;
    if (!isDesktop) return;
    await windowManager.ensureInitialized();
    await windowManager.waitUntilReadyToShow(options, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setTitle(config.appName);
    });
  }
}
