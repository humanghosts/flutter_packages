import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hgs_database_sembast/database_sembast.dart';
import 'package:hgs_entity/entity.dart';
import 'package:hgs_framework/framework.dart';
import 'package:hgs_toast/toast.dart';

import 'entity/export.dart' as theme;
import 'entity/export.dart';
import 'service/export.dart';

export 'entity/export.dart';
export 'service/export.dart';

typedef FlexThemeConfig = theme.ThemeConfig;

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
      flexThemeConfig = FlexThemeConfig();
      return true;
    }
    // 注册Dao
    _daoGetter().forEach(DaoCache.put);
    int oldVersion = DatabaseHelper().database.oldVersion;
    if (oldVersion > 0) {
      flexThemeConfig = await themeConfigService.find();
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
        log("[数据库预置数据]:初始化[${key.toString()}]");
        DataDao dataDao = DaoCache.getByType(key) as DataDao;
        List<DataModel> value = dataModelMap[key]!.call();
        await dataDao.saveList(value, tx: tx);
      }
      for (Type key in simpleModelMap.keys) {
        log("[数据库预置数据]:初始化[${key.toString()}]");
        SimpleDao simpleDao = DaoCache.getByType(key) as SimpleDao;
        SimpleModel value = simpleModelMap[key]!.call();
        await simpleDao.save(value, tx: tx);
      }
    });
    log("预置主题数据结束");
    flexThemeConfig = await themeConfigService.find();
    return true;
  }

  @override
  FutureOr<bool> build(AppConfig config) {
    themeConfig.brightness = window.platformBrightness;
    setTheme();
    return true;
  }

  @override
  FutureOr<bool> rebuild(AppConfig config) async {
    if (DatabaseHelper().isInit && DatabaseHelper().isRebuild) {
      flexThemeConfig = await themeConfigService.find();
    }
    themeConfig.brightness = window.platformBrightness;
    setTheme();
    return true;
  }

  /// 主题服务
  ThemeConfigService get themeConfigService => ThemeConfigService();

  /// 主题模板服务
  ThemeTemplateService get themeTemplateService => ThemeTemplateService();

  /// 当前主题配置
  late FlexThemeConfig flexThemeConfig;

  /// 当前主题模板
  ThemeTemplate get themeTemplate => flexThemeConfig.templateInUse.value;

  /// 设置主题参数
  void setTheme() {
    themeConfig.lightTheme = themeTemplate.toFlexColorThemeLight().toTheme;
    themeConfig.darkTheme = themeTemplate.toFlexColorThemeDark().toTheme;
    themeConfig.themeMode = themeTemplate.themeMode.value.mode;
    themeConfig.setTheme();
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
    await themeConfigService.save(flexThemeConfig);
  }

  /// 更新主题
  Future<void> updateThemeTemplate(ThemeTemplate template) async {
    String id = template.id.value;
    String inUseId = flexThemeConfig.templateInUse.value.id.value;
    if (DatabaseHelper().isInit) await themeTemplateService.save(template);
    if (id == inUseId) themeConfig.reRender();
  }

  /// 删除主题
  Future<bool> removeThemeTemplate(ThemeTemplate template) async {
    String id = template.id.value;
    String inUseId = flexThemeConfig.templateInUse.value.id.value;
    if (id == inUseId) {
      ToastHelper().showNotification(
        leading: Icon(Icons.sms_failed_outlined, color: themeConfig.themeData.errorColor),
        title: "无法删除",
        message: "主题${template.name.value ?? "未命名"}正在使用中",
      );
      return false;
    }
    if (DatabaseHelper().isInit) {
      await themeConfigService.transaction((tx) async {
        await themeTemplateService.remove(template, tx: tx);
        flexThemeConfig.templateList.removeWhere((element) => element.id.value == template.id.value);
        await themeConfigService.save(flexThemeConfig);
      });
    } else {
      flexThemeConfig.templateList.removeWhere((element) => element.id.value == template.id.value);
    }
    return true;
  }

  /// 使用主题
  Future<void> useThemeTemplate(ThemeTemplate template) async {
    flexThemeConfig.templateInUse.value = template;
    if (DatabaseHelper().isInit) await themeConfigService.save(flexThemeConfig);
    themeConfig.reRender();
  }

  /// 添加一个主题
  /// [addToUse] 表示是否同时使用这个主题
  Future<void> addThemeTemplate(ThemeTemplate template, {bool addToUse = false}) async {
    Set<String> templateIdMap = flexThemeConfig.templateList.value.map((e) => e.id.value).toSet();
    String id = template.id.value;
    if (templateIdMap.contains(id)) return;
    flexThemeConfig.templateList.add(template);
    if (addToUse) {
      await useThemeTemplate(template);
    } else {
      if (DatabaseHelper().isInit) await themeConfigService.save(flexThemeConfig);
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
    FlexThemeConfig: ([args]) => FlexThemeConfig(),
  };
}

Map<Type, Dao> _daoGetter() {
  return {
    ThemeTemplate: SembastDataDao<ThemeTemplate>(),
    FlexThemeConfig: SembastSimpleDao<FlexThemeConfig>(),
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
    FlexThemeConfig: () => FlexThemeConfig.initData,
  };
}
