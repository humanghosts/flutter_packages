import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_framework/hg_framework.dart';

import '../../view/components/popup_menu.dart';

class ToastHelper {
  ToastHelper._();

  /// 提示框
  static void toast({String? msg}) {
    EasyLoading.showToast(msg ?? "");
  }

  /// 应用内提示
  static void inAppNotification({
    Widget? leading,
    String? title,
    Widget? titleWidget,
    String? message,
    Widget? messageWidget,
    String? key,
    Color? background,
    VoidCallback? onTap,
  }) {
    String key = UUIDGenerator.instance.id;
    AppLogic.instance.showNotification(
      key,
      Clickable(
        child: Card(
          color: background,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                if (null != leading) ...[
                  leading,
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget ??
                          Text(
                            title ?? "",
                            style: AppLogic.instance.themeData.textTheme.bodyText1,
                          ),
                      if (message != null || title != null || messageWidget != null)
                        messageWidget ??
                            Text(
                              message ?? title ?? "",
                              style: AppLogic.instance.themeData.textTheme.bodyText2,
                            ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Clickable(
                  child: const Icon(Icons.close_outlined),
                  onTap: () {
                    AppLogic.instance.closeNotification(key);
                  },
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          AppLogic.instance.closeNotification(key);
          onTap?.call();
        },
      ),
    );
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
    switch (DeviceInfoHelper.platform) {

      /// TODO 安卓等其他平台处理
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
      case TargetPlatform.iOS:
        return await showCupertinoPopup(
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

  /// 蒙版构建器
  static void overlayBuilder(
    Widget Function(BuildContext context) builder, {
    Widget Function(BuildContext context)? backgroundBuilder,
    // 关闭弹框方法
    void Function(VoidCallback action)? close,
  }) {
    ThemeData themeData = AppLogic.instance.themeData;
    BuildContext context = Get.overlayContext!;
    NavigatorState navigatorState = Navigator.of(context, rootNavigator: true);
    OverlayState overlayState = navigatorState.overlay!;

    OverlayEntry overlayEntryOpacity = OverlayEntry(builder: (context) {
      return backgroundBuilder?.call(context) ??
          Opacity(
            opacity: 0.9,
            child: Container(
              color: themeData.primaryColor.withOpacity(0.9),
            ),
          );
    });
    OverlayEntry? overlayEntryLoader;
    overlayEntryLoader = OverlayEntry(builder: (context) {
      return builder(context);
    });
    overlayState.insert(overlayEntryOpacity);
    overlayState.insert(overlayEntryLoader);
    // 关闭方法
    close?.call(() {
      overlayEntryLoader?.remove();
      overlayEntryOpacity.remove();
    });
  }

  /// 显示漂浮菜单
  /// 出了ios都是用menu，ios使用modalPopup
  static Future<T?> showContextMenu<T>(
    BuildContext context, {
    Widget? message,
    required Offset position,
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    List<T> defaultValue = const [],
    List<T> destructiveValue = const [],
    String cancelText = "取消",
  }) async {
    switch (DeviceInfoHelper.platform) {
      // TODO android
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
        return await showDeskTopContextMenu(context, valueList: valueList, childBuilder: childBuilder, position: position);
      case TargetPlatform.iOS:
        return await showCupertinoPopup(
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
  static Future<T?> showDeskTopContextMenu<T>(
    BuildContext context, {
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    required Offset position,
  }) async {
    // 菜单项
    List<PopupMenuEntry<T>> items = [];
    for (int i = 0; i < valueList.length; i++) {
      T value = valueList[i];
      items.add(RawPopupMenuItem(
        value: value,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: childBuilder(value),
      ));
      if (i != valueList.length - 1) {
        items.add(const PopupMenuDivider(height: 6));
      }
    }
    // 样式
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    RelativeRect relativeRect = RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      Get.width - position.dx,
      Get.height - position.dy,
    );
    // 显示菜单
    return await showMenu<T?>(
      context: context,
      elevation: popupMenuTheme.elevation,
      items: items,
      position: relativeRect,
      shape: popupMenuTheme.shape,
      color: popupMenuTheme.color,
    );
  }

  /// ios平台的弹出菜单
  static Future<T?> showCupertinoPopup<T>(
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
