import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:window_manager/window_manager.dart';

/// 应用配置
abstract class AppConfig {
  /// 应用名称
  String get appName;

  /// 应用支持的屏幕方向
  List<DeviceOrientation> get orientations => const [DeviceOrientation.portraitUp];

  /// 桌面端 窗口配置
  WindowOptions get windowOptions => const WindowOptions(
        size: Size(800, 600),
        center: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.hidden,
      );

  /// 数据库配置
  DatabaseConfig get databaseConfig;

  /// 通知配置
  NotificationConfig get notificationConfig => NotificationConfig.instance;

  /// 预置数据
  PresetData? get presetData => null;

  /// 模型和Dao注册
  EntityAndDao? get entityAndDao => null;

  /// 动画配置
  AnimationConfig get animationConfig => AnimationConfig.instance;

  /// 资源配置
  AssetsConfig get assetsConfig => AssetsConfig.instance;

  /// 默认地域
  Locale get locale => const Locale('zh', 'CN');

  /// 支持地域
  List<Locale> get supportedLocales => const <Locale>[Locale('zh', 'CN')];

  /// 本地化代理类
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  /// 构造之前
  Future<void> beforeInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 设备信息初始化
    await DeviceInfoHelper.init();
    SystemChrome.setPreferredOrientations(orientations);
    if (AppLogic.isDesktop && !AppLogic.isWeb) {
      await windowManager.ensureInitialized();
      await Window.initialize();
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
        await Window.setEffect(effect: WindowEffect.aero);
        if (AppLogic.devicePlatform == DevicePlatform.macOS) {
          Window.makeTitlebarTransparent();
          Window.enableFullSizeContentView();
          Window.hideTitle();
        }
      });
    }
  }

  /// 初始化回调
  Future<void> afterInit() async {}

  /// 刷新回调
  Future<void> afterRefresh() async {}
}

/// 通知配置
class NotificationConfig {
  NotificationConfig._();

  static NotificationConfig? _instance;

  static NotificationConfig get instance => _instance ??= NotificationConfig._();

  /// 最大通知数量
  int get maxNotificationCount => 60;
}

/// 动画配置
class AnimationConfig {
  AnimationConfig._();

  static AnimationConfig? _instance;

  static AnimationConfig get instance => _instance ??= AnimationConfig._();

  /// 快速动画持续时间
  Duration get fastAnimationDuration => const Duration(milliseconds: 200);

  /// 中速动画持续时间
  Duration get middleAnimationDuration => const Duration(milliseconds: 500);

  /// 慢速动画持续时间
  Duration get slowAnimationDuration => const Duration(milliseconds: 800);
}

/// 资源配置
class AssetsConfig {
  AssetsConfig._();

  static AssetsConfig? _instance;

  static AssetsConfig get instance => _instance ??= AssetsConfig._();

  /// 音频文件路径
  String get soundAssetsPath => "assets/sounds/";

  /// 图片文件路径
  String get imageAssetsPath => "assets/images/";
}
