import 'dart:async';

import 'package:hgs_device_info/device_info.dart';
import 'package:hgs_framework/framework.dart';
import 'package:hgs_notification/notification.dart';
import 'package:hgs_prefs/prefs.dart';

/// 应用配置
class DefaultAppConfig extends AppConfig {
  /// 单例模式代码
  DefaultAppConfig._();

  DefaultAppConfig.create();

  static DefaultAppConfig? _instance;

  factory DefaultAppConfig() => _instance ??= DefaultAppConfig._();

  @override
  String get appName => "快速开始";

  @override
  String get appVersion => "0.0.1";

  @override
  AppInit get appInit => DefaultAppInit();

  @override
  AppBuild get appBuild => DefaultAppBuild();

  @override
  AppRebuild get appRebuild => DefaultAppRebuild();
}

class DefaultAppInit extends AppInit {
  DefaultAppInit._() : super.create();

  DefaultAppInit.create() : super.create();

  factory DefaultAppInit() => SingletonCache.putIfAbsent(DefaultAppInit._());

  /// 注册插件
  @override
  FutureOr<void> registerPlugin() {
    addPlugin('prefs', PrefsHelper()); // 本地存储配置
    // 大部分功能都需要设备信息，这个是刚需，没有进行未配置校验 不优先初始化的话应该会报错
    addPlugin('deviceInfo', DeviceInfoHelper()); // 设备信息配置
    addPlugin("notification", NotificationHelper()); // 通知配置
    addPlugin("app", AppLogic()); // 应用初始化 这个必须初始化
  }
}

class DefaultAppRebuild extends AppRebuild {
  DefaultAppRebuild._() : super.create();

  DefaultAppRebuild.create() : super.create();

  factory DefaultAppRebuild() => SingletonCache.putIfAbsent(DefaultAppRebuild._());

  @override
  FutureOr<void> registerPlugin() {
    addPlugin("notification", NotificationHelper());
    addPlugin("appLogic", AppLogic());
  }
}

class DefaultAppBuild extends AppBuild {
  DefaultAppBuild._() : super.create();

  DefaultAppBuild.create() : super.create();

  factory DefaultAppBuild() => SingletonCache.putIfAbsent(DefaultAppBuild._());

  @override
  FutureOr<void> registerPlugin() {}
}
