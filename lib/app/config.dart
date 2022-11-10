import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hg_framework/ability/desktop/window.dart';
import 'package:hg_framework/hg_framework.dart';

/// 应用配置
abstract class AppConfig {
  /// 应用名称
  String get appName;

  /// 应用版本
  String get appVersion;

  /// 应用配置项
  final Map<String, AppConfigItem> _configItem = {};

  /// 应用配置项启动顺序 从小到达排序 同顺序按照插入顺序执行初始化
  final Map<String, int> _configIndex = {};
  final Map<int, Set<String>> _indexConfig = {};

  /// 下一个配置顺序
  int _nextConfigIndex = 0;

  /// 添加配置，如果没有指定顺序的话，会排在上一个指定位置的后面。默认的初始指定位置为0
  /// 同名配置会被覆盖
  void addConfig(String key, AppConfigItem configItem, {int? index}) {
    int itemIndex = index ?? _nextConfigIndex;
    _nextConfigIndex = itemIndex + 1;
    // 直接赋值，无论是否存在
    _configItem[key] = configItem;
    // 存在则移除
    if (_configIndex.containsKey(key)) {
      int oldItemIndex = _configIndex[key]!;
      _indexConfig.putIfAbsent(oldItemIndex, () => {}).remove(key);
    }
    _configIndex[key] = itemIndex;
    _indexConfig.putIfAbsent(itemIndex, () => {}).add(key);
  }

  /// 如果存在，替换配置
  /// 如果不存在新增配置，可指定新增位置
  /// 如果想要替换并指定位置，可直接使用[addConfig]
  void replaceConfig(String key, AppConfigItem configItem, {int? index}) {
    if (_configItem.containsKey(key)) {
      _configItem[key] = configItem;
    } else {
      addConfig(key, configItem, index: index);
    }
  }

  /// 设置配置
  Future<void> setConfig() async {
    addConfig('prefs', PrefsHelper()); // 本地存储配置
    // 大部分功能都需要设备信息，这个是刚需，没有进行未配置校验 不优先初始化的话应该会报错
    addConfig('deviceInfo', DeviceInfoHelper()); // 设备信息配置
    addConfig("desktopWindow", WindowHelper()); // 桌面窗口配置
    // TODO 数据库配置
    // TODO 主题配置
    // TODO 提示配置 这个和显示层还耦合
    // TODO 通知配置
    // TODO 动画时间配置
  }

  /// TODO 执行注册的配置
  Future<void> init() async {
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

  /// 所有设置执行之后的回调
  FutureOr<void> afterInit() {}
}

/// 应用功能配置项
abstract class AppConfigItem {
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
