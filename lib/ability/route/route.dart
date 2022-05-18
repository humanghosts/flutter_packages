import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../config.dart';
import '../../main.dart';
import '../sound/export.dart';
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

  /// 单选提示框
  static Future<bool?> showOneChoiceRequest({
    String msg = "确定删除吗?",
    String doneText = "删除",
    String cancelText = "取消",
  }) async {
    return await showCupertinoModalPopup<bool>(
      context: Get.context!,
      barrierDismissible: false,
      semanticsDismissible: false,
      builder: (context) {
        return CupertinoActionSheet(
          message: Text(msg, style: const TextStyle(fontSize: 20)),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(doneText),
              onPressed: () {
                HapticFeedback.lightImpact();
                RouteHelper.back(result: true);
              },
              isDestructiveAction: true,
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(cancelText),
            onPressed: () {
              HapticFeedback.lightImpact();
              RouteHelper.back(result: false);
            },
          ),
        );
      },
    );
  }

  static Future<bool?> showTwoChoiceRequest({
    String msg = "确定删除吗?",
    String doneText = "删除",
    String unDoneText = "不删除",
    String cancelText = "取消",
  }) async {
    return await showCupertinoModalPopup<bool>(
      context: Get.context!,
      builder: (context) {
        return CupertinoActionSheet(
          message: Text(msg, style: const TextStyle(fontSize: 20)),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(doneText, style: const TextStyle(color: Colors.green)),
              onPressed: () {
                HapticFeedback.lightImpact();
                RouteHelper.back(result: true);
              },
              isDefaultAction: true,
            ),
            CupertinoActionSheetAction(
              child: Text(unDoneText),
              onPressed: () {
                HapticFeedback.lightImpact();
                RouteHelper.back(result: false);
              },
              isDestructiveAction: true,
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(cancelText),
            onPressed: () {
              HapticFeedback.lightImpact();
              RouteHelper.back(result: null);
            },
          ),
        );
      },
    );
  }

  /// 提示框
  static void toast({
    String? msg,
    ToastGravity? gravity,
  }) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    Fluttertoast.showToast(msg: msg ?? "", backgroundColor: themeData.disabledColor, gravity: gravity ?? ToastGravity.CENTER);
  }

  /// 应用内提示
  static void inAppNotification({String? title, String? message}) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    Get.snackbar(
      "",
      "",
      titleText: title == null ? null : Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      messageText: message == null ? null : Text(message),
      duration: const Duration(minutes: 1),
      backgroundColor: themeData.baseColor,
      overlayBlur: themeData.depth,
      overlayColor: themeData.defaultTextColor.withOpacity(0.1),
      borderColor: themeData.borderColor,
      borderWidth: themeData.borderWidth,
    );
    SoundHelper.playNotification(Sounds.ding);
    HapticFeedback.vibrate();
  }

  /// 显示蒙版
  static void overlay(Widget widget, {Color? backgroundColor, bool Function()? canClose, VoidCallback? onClose}) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    overlayBuilder((loader, background) {
      return GestureDetector(
        child: Scaffold(
          backgroundColor: backgroundColor ?? themeData.baseColor.withOpacity(0.9),
          body: widget,
        ),
        onTap: () {
          bool close = canClose?.call() ?? true;
          if (!close) return;
          loader!.remove();
          background.remove();
          onClose?.call();
        },
      );
    });
  }

  /// 蒙版构建器
  static void overlayBuilder(Widget Function(OverlayEntry? loader, OverlayEntry background) builder, {double opacity = 0.9}) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    NavigatorState navigatorState = Navigator.of(Get.overlayContext!, rootNavigator: true);
    OverlayState overlayState = navigatorState.overlay!;

    OverlayEntry overlayEntryOpacity = OverlayEntry(builder: (context) {
      return Opacity(opacity: opacity, child: Container(color: themeData.baseColor.withOpacity(0.9)));
    });
    OverlayEntry? overlayEntryLoader;
    overlayEntryLoader = OverlayEntry(builder: (context) {
      return builder(overlayEntryLoader, overlayEntryOpacity);
    });
    overlayState.insert(overlayEntryOpacity);
    overlayState.insert(overlayEntryLoader);
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
      enterBottomSheetDuration: AppConfig.animationConfig.middleAnimationDuration,
      exitBottomSheetDuration: AppConfig.animationConfig.middleAnimationDuration,
    );
  }

  static Future<T?> cupertinoBottomSheet<T>({
    required Widget sheet,
    String? name,
    Color? barrierColor,
    bool expand = false,
  }) async {
    String routeName = name ?? getRouteName(sheet);
    register(routeName, sheet);
    return await showCupertinoModalBottomSheet(
      context: Get.context!,
      builder: (context) => sheet,
      expand: expand,
      settings: RouteSettings(name: routeName),
      barrierColor: barrierColor,
      enableDrag: false,
      duration: AppConfig.animationConfig.middleAnimationDuration,
    );
  }

  /// 使用嵌套路由打开页面
  static Future<T?> bottomPageNested<T>({
    required int parentId,
    required int nestedId,
    required Widget page,
    String? name,
    bool expand = true,
  }) async {
    String routeName = name ?? getRouteName(page);
    register("/" + routeName, page);
    GlobalKey<NavigatorState> getKey = Get.nestedKey(parentId)!;
    BuildContext? context = getKey.currentState?.context;
    context ??= Get.context!;
    return await showCupertinoModalBottomSheet<T>(
      context: context,
      expand: expand,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      duration: AppConfig.animationConfig.middleAnimationDuration,
      enableDrag: false,
      builder: (BuildContext context) {
        return WillPopScope(
          child: Navigator(
            key: Get.nestedKey(nestedId),
            initialRoute: "/",
            onGenerateRoute: (RouteSettings settings) {
              if (settings.name == "/") {
                return MaterialWithModalsPageRoute(builder: (context) => page, settings: settings);
              }
              return null;
            },
            observers: [Observer(observer, ObserverRouting())],
          ),
          onWillPop: () async => false,
        );
      },
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
    register("/" + routeName, page);
    Get.to(
      () => page,
      id: id,
      routeName: routeName,
      fullscreenDialog: fullScreenDialog,
      duration: AppConfig.animationConfig.middleAnimationDuration,
    );
  }

  /// 压入给定的page，然后在堆栈中弹出多个页面，直到predicate返回 true
  static void offUntilAndToPage({int? id, required Widget page, required RoutePredicate predicate, String? name}) {
    String routeName = name ?? getRouteName(page);
    register("/" + routeName, page);
    Get.offUntil(GetPageRoute(page: () => page, routeName: routeName), predicate, id: id);
  }

  /// 获取路由名称
  static String getRouteName(Widget widget) {
    return widget.runtimeType.toString() + widget.hashCode.toString();
  }
}
