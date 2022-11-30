import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:database_sembast/database_sembast.dart';
import 'package:entity/entity.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';

import 'entity/export.dart';
import 'service/export.dart';

export 'entity/export.dart';
export 'service/export.dart';

/// 主题助手
class ThemeHelper with AppInitPlugin, AppBuildPlugin, AppRebuildPlugin {
  ThemeHelper._({bool? presetTheme}) : _presetTheme = presetTheme ?? true;

  factory ThemeHelper({bool? presetTheme}) => SingletonCache.putIfAbsent(ThemeHelper._(presetTheme: presetTheme));

  /// 是否预置主题数据
  final bool _presetTheme;

  /// 初始化的时候需要注册实体
  @override
  FutureOr<bool> init(AppConfig config) async {
    // 注册主题相关构造器
    _themeEntitiesMap().forEach(ConstructorCache.put);
    if (!DatabaseHelper().isInit) {
      themeConfig = ThemeConfig();
      return true;
    }
    // 注册Dao
    _daoGetter().forEach(DaoCache.put);
    int oldVersion = DatabaseHelper().database.oldVersion;
    if (oldVersion > 0) {
      themeConfig = await themeConfigService.find();
      return true;
    }
    if (_presetTheme) return true;
    // 插入预置数据
    log("开始预置主题数据");
    Map<Type, List<DataModel> Function()> dataModelMap = _dataModelPresetData();
    Map<Type, SimpleModel Function()> simpleModelMap = _simpleModelPresetData();
    // 插入数据
    await DatabaseHelper().transaction((tx) async {
      for (Type key in dataModelMap.keys) {
        LogHelper.info("[数据库预置数据]:初始化[${key.toString()}]");
        DataDao dataDao = DaoCache.getByType(key) as DataDao;
        List<DataModel> value = dataModelMap[key]!.call();
        await dataDao.saveList(value, tx: tx);
      }
      for (Type key in simpleModelMap.keys) {
        LogHelper.info("[数据库预置数据]:初始化[${key.toString()}]");
        SimpleDao simpleDao = DaoCache.getByType(key) as SimpleDao;
        SimpleModel value = simpleModelMap[key]!.call();
        await simpleDao.save(value, tx: tx);
      }
    });
    log("预置主题数据结束");
    themeConfig = await themeConfigService.find();
    return true;
  }

  @override
  FutureOr<bool> build(AppConfig config) {
    brightness = window.platformBrightness;
    _setThemeArgs();
    return true;
  }

  @override
  FutureOr<bool> rebuild(AppConfig config) async {
    if (DatabaseHelper().isInit && DatabaseHelper().isRebuild) {
      themeConfig = await themeConfigService.find();
    }
    brightness = window.platformBrightness;
    _setThemeArgs();
    return true;
  }

  /// 主题服务
  ThemeConfigService get themeConfigService => ThemeConfigService();

  /// 主题模板服务
  ThemeTemplateService get themeTemplateService => ThemeTemplateService();

  /// 当前主题配置
  late ThemeConfig themeConfig;

  /// 当前系统亮度
  Brightness brightness = Brightness.light;

  /// 当前主题模板
  ThemeTemplate get themeTemplate => themeConfig.templateInUse.value;

  /// 当前主题数据
  ThemeData themeData = ThemeData();

  /// 浅色模式主题
  ThemeData lightTheme = ThemeData();

  /// 深色模式主题
  ThemeData darkTheme = ThemeData();

  /// 主题模式
  ThemeMode themeMode = ThemeMode.system;

  /// 主题更新标识
  RxInt themeUpdateFlag = 0.obs;

  /// 主题更新监听器
  final Map<String, VoidCallback> _themeListener = {};

  /// 是否浅色模式
  bool get isLightMode => brightness == Brightness.light;

  /// 是否深色模式
  bool get isDarkMode => brightness == Brightness.dark;

  /// 监听主题更新
  void listenThemeUpdate(String key, VoidCallback callback) => _themeListener[key] = callback;

  /// 移除主题更新监听器
  void removeThemeUpdateListener(String key) => _themeListener.remove(key);

  /// 设置主题参数
  void _setThemeArgs() {
    lightTheme = themeTemplate.toFlexColorThemeLight().toTheme;
    darkTheme = themeTemplate.toFlexColorThemeDark().toTheme;
    themeMode = themeTemplate.themeMode.value.mode;
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
    SystemChrome.setSystemUIOverlayStyle(
      FlexColorScheme.themedSystemNavigationBar(
        Get.context,
        systemNavBarStyle: themeTemplate.sysNavBarStyle.value.style,
        useDivider: themeTemplate.useSysNavDivider.value,
        opacity: themeTemplate.sysNavBarOpacity.value,
      ),
    );
  }

