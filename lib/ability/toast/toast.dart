import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_framework/hg_framework.dart';

class ToastHelper {
  ToastHelper._();

  /// 提示框
  static Future<void> toast({String? msg, Duration? duration}) async {
    String key = "toast_${msg.hashCode}";
    AppLogic.instance.showOverlay(
      key: key,
      widget: GestureDetector(
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Text(msg ?? ""),
              ),
            ),
          ),
        ),
        onTap: () {
          AppLogic.instance.closeOverlay(key);
        },
      ),
      background: const SizedBox.shrink(),
    );
    Duration delay = duration ?? const Duration(seconds: 3);
    await Future.delayed(delay);
    AppLogic.instance.closeOverlay(key);
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
    VoidCallback? onClose,
  }) {
    String noticeKey = key ?? UUIDGenerator.instance.id;
    AppLogic.instance.showNotification(
      noticeKey,
      Clickable(
        child: Card(
          color: background,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            constraints: const BoxConstraints(minHeight: 60),
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
                      if (message != null || messageWidget != null)
                        messageWidget ??
                            Text(
                              message ?? "",
                              style: AppLogic.instance.themeData.textTheme.bodyText2,
                            ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Clickable(
                  child: const Icon(Icons.close_outlined),
                  onTap: () {
                    closeInAppNotification(noticeKey);
                    onClose?.call();
                  },
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          closeInAppNotification(noticeKey);
          onTap?.call();
        },
      ),
    );
  }

  /// 关闭应用内提示
  static void closeInAppNotification(String key) {
    AppLogic.instance.closeNotification(key);
  }

  /// 单选提示框
  static Future<bool?> showOneChoiceRequest({
    String? title,
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
      title: title == null ? null : Text(title),
      message: Center(child: Text(msg)),
      cancelText: cancelText,
    );
  }

  /// 双选提示框
  static Future<bool?> showTwoChoiceRequest({
    String? title,
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
      title: title == null ? null : Text(title),
      message: Center(child: Text(msg)),
      cancelText: cancelText,
    );
  }

  /// 提示框
  static Future<T?> showRequest<T>(
    BuildContext context, {
    Widget? message,
    Widget? title,
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    List<T> defaultValue = const [],
    List<T> destructiveValue = const [],
    String cancelText = "取消",
  }) async {
    if (DeviceInfoHelper.isDesktop) {
      return await showDialogActionSheet<T>(
        context,
        valueList: valueList,
        childBuilder: childBuilder,
        message: message,
        title: title,
        defaultValue: defaultValue,
        destructiveValue: destructiveValue,
        cancelText: cancelText,
      );
    } else {
      return await showCupertinoActionSheet<T>(
        context,
        valueList: valueList,
        childBuilder: childBuilder,
        message: message,
        title: title,
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
  /// ios和android使用modalPopup
  static Future<T?> showContextMenu<T>(
    BuildContext context, {
    Widget? title,
    Widget? message,
    required Offset position,
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    List<T> defaultValue = const [],
    List<T> destructiveValue = const [],
    String cancelText = "取消",
  }) async {
    if (DeviceInfoHelper.isDesktop) {
      return await showPopupContextMenu(
        context,
        valueList: valueList,
        childBuilder: childBuilder,
        position: position,
      );
    } else {
      return await showCupertinoActionSheet(
        context,
        valueList: valueList,
        childBuilder: childBuilder,
        message: message,
        title: title,
        defaultValue: defaultValue,
        destructiveValue: destructiveValue,
        cancelText: cancelText,
      );
    }
  }

  /// 桌面端菜单按钮
  static Future<T?> showPopupContextMenu<T>(
    BuildContext context, {
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    required Offset position,
  }) async {
    // 菜单项
    List<PopupMenuEntry<T>> items = [];
    for (int i = 0; i < valueList.length; i++) {
      T value = valueList[i];
      items.add(PopupMenuItem(
        value: value,
        height: kToolbarHeight / 3 * 2,
        child: childBuilder(value),
      ));
      if (i != valueList.length - 1) {
        items.add(const PopupMenuDivider(height: 0));
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

  /// dialog形式的弹出请求
  static Future<T?> showDialogActionSheet<T>(
    BuildContext context, {
    Widget? message,
    Widget? title,
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    List<T> defaultValue = const [],
    List<T> destructiveValue = const [],
    String cancelText = "取消",
  }) async {
    List<Widget> actions = [];
    for (var value in valueList) {
      actions.add(Clickable(
        onPressed: () => RouteHelper.back(result: value),
        radius: 0,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: childBuilder.call(value),
        ),
      ));
    }
    actions.add(Clickable(
      onPressed: () => RouteHelper.back(result: null),
      radius: 0,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: Text(cancelText),
      ),
    ));
    return await showCupertinoDialog<T>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: title,
          content: message,
          actions: actions,
        );
      },
    );
  }

  /// ios平台的弹出菜单(actionSheet)
  static Future<T?> showCupertinoActionSheet<T>(
    BuildContext context, {
    Widget? title,
    Widget? message,
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    List<T> defaultValue = const [],
    List<T> destructiveValue = const [],
    String cancelText = "取消",
  }) async {
    return await showCupertinoModalPopup<T>(
      context: context,
      builder: (context) {
        List<CupertinoActionSheetAction> actions = valueList.map((value) {
          return CupertinoActionSheetAction(
            onPressed: () {
              HapticFeedback.lightImpact();
              RouteHelper.back(result: value);
            },
            isDefaultAction: defaultValue.contains(value),
            isDestructiveAction: destructiveValue.contains(value),
            child: childBuilder(value),
          );
        }).toList();
        return AnimatedPadding(
          padding: EdgeInsets.only(
            // 下面这一行是重点
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          duration: Duration.zero,
          child: CupertinoActionSheet(
            title: title,
            message: message,
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              child: Text(cancelText),
              onPressed: () {
                HapticFeedback.lightImpact();
                RouteHelper.back(result: null);
              },
            ),
          ),
        );
      },
    );
  }
}
