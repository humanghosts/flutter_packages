import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/view/export.dart';

/// 用户引导工具
/// 因为所有页面的引导不是一次性完成，所以需要分页面保存是否引导
/// 页面引导开关的逻辑是：
/// 1. 任何页面第一次访问都会显示引导，不关主页面引导是否开启
/// 2. 之后开启和关闭主页面引导会同时开启和关闭子页面的引导
class TutorialHelper {
  TutorialHelper._();

  /// 是否强制关闭所有用户引导
  static bool getForceCloseAll() {
    return SharedPreferencesHelper.prefs.getBool(SharedPreferencesKeys.isCloseAllTutorial) ?? false;
  }

  /// 是否强制关闭所有用户引导
  static Future<void> setForceCloseAll(bool forceClose) async {
    await SharedPreferencesHelper.prefs.setBool(SharedPreferencesKeys.isCloseAllTutorial, forceClose);
  }

  /// 设置页面是否显示
  static Future<void> setIsTutorial(HomePages homePage, bool isShow, [String? subKey, bool withSub = false]) async {
    String key = _getKey(homePage, subKey);
    await SharedPreferencesHelper.prefs.setBool(key, isShow);
    Set<String> storedSubPageList = getSubPageSet(homePage);
    if (null != subKey) {
      if (!storedSubPageList.contains(subKey)) {
        storedSubPageList.add(key);
        await setSubPageSet(homePage, storedSubPageList);
      }
    } else {
      if (!withSub) return;
      for (String storedSubKey in storedSubPageList) {
        await SharedPreferencesHelper.prefs.setBool(storedSubKey, isShow);
      }
    }
  }

  /// 获取页面是否显示
  static bool getIsTutorial(HomePages homePage, [String? subKey]) {
    return SharedPreferencesHelper.prefs.getBool(_getKey(homePage, subKey)) ?? true;
  }

  /// 获取页面key
  static String _getKey(HomePages homePage, [String? subKey]) {
    return "is_${homePage.value}_tutorial${subKey == null ? "" : "_$subKey"}";
  }

  /// 获取已经存储的素有子页面key
  static Set<String> getSubPageSet(HomePages homePage) {
    return SharedPreferencesHelper.prefs.getStringList(getSubPageListKey(homePage))?.toSet() ?? {};
  }

  /// 存储的所有子页面key
  static Future<void> setSubPageSet(HomePages homePage, Set<String> subPageKeyList) async {
    await SharedPreferencesHelper.prefs.setStringList(getSubPageListKey(homePage), subPageKeyList.toList());
  }

  /// 获取子页面存储的的key
  static String getSubPageListKey(HomePages homePage) {
    return "is_${homePage.value}_sub_page_list";
  }
}