  /// 保存主题配置
  Future<void> saveConfig() async {
    if (!DatabaseHelper().isInit) return;
    await themeConfigService.save(themeConfig);
  }

  /// 更新主题
  Future<void> updateThemeTemplate(ThemeTemplate template) async {
    String id = template.id.value;
    String inUseId = themeConfig.templateInUse.value.id.value;
    if (DatabaseHelper().isInit) await themeTemplateService.save(template);
    if (id == inUseId) reRender();
  }

  /// 删除主题
  Future<bool> removeThemeTemplate(ThemeTemplate template) async {
    String id = template.id.value;
    String inUseId = themeConfig.templateInUse.value.id.value;
    if (id == inUseId) {
      ToastHelper().inAppNotification(
        leading: Icon(Icons.sms_failed_outlined, color: themeData.errorColor),
        title: "无法删除",
        message: "主题${template.name.value ?? "未命名"}正在使用中",
      );
      return false;
    }
    if (DatabaseHelper().isInit) {
      await themeConfigService.transaction((tx) async {
        await themeTemplateService.remove(template, tx: tx);
        themeConfig.templateList.removeWhere((element) => element.id.value == template.id.value);
        await themeConfigService.save(themeConfig);
      });
    } else {
      themeConfig.templateList.removeWhere((element) => element.id.value == template.id.value);
    }
    return true;
  }

  /// 使用主题
  Future<void> useThemeTemplate(ThemeTemplate template) async {
    themeConfig.templateInUse.value = template;
    if (DatabaseHelper().isInit) await themeConfigService.save(themeConfig);
    reRender();
  }

  /// 添加一个主题
  /// [addToUse] 表示是否同时使用这个主题
  Future<void> addThemeTemplate(ThemeTemplate template, {bool addToUse = false}) async {
    Set<String> templateIdMap = themeConfig.templateList.value.map((e) => e.id.value as String).toSet();
    String id = template.id.value;
    if (templateIdMap.contains(id)) return;
    themeConfig.templateList.add(template);
    if (addToUse) {
      await useThemeTemplate(template);
    } else {
      if (DatabaseHelper().isInit) await themeConfigService.save(themeConfig);
    }
  }

  /// 重新根据主题渲染
  void reRender() {
    themeUpdateFlag++;
    _setThemeArgs();
    for (var value in _themeListener.values) {
      try {
        value();
      } catch (e) {
        LogHelper.error(e.toString());
      }
    }
  }
}

Map<Type, EntityConstructor> _themeEntitiesMap() {
  return {
    // custom value
    ThemeModeValue: ([args]) => ThemeModeValue(),
    FlexSchemeValue: ([args]) => FlexSchemeValue(),
    FlexSurfaceModeValue: ([args]) => FlexSurfaceModeValue(),
    SchemeColorValue: ([args]) => SchemeColorValue(),
    FlexAppBarStyleValue: ([args]) => FlexAppBarStyleValue(),
    FlexTabBarStyleValue: ([args]) => FlexTabBarStyleValue(),
    FlexInputBorderTypeValue: ([args]) => FlexInputBorderTypeValue(),
    FlexSystemNavBarStyleValue: ([args]) => FlexSystemNavBarStyleValue(),
    NavigationDestinationLabelBehaviorValue: ([args]) => NavigationDestinationLabelBehaviorValue(),
    NavigationRailLabelTypeValue: ([args]) => NavigationRailLabelTypeValue(),
    ColorValue: ([args]) => ColorValue(),
    // data model
    ThemeTemplate: ([args]) => ThemeTemplate(),
    // simple model
    ThemeConfig: ([args]) => ThemeConfig(),
  };
}

Map<Type, Dao> _daoGetter() {
  return {
    ThemeTemplate: SembastDataDao<ThemeTemplate>(),
    ThemeConfig: SembastSimpleDao<ThemeConfig>(),
  };
}

/// 数据模型的初始化数据
Map<Type, List<DataModel> Function()> _dataModelPresetData() {
  return {
    ThemeTemplate: () => ThemeTemplate.initData,
  };
}

/// 简单模型的初始化数据
Map<Type, SimpleModel Function()> _simpleModelPresetData() {
  return {
    ThemeConfig: () => ThemeConfig.initData,
  };
}
