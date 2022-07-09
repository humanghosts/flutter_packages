import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';

/// 应用助手
class AppHelper {
  /// 运行应用 使用在main方法中
  /// [app]是要运行的应用
  /// [orientations]应用支持的屏幕方法，默认为仅支持竖屏
  static run(App app, AppConfig config) {
    // 监控应用
    runZonedGuarded(
      () async {
        await config.beforeInit();
        await AppInit.init(config);
        runApp(app);
      },
      (error, stackTrace) {
        LogHelper.wtf(error.toString(), error: error, stackTrace: stackTrace);
      },
      zoneSpecification: const ZoneSpecification(),
    );
  }
}
