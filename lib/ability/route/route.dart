import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/app/app_logic.dart';

import 'observer.dart';

/// 路由管理配置类
class RouteHelper {
  /// 中间件集合
  static Map<String, Function(ObserverRouting? routing)?> observerMap = {};

  /// 注册回调
  static register(String name, Widget widget) {
    if (widget is! ObserverWidget) {
      return;
    }
    observerMap[name] = (widget as ObserverWidget).observe;
  }

  /// 中间件回调
  /// 用于app的路由监听
  static observer(ObserverRouting? routing) {
    if (null == routing) return;
    String routeName = routing.current;
    observerMap[routeName]?.call(routing);
    if (routing.isBack == true) {
      observerMap.remove(routeName);
    }
  }

  /// 底部弹框页面
  static Future<T?> bottomSheet<T>({
    required Widget sheet,
    String? name,
    Color? barrierColor,
  }) async {
    String routeName = name ?? getRouteName(sheet);
    register(routeName, sheet);
    return await Get.bottomSheet(
      sheet,
      settings: RouteSettings(name: routeName),
      barrierColor: barrierColor,
      enterBottomSheetDuration: AppLogic.appConfig.animationConfig.middleAnimationDuration,
      exitBottomSheetDuration: AppLogic.appConfig.animationConfig.middleAnimationDuration,
    );
  }

  static void back({int? id, Object? result}) {
    Get.back(id: id, result: result);
  }

  /// 打开新的页面
  static void to({
    int? id,
    required Widget page,
    String? name,
    bool fullScreenDialog = false,
  }) {
    String routeName = name ?? getRouteName(page);
    register("/$routeName", page);
    Get.to(
      () => page,
      id: id,
      routeName: routeName,
      fullscreenDialog: fullScreenDialog,
      duration: AppLogic.appConfig.animationConfig.middleAnimationDuration,
    );
  }

  /// 压入给定的page，然后在堆栈中弹出多个页面，直到predicate返回 true
  static void offUntilAndToPage({int? id, required Widget page, required RoutePredicate predicate, String? name}) {
    String routeName = name ?? getRouteName(page);
    register("/$routeName", page);
    Get.offUntil(GetPageRoute(page: () => page, routeName: routeName), predicate, id: id);
  }

  /// 获取路由名称
  static String getRouteName(Widget widget) {
    return widget.runtimeType.toString() + widget.hashCode.toString();
  }
}
