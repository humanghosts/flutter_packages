import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hg_framework/app/app_logic.dart';

import '../export.dart';

class ToastHelper {
  ToastHelper._();

  /// 提示框
  static void toast({
    String? msg,
    ToastGravity? gravity,
  }) {
    ThemeData themeData = AppLogic.instance.themeData;
    Fluttertoast.showToast(msg: msg ?? "", backgroundColor: themeData.disabledColor, gravity: gravity ?? ToastGravity.CENTER);
  }

  /// 应用内提示
  static SnackbarController inAppNotification({String? title, String? message}) {
    SnackbarController controller = Get.snackbar(
      "",
      "",
      titleText: title == null ? null : Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      messageText: message == null ? null : Text(message),
      duration: const Duration(minutes: 1),
    );
    HapticFeedback.vibrate();
    return controller;
  }

  /// 单选提示框
  /// TODO 安卓等其他平台处理
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
              onPressed: () {
                HapticFeedback.lightImpact();
                RouteHelper.back(result: true);
              },
              isDestructiveAction: true,
              child: Text(doneText),
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

  /// 双选提示框
  /// TODO 安卓等其他平台处理
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
              onPressed: () {
                HapticFeedback.lightImpact();
                RouteHelper.back(result: true);
              },
              isDefaultAction: true,
              child: Text(doneText, style: const TextStyle(color: Colors.green)),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                HapticFeedback.lightImpact();
                RouteHelper.back(result: false);
              },
              isDestructiveAction: true,
              child: Text(unDoneText),
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

  /// 双选提示框
  /// TODO 安卓等其他平台处理
  static Future<T?> showRequest<T>(
    BuildContext context, {
    Widget? message,
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    List<T> defaultValue = const [],
    List<T> destructiveValue = const [],
  }) async {
    return await showCupertinoModalPopup<T>(
      context: context,
      builder: (context) {
        List<CupertinoActionSheetAction> actions = valueList.map((value) {
          return CupertinoActionSheetAction(
            onPressed: () {
              RouteHelper.back(result: value);
            },
            isDefaultAction: defaultValue.contains(value),
            isDestructiveAction: destructiveValue.contains(value),
            child: childBuilder(value),
          );
        }).toList();
        return CupertinoActionSheet(
          message: message,
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            child: const Text("取消"),
            onPressed: () {
              RouteHelper.back(result: null);
            },
          ),
        );
      },
    );
  }

  /// 显示蒙版
  static void overlay(Widget widget, {Color? backgroundColor, bool Function()? canClose, VoidCallback? onClose}) {
    ThemeData themeData = AppLogic.instance.themeData;
    overlayBuilder((loader, background) {
      return GestureDetector(
        child: Scaffold(
          backgroundColor: backgroundColor ?? themeData.primaryColor.withOpacity(0.9),
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
    ThemeData themeData = AppLogic.instance.themeData;
    NavigatorState navigatorState = Navigator.of(Get.overlayContext!, rootNavigator: true);
    OverlayState overlayState = navigatorState.overlay!;

    OverlayEntry overlayEntryOpacity = OverlayEntry(builder: (context) {
      return Opacity(opacity: opacity, child: Container(color: themeData.primaryColor.withOpacity(0.9)));
    });
    OverlayEntry? overlayEntryLoader;
    overlayEntryLoader = OverlayEntry(builder: (context) {
      return builder(overlayEntryLoader, overlayEntryOpacity);
    });
    overlayState.insert(overlayEntryOpacity);
    overlayState.insert(overlayEntryLoader);
  }
}
