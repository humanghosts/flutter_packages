import 'dart:async';

import 'package:hgs_framework/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:hgs_framework/framework.dart';
export 'package:shared_preferences/shared_preferences.dart';

/// 系统级别的kv存储库
class PrefsHelper with AppInitPlugin {
  PrefsHelper._();

  factory PrefsHelper() => SingletonCache.putIfAbsent(PrefsHelper._());

  /// 第三方插件
  SharedPreferences? _prefs;

  @override
  FutureOr<bool> init(AppConfig config) async {
    _prefs ??= await SharedPreferences.getInstance();
    return true;
  }

  /// 获取本地存储
  SharedPreferences get prefs {
    assert(isInit == true, "先初始化或者直接使用SharedPreferences.getInstance");
    return _prefs!;
  }
}
