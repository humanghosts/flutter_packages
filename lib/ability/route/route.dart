import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';

/// 路由管理配置类
/// TODO 低成本封装 就是把Get包了一层，加了一个默认参数
/// 后面还是改成监听路由变动比较好 路由直接用get就好了
class RouteHelper {
  RouteHelper._();

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
      enterBottomSheetDuration: appConfig.animationConfig.middleAnimationDuration,
      exitBottomSheetDuration: appConfig.animationConfig.middleAnimationDuration,
    );
  }

  static void back({int? id, Object? result}) {
    Get.back(id: id, result: result);
  }

  /// 打开新的页面
  static Future<T?> to<T>({
    int? id,
    required Widget page,
    String? name,
    bool fullScreenDialog = false,
  }) async {
    String routeName = name ?? getRouteName(page);
    register("/$routeName", page);
    return await Get.to<T>(
      () => page,
      id: id,
      routeName: routeName,
      fullscreenDialog: fullScreenDialog,
      duration: appConfig.animationConfig.slowAnimationDuration,
    );
  }

  /// 压入给定的page，然后在堆栈中弹出多个页面，直到predicate返回 true
  static Future<T?> offUntilAndToPage<T>({int? id, required Widget page, required RoutePredicate predicate, String? name}) async {
    String routeName = name ?? getRouteName(page);
    register("/$routeName", page);
    return await Get.offUntil<T>(GetPageRoute(page: () => page, routeName: routeName), predicate, id: id);
  }

  /// 获取路由名称
  static String getRouteName(Widget widget) {
    return widget.runtimeType.toString() + widget.hashCode.toString();
  }

  static Future<T?> dialog<T>(
    Widget widget, {
    bool? barrierDismissible,
    Color? barrierColor,
    bool? useSafeArea,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) async {
    return await Get.dialog(
      widget,
      barrierDismissible: barrierDismissible ?? false,
      barrierColor: barrierColor ?? getOnColor(appLogic.themeData.dialogBackgroundColor).withOpacity(0.1),
      useSafeArea: useSafeArea ?? true,
      navigatorKey: navigatorKey,
      arguments: arguments,
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      name: name,
      routeSettings: routeSettings,
    );
  }
}
