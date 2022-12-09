import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hgs_framework/framework.dart';

/// 应用配置
abstract class AppConfig {
  /// 应用名称
  String get appName;

  /// 应用版本
  String get appVersion;

  /// 主题配置
  ThemeConfig get themeConfig => ThemeConfig();

  /// 动画配置 自定义配置的时候需要覆写
  AnimationConfig get animationConfig => AnimationConfig();

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

/// 主题配置
class ThemeConfig {
  ThemeConfig._();

  factory ThemeConfig() => SingletonCache.putIfAbsent(ThemeConfig._());

  /// 当前主题数据
  ThemeData themeData = ThemeData();

  /// 浅色模式主题
  ThemeData lightTheme = ThemeData();

  /// 深色模式主题
  ThemeData darkTheme = ThemeData();

  /// 主题模式
  ThemeMode themeMode = ThemeMode.system;

  /// 当前系统亮度
  Brightness brightness = Brightness.light;

  /// 是否浅色模式
  bool get isLightMode => brightness == Brightness.light;

  /// 是否深色模式
  bool get isDarkMode => brightness == Brightness.dark;

  /// 主题更新标识
  RxInt themeUpdateFlag = 0.obs;

  /// 主题更新监听器
  final Map<String, VoidCallback> _themeListener = {};

  /// 监听主题更新
  void addListener(String key, VoidCallback callback) => _themeListener[key] = callback;

  /// 移除主题更新监听器
  void removeListener(String key) => _themeListener.remove(key);

  /// 设置主题
  void setTheme() {
    switch (themeMode) {
      case ThemeMode.system:
        themeData = isLightMode ? lightTheme : darkTheme;
        break;
      case ThemeMode.light:
        themeData = lightTheme;
        break;
      case ThemeMode.dark:
        themeData = darkTheme;
        break;
    }
  }

  /// 重新根据主题渲染
  void reRender() {
    themeUpdateFlag++;
    setTheme();
    for (var value in _themeListener.values) {
      try {
        value();
      } catch (e) {
        log("主题更新出错：$e");
      }
    }
  }
}
