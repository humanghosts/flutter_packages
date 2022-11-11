import 'dart:async';
import 'dart:developer';

import 'package:hg_framework/ability/desktop/window.dart';
import 'package:hg_framework/ability/entity/entity.dart';
import 'package:hg_framework/hg_framework.dart';

/// 应用配置
abstract class AppConfig {
  /// 应用名称
  String get appName;

  /// 应用版本
  String get appVersion;

  /// 应用插件
  final Map<String, AppPlugin> _plugin = {};

  /// 插件初始化位置 用于插件替换位置
  final Map<String, int> _pluginInitIndex = {};

  /// 初始化插件顺序池 用于执行插件初始化
  final Map<int, Set<String>> _indexPlugin = {};

  /// 下一个配置顺序
  int _nextPluginIndex = 0;

  /// 添加插件，如果没有指定顺序的话，会排在上一个指定位置的后面。默认的初始指定位置为0
  /// 同名插件会被覆盖
  void addPlugin(String key, AppPlugin appPlugin, {int? index}) {
    int itemIndex = index ?? _nextPluginIndex;
    _nextPluginIndex = itemIndex + 1;
    // 直接赋值，无论是否存在
    _plugin[key] = appPlugin;
    // 存在则移除
    if (_pluginInitIndex.containsKey(key)) {
      int oldItemIndex = _pluginInitIndex[key]!;
      _indexPlugin.putIfAbsent(oldItemIndex, () => {}).remove(key);
    }
    _pluginInitIndex[key] = itemIndex;
    _indexPlugin.putIfAbsent(itemIndex, () => {}).add(key);
  }

  /// 如果存在，替换插件
  /// 如果不存在新增插件，可指定新增位置
  /// 如果想要替换并指定位置，可直接使用[addPlugin]
  void replacePlugin(String key, AppPlugin configItem, {int? index}) {
    if (_plugin.containsKey(key)) {
      _plugin[key] = configItem;
    } else {
      addPlugin(key, configItem, index: index);
    }
  }

  /// 注册插件
  FutureOr<void> registerPlugin() {
    addPlugin('prefs', PrefsHelper()); // 本地存储配置
    // 大部分功能都需要设备信息，这个是刚需，没有进行未配置校验 不优先初始化的话应该会报错
    addPlugin('deviceInfo', DeviceInfoHelper()); // 设备信息配置
    addPlugin("desktopWindow", WindowHelper()); // 桌面窗口配置
    // TODO 数据库配置
    addPlugin("entity", EntityHelper()); // 实体配置
    // TODO 主题配置
    // TODO 提示配置 这个和显示层还耦合
    // TODO 通知配置
    // TODO 动画时间配置
    // TODO 资源配置
  }

  /// 初始化插件
  FutureOr<void> initPlugin() async {
    if (_indexPlugin.isEmpty) return;
    List<int> indexList = _indexPlugin.keys.toList();
    indexList.sort(); // 顺序排序
    // 按顺序执行插件初始化
    for (int index in indexList) {
      Set<String> indexPluginItemList = _indexPlugin[index] ?? {};
      if (indexPluginItemList.isEmpty) continue;
      for (String pluginKey in indexPluginItemList) {
        AppPlugin? appPlugin = _plugin[pluginKey];
        if (appPlugin == null) continue;
        log("初始化插件:$pluginKey");
        FutureOr doInit = appPlugin.doInit(this);
        if (doInit is Future) await doInit;
      }
    }
  }

  /// 配置初始化
  Future<void> init() async {
    // 注册插件
    FutureOr<void> pluginRegister = registerPlugin();
    if (pluginRegister is Future) await pluginRegister;
    // 初始化插件
    FutureOr<void> pluginInit = initPlugin();
    if (pluginInit is Future) await pluginInit;

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
  }
}

/// 应用插件
abstract class AppPlugin {
  /// 配置项目是否初始化
  bool _isInit = false;

  bool get isInit => _isInit;

  /// 执行配置初始化
  FutureOr<void> doInit(AppConfig config) async {
    if (isInit == true) return;
    FutureOr<void> initFunc = init(config);
    if (initFunc is Future) {
      await initFunc;
    }
    _isInit = true;
  }

  /// 配置初始化
  FutureOr<void> init(AppConfig config);
}
