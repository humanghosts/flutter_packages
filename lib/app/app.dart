import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ability/log/log.dart';

/// 应用助手
class AppHelper {
  /// 运行应用 使用在main方法中
  /// [app]是要运行的应用
  /// [orientations]应用支持的屏幕方法，默认为仅支持竖屏
  static run({
    required Widget app,
    List<DeviceOrientation> orientations = const [DeviceOrientation.portraitUp],
  }) {
    WidgetsFlutterBinding.ensureInitialized();
    // 设置允许的屏幕方向
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // 监控应用
    runZonedGuarded(
      () async {
        // TODO
        // await init();
        // await MainLogic.instance.findThemeConfig();
        runApp(app);
      },
      (error, stackTrace) {
        LogHelper.wtf(error.toString(), error: error, stackTrace: stackTrace);
      },
      zoneSpecification: const ZoneSpecification(),
    );
  }
}
