import 'dart:async';

import 'package:hg_framework/app/config.dart';
import 'package:hg_framework/util/singleton_catch.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 系统级别的kv存储库
class PrefsHelper with AppConfigItem {
  PrefsHelper._();

  factory PrefsHelper() => SingletonCache.putIfAbsent(PrefsHelper._());

  /// 第三方插件
  SharedPreferences? _prefs;

  @override
  FutureOr<void> init(AppConfig config) async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// 获取本地存储
  SharedPreferences get prefs {
    assert(isInit == true, "先初始化或者直接使用SharedPreferences.getInstance");
    return _prefs!;
  }
}
