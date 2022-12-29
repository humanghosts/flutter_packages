import 'dart:async';
import 'dart:convert';

import 'package:hgs_framework/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:hgs_framework/framework.dart';
export 'package:shared_preferences/shared_preferences.dart';

/// 系统级别的kv存储库
class PrefsHelper with AppInitPlugin {
  PrefsHelper._();

  factory PrefsHelper() => SingletonCache.putIfAbsent(PrefsHelper._());

  /// 第三方插件
  late final SharedPreferences prefs;

  @override
  FutureOr<bool> init(AppConfig config) async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  Object? get(String key) => prefs.get(key);

  bool? getBool(String key) => prefs.getBool(key);

  int? getInt(String key) => prefs.getInt(key);

  double? getDouble(String key) => prefs.getDouble(key);

  String? getString(String key) => prefs.getString(key);

  T? getObject<T>(String key, {Object? Function(Object? key, Object? value)? reviver}) {
    String? objStr = prefs.getString(key);
    if (null == objStr) return null;
    return jsonDecode(objStr, reviver: reviver) as T?;
  }

  List<String>? getStringList(String key) => prefs.getStringList(key);

  Future<bool> setBool(String key, bool value) async => await prefs.setBool(key, value);

  Future<bool> setInt(String key, int value) async => await prefs.setInt(key, value);

  Future<bool> setDouble(String key, double value) async => await prefs.setDouble(key, value);

  Future<bool> setString(String key, String value) async => await prefs.setString(key, value);

  Future<bool> setStringList(String key, List<String> value) async => await prefs.setStringList(key, value);

  Future<bool> setObject(String key, Object value, {Object? Function(Object? nonEncodable)? toEncodable}) async {
    return await prefs.setString(key, jsonEncode(value, toEncodable: toEncodable));
  }

  bool containsKey(String key) => prefs.containsKey(key);

  Future<bool> remove(String key) async => await prefs.remove(key);

  Future<void> reload() async => await prefs.reload();

  Future<bool> clear() async => await prefs.clear();
}
