import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';

import '../../view/components/popup_menu.dart';

class ToastHelper {
  ToastHelper._();

  /// 提示框
  static void toast({String? msg}) {
    EasyLoading.showToast(msg ?? "");
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
  static Future<bool?> showOneChoiceDeleteRequest({
    String msg = "确定删除吗?",
    String doneText = "删除",
    String cancelText = "取消",
  }) async {
    return await showRequest<bool>(
      Get.context!,
      valueList: [true],
      destructiveValue: [true],
      childBuilder: (value) {
        return Text(doneText);
      },
      message: Center(child: Text(msg)),
      cancelText: cancelText,
    );
  }

  /// 双选提示框
  static Future<bool?> showTwoChoiceDeleteRequest({
    String msg = "确定删除吗?",
    String doneText = "删除",
    String unDoneText = "不删除",
    String cancelText = "取消",
  }) async {
    return await showRequest<bool>(
      Get.context!,
      valueList: [true, false],
      defaultValue: [false],
      destructiveValue: [true],
      childBuilder: (value) {
        return Text(value ? doneText : unDoneText);
      },
      message: Center(child: Text(msg)),
      cancelText: cancelText,
    );
  }

  /// 提示框
  static Future<T?> showRequest<T>(
    BuildContext context, {
    Widget? message,
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    List<T> defaultValue = const [],
    List<T> destructiveValue = const [],
    String cancelText = "取消",
  }) async {
    switch (defaultTargetPlatform) {

      /// TODO 安卓等其他平台处理
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
      case TargetPlatform.iOS:
        return await _showCupertinoPopup(
          context,
          valueList: valueList,
          childBuilder: childBuilder,
          message: message,
          defaultValue: defaultValue,
          destructiveValue: destructiveValue,
          cancelText: cancelText,
        );
    }
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

  /// 显示漂浮菜单
  /// 出了ios都是用menu，ios使用modalPopup
  static Future<T?> showContextMenu<T>(
    BuildContext context, {
    Widget? message,
    RelativeRect? position,
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    List<T> defaultValue = const [],
    List<T> destructiveValue = const [],
    String cancelText = "取消",
  }) async {
    switch (defaultTargetPlatform) {
      // TODO android
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
        return await _showDeskTopContextMenu(context, valueList: valueList, childBuilder: childBuilder, pos: position);
      case TargetPlatform.iOS:
        return await _showCupertinoPopup(
          context,
          valueList: valueList,
          childBuilder: childBuilder,
          message: message,
          defaultValue: defaultValue,
          destructiveValue: destructiveValue,
          cancelText: cancelText,
        );
    }
  }

  /// 桌面端菜单按钮
  static Future<T?> _showDeskTopContextMenu<T>(
    BuildContext context, {
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    RelativeRect? pos,
  }) async {
    // 菜单项
    List<PopupMenuEntry<T>> items = [];
    for (int i = 0; i < valueList.length; i++) {
      T value = valueList[i];
      items.add(RawPopupMenuItem(
        value: value,
        child: childBuilder(value),
      ));
      if (i != valueList.length - 1) {
        items.add(const PopupMenuDivider());
      }
    }
    // 样式
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    // 发起菜单的组件
    final RenderBox button = context.findRenderObject()! as RenderBox;
    Offset global = button.localToGlobal(Offset.zero);
    RelativeRect position = pos ??
        RelativeRect.fromLTRB(
          global.dx + button.size.width,
          global.dy,
          Get.width,
          Get.height,
        );
    // 显示菜单
    return await showMenu<T?>(
      context: context,
      elevation: popupMenuTheme.elevation,
      items: items,
      position: position,
      shape: popupMenuTheme.shape,
      color: popupMenuTheme.color,
    );
  }

  /// ios平台的弹出菜单
  static Future<T?> _showCupertinoPopup<T>(
    BuildContext context, {
    Widget? message,
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    List<T> defaultValue = const [],
    List<T> destructiveValue = const [],
    String cancelText = "取消",
  }) async {
    ThemeData theme = AppLogic.instance.themeData;
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
          message: message == null ? null : DefaultTextStyle(style: theme.textTheme.titleLarge ?? const TextStyle(), child: message),
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            child: Text(cancelText),
            onPressed: () {
              RouteHelper.back(result: null);
            },
          ),
        );
      },
    );
  }
}
