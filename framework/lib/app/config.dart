import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hg_framework/hg_framework.dart';

/// 应用配置
abstract class AppConfig {
  /// 应用名称
  String get appName;

  /// 应用版本
  String get appVersion;

  /// 动画配置 自定义配置的时候需要覆写
  AnimationConfig get animationConfig => AnimationConfig();

  /// 资源配置 自定义配置的时候需要覆写
  AssetsConfig get assetsConfig => AssetsConfig();

  /// 默认地域 自定义配置的时候需要覆写
  Locale get locale => const Locale('zh', 'CN');

  /// 支持地域 自定义配置的时候需要覆写
  List<Locale> get supportedLocales => const <Locale>[Locale('zh', 'CN')];

  /// 本地化代理类 自定义配置的时候需要覆写
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  /// 应用初始化 自定义启动插件时需要覆写
  AppInit get appInit => AppInit();

  /// 应用构建 自定义构建插件时需要覆写
  AppBuild get appBuild => AppBuild();

  /// 应用刷新 自定义构建插件时需要覆写
  AppRebuild get appRebuild => AppRebuild();
}

/// 动画配置
class AnimationConfig {
  AnimationConfig._();

  factory AnimationConfig() => SingletonCache.putIfAbsent(AnimationConfig._());

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

  factory AssetsConfig() => SingletonCache.putIfAbsent(AssetsConfig._());

  /// 音频文件路径
  String get soundAssetsPath => "assets/sounds/";

  /// 图片文件路径
  String get imageAssetsPath => "assets/images/";
}
