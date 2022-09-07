import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:window_manager/window_manager.dart';

/// 模型构造器
typedef EntityConstructor = Object Function([Map<String, dynamic>? args]);

/// 应用配置
abstract class AppConfig {
  /// 应用名称
  String get appName;

  /// 应用版本
  String get appVersion;

  /// 应用支持的屏幕方向
  List<DeviceOrientation> get orientations => const [DeviceOrientation.portraitUp];

  /// 桌面端 窗口配置
  FutureOr<WindowOptions?> get windowOptions => null;

  /// 数据库配置
  DatabaseConfig get databaseConfig;

  /// 数据库版本修改
  Future<void> onDatabaseVersionChanged(int oldVersion, int newVersion) async {}

  /// 通知配置
  NotificationConfig get notificationConfig => NotificationConfig.instance;

  /// 预置数据
  PresetData? get presetData => null;

  /// 模型和Dao注册
  EntityAndDao? get entityAndDao => null;

  /// 云备份配置
  Clouds? get clouds => null;

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
    // prefs初始化
    await PrefsHelper.init();
    // 设备信息初始化
    await DeviceInfoHelper.init();
    // 设置设备可用方向
    SystemChrome.setPreferredOrientations(orientations);
    // 桌面端初始化设置
    if (DeviceInfoHelper.devicePlatform.isDesktop && !DeviceInfoHelper.isWeb) {
      await windowManager.ensureInitialized();
      WindowOptions? options;
      if (windowOptions is Future<WindowOptions?>) {
        options = await windowOptions;
      } else {
        options = options;
      }
      await windowManager.waitUntilReadyToShow(options, () async {
        await windowManager.show();
        await windowManager.focus();
        await windowManager.setTitle(appName);
      });
    }
  }

  /// 初始化
  /// 0. 调用beforeInit
  /// 1. 注册framework下的构造器
  /// 2. 注册传入的构造器
  /// 3. 打开数据库
  /// 4. 注册framework下的dao
  /// 5. 注册传入的dao
  /// 6. 检查数据库版本是否发生变更，决定是否回调appConfig
  /// 7. 处理预置数据
  /// 8. 处理业务初始化(回调appLogic.onAppInit)
  /// 9. 初始化通知
  /// 10. 初始化云服务 如果有的话
  /// 11. 初始化就近同步服务
  /// ∞. 调用afterInit
  Future<void> init() async {
    await beforeInit();
    // 当前包下的模型和dao注册
    _getEntitiesMap().forEach(ConstructorCache.put);
    // 传入的模型和dao注册
    Map<Type, EntityConstructor>? entityMap = entityAndDao?.getEntityMap?.call();
    Map<Type, List<String>>? entityAlias = entityAndDao?.getEntityAlias?.call();
    entityMap?.forEach((key, value) {
      List<String>? alias = entityAlias?[key];
      ConstructorCache.put(key, value, alias: alias ?? []);
    });
    LogHelper.info("[数据库]:打开数据库");
    await DatabaseHelper.open(config: databaseConfig);
    _getDaoMap().forEach(DaoCache.put);
    entityAndDao?.getDaoMap?.call().forEach(DaoCache.put);
    // 数据库版本变更
    int oldVersion = DatabaseHelper.database.oldVersion;
    int newVersion = DatabaseHelper.database.version;
    if (oldVersion != newVersion) await onDatabaseVersionChanged(oldVersion, newVersion);
    // 预置数据
    await _presetDataInit(presetData);
    // 主题等数据加载
    await appLogic.onAppInit(this);
    // 初始化通知服务
    await NotificationHelper.init();
    // 初始化云服务
    if (null != clouds) await CloudHelper.init(clouds!);
    await afterInit();
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

/// 所有的模型构造方法和Dao注册
/// Entity注册的时候需要注意依赖关系，被依赖的先注册
/// 如果相互依赖，在先注册entity的构造方法中手动构建后注册的对象，默认对于Model类型的时候通过类型去构造器缓存中取
class EntityAndDao {
  late final Map<Type, EntityConstructor> Function()? getEntityMap;
  late final Map<Type, Dao> Function()? getDaoMap;
  late final Map<Type, List<String>> Function()? getEntityAlias;

  EntityAndDao({this.getEntityMap, this.getDaoMap, this.getEntityAlias});
}

/// 预置数据
class PresetData {
  final Map<Type, List<DataModel> Function()>? Function()? dataModelMap;
  final Map<Type, SimpleModel Function()>? Function()? simpleModelMap;

  PresetData({this.dataModelMap, this.simpleModelMap});
}

/// 首次启动初始化预置数据
Future<void> _presetDataInit(PresetData? presetData) async {
  String key = "is_preset_data_init";
  int version = DatabaseHelper.database.version;
  LogHelper.info("[数据库预置数据]:数据库版本$version");
  bool? isInitData;
  bool? isPrefsInit = PrefsHelper.prefs.getBool(key);
  if (isPrefsInit != null) {
    isInitData = isPrefsInit;
    await DatabaseHelper.database.kv.putSave(key, isPrefsInit);
  } else {
    isInitData = DatabaseHelper.database.kv.get(key);
  }
  LogHelper.info("[数据库预置数据]:数据库${isInitData == true ? "已" : "未"}初始化");
  if (isInitData == true) return;
  Map<Type, List<DataModel> Function()> dataModelMap = presetData?.dataModelMap?.call() ?? {};
  Map<Type, SimpleModel Function()> simpleModelMap = presetData?.simpleModelMap?.call() ?? {};
  dataModelMap.addAll(_getDataModelInitData());
  simpleModelMap.addAll(_getSimpleModelInitData());
  // 插入数据
  await DatabaseHelper.transaction((tx) async {
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
  await DatabaseHelper.database.kv.putSave(key, true);
}

/// 注册entity
Map<Type, EntityConstructor> _getEntitiesMap() {
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

/// 注册dao
Map<Type, Dao> _getDaoMap() {
  return {
    ThemeTemplate: SembastDataDao<ThemeTemplate>(),
    ThemeConfig: SembastSimpleDao<ThemeConfig>(),
  };
}

/// 数据模型的初始化数据
Map<Type, List<DataModel> Function()> _getDataModelInitData() {
  return {
    ThemeTemplate: () => ThemeTemplate.initData,
  };
}

/// 简单模型的初始化数据
Map<Type, SimpleModel Function()> _getSimpleModelInitData() {
  return {
    ThemeConfig: () => ThemeConfig.initData,
  };
}
