import 'dart:async';
import 'dart:developer';

import 'package:hg_framework/hg_framework.dart';
import 'package:theme/theme.dart';

abstract class AppWithPlugin<T> {
  /// 应用插件
  final Map<String, T> _plugin = {};

  /// 插件初始化位置 用于插件替换位置
  final Map<String, int> _pluginIndex = {};

  /// 初始化插件顺序池 用于执行插件初始化
  final Map<int, Set<String>> _indexedPlugin = {};

  /// 下一个配置顺序
  int _nextPluginIndex = 0;

  /// 添加插件，如果没有指定顺序的话，会排在上一个指定位置的后面。默认的初始指定位置为0
  /// 同名插件会被覆盖
  void addPlugin(String key, T appPlugin, {int? index}) {
    int itemIndex = index ?? _nextPluginIndex;
    _nextPluginIndex = itemIndex + 1;
    // 直接赋值，无论是否存在
    _plugin[key] = appPlugin;
    // 存在则移除
    if (_pluginIndex.containsKey(key)) {
      int oldItemIndex = _pluginIndex[key]!;
      _indexedPlugin.putIfAbsent(oldItemIndex, () => {}).remove(key);
    }
    _pluginIndex[key] = itemIndex;
    _indexedPlugin.putIfAbsent(itemIndex, () => {}).add(key);
  }

  /// 如果存在，替换插件
  /// 如果不存在新增插件，可指定新增位置
  /// 如果想要替换并指定位置，可直接使用[addPlugin]
  void replacePlugin(String key, T plugin, {int? index}) {
    if (_plugin.containsKey(key)) {
      _plugin[key] = plugin;
    } else {
      addPlugin(key, plugin, index: index);
    }
  }

  /// 注册插件
  FutureOr<void> registerPlugin();

  /// 执行插件
  FutureOr<void> run() async {
    FutureOr pluginRegister = registerPlugin();
    if (pluginRegister is Future) await pluginRegister;
    if (_indexedPlugin.isEmpty) return;
    List<int> indexList = _indexedPlugin.keys.toList();
    indexList.sort(); // 顺序排序
    // 按顺序执行插件初始化
    for (int index in indexList) {
      Set<String> indexPluginItemList = _indexedPlugin[index] ?? {};
      if (indexPluginItemList.isEmpty) continue;
      for (String pluginKey in indexPluginItemList) {
        T? plugin = _plugin[pluginKey];
        if (plugin == null) continue;
        FutureOr<void> donePlugin = doPlugin(pluginKey, plugin);
        if (donePlugin is Future) await donePlugin;
      }
    }
  }

  /// 执行单个插件
  FutureOr<void> doPlugin(String key, T plugin);
}

/// 应用初始化插件
abstract class AppInitPlugin {
  bool _isInit = false;

  /// 插件是否初始化
  bool get isInit => _isInit;

  /// 执行插件初始化
  FutureOr<void> doInit(AppConfig config) async {
    if (isInit == true) return;
    FutureOr<bool> initFunc = init(config);
    if (initFunc is Future) {
      _isInit = await initFunc;
    } else {
      _isInit = initFunc;
    }
  }

  /// 插件初始化
  FutureOr<bool> init(AppConfig config);
}

/// 应用初始化
class AppInit extends AppWithPlugin<AppInitPlugin> {
  /// 不私有化的原因是为了继承
  AppInit.create();

  factory AppInit() => SingletonCache.putIfAbsent(AppInit.create());

  /// 注册插件
  @override
  FutureOr<void> registerPlugin() {
    addPlugin('prefs', PrefsHelper()); // 本地存储配置
    // 大部分功能都需要设备信息，这个是刚需，没有进行未配置校验 不优先初始化的话应该会报错
    addPlugin('deviceInfo', DeviceInfoHelper()); // 设备信息配置
    addPlugin("desktopWindow", WindowHelper()); // 桌面窗口配置
    addPlugin("entity", EntityHelper()); // 实体配置
    addPlugin("database", DatabaseHelper()); // 数据库配置
    addPlugin("theme", ThemeHelper()); // 主题配置
    addPlugin("notification", NotificationHelper()); // 通知配置
    addPlugin("app", AppLogic()); // 应用初始化 这个必须初始化
  }

  @override
  FutureOr<void> doPlugin(String key, AppInitPlugin plugin) async {
    log("初始化插件:$key");
    FutureOr doInit = plugin.doInit(appConfig);
    if (doInit is Future) await doInit;
  }
}

/// 应用构建插件
abstract class AppBuildPlugin {
  bool _isBuild = false;

  /// 插件是否构建
  bool get isBuild => _isBuild;

  /// 执行构建
  FutureOr<void> doBuild(AppConfig config) async {
    if (isBuild == true) return;
    FutureOr<bool> buildFunc = build(config);
    if (buildFunc is Future) {
      _isBuild = await buildFunc;
    } else {
      _isBuild = buildFunc;
    }
  }

  /// 插件构建
  FutureOr<bool> build(AppConfig config);
}

/// 应用构建
class AppBuild extends AppWithPlugin<AppBuildPlugin> {
  /// 不私有化的原因是为了继承
  AppBuild.create();

  factory AppBuild() => SingletonCache.putIfAbsent(AppBuild.create());

  @override
  FutureOr<void> doPlugin(String key, AppBuildPlugin plugin) async {
    log("构建插件:$key");
    FutureOr doBuild = plugin.doBuild(appConfig);
    if (doBuild is Future) await doBuild;
  }

  @override
  FutureOr<void> registerPlugin() {
    addPlugin("theme", ThemeHelper());
  }
}

/// 应用刷新插件
abstract class AppRebuildPlugin {
  bool _isRebuild = false;

  /// 插件是否构建
  bool get isRebuild => _isRebuild;

  /// 执行构建
  FutureOr<void> doRebuild(AppConfig config) async {
    if (isRebuild == true) return;
    FutureOr<bool> rebuildFunc = rebuild(config);
    if (rebuildFunc is Future) {
      _isRebuild = await rebuildFunc;
    } else {
      _isRebuild = rebuildFunc;
    }
  }

  /// 插件构建
  FutureOr<bool> rebuild(AppConfig config);
}

/// 应用刷新
class AppRebuild extends AppWithPlugin<AppRebuildPlugin> {
  /// 不私有化的原因是为了继承
  AppRebuild.create();

  factory AppRebuild() => SingletonCache.putIfAbsent(AppRebuild.create());

  @override
  FutureOr<void> doPlugin(String key, AppRebuildPlugin plugin) async {
    log("刷新插件:$key");
    FutureOr doRefresh = plugin.doRebuild(appConfig);
    if (doRefresh is Future) await doRefresh;
  }

  @override
  FutureOr<void> registerPlugin() {
    addPlugin("database", DatabaseHelper());
    addPlugin("theme", ThemeHelper());
    addPlugin("notification", NotificationHelper());
    addPlugin("appLogic", AppLogic());
  }
}
