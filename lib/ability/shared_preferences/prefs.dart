import 'package:shared_preferences/shared_preferences.dart';

/// 系统级别的kv存储库
class PrefsHelper {
  PrefsHelper._();

  static SharedPreferences? _prefs;

  /// 初始化
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    assert(_prefs != null, "先初始化或者直接使用SharedPreferences.getInstance");
    return _prefs!;
  }
}
