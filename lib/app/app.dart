import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hg_framework/app/app_config.dart';
import 'package:hg_framework/hg_framework.dart';

import '../ability/log/log.dart';

/// 应用助手
class AppHelper {
  /// 运行应用 使用在main方法中
  /// [app]是要运行的应用
  /// [orientations]应用支持的屏幕方法，默认为仅支持竖屏
  static run({
    required App app,
    required AppConfig appConfig,
    List<DeviceOrientation> orientations = const [DeviceOrientation.portraitUp],
  }) {
    WidgetsFlutterBinding.ensureInitialized();
    // 设置允许的屏幕方向
    SystemChrome.setPreferredOrientations(orientations);
    // 监控应用
    runZonedGuarded(
      () async {
        await AppInit.init(appConfig);
        runApp(app);
      },
      (error, stackTrace) {
        LogHelper.wtf(error.toString(), error: error, stackTrace: stackTrace);
      },
      zoneSpecification: const ZoneSpecification(),
    );
  }
}
