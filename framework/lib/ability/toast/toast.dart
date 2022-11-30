import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hg_framework/ability/toast/overlay.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:theme/theme.dart';
import 'package:uuid/uuid.dart';

/// 提示信息帮助类
class ToastHelper {
  ToastHelper._();

  factory ToastHelper() => SingletonCache.putIfAbsent(ToastHelper._());

  /// 普通提示框
  Future<void> toast({String? msg, Duration? duration}) async {
    String key = "toast_${msg.hashCode}";
    OverlayHelper().showOverlay(
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
          OverlayHelper().closeOverlay(key);
        },
      ),
      background: const SizedBox.shrink(),
    );
    Duration delay = duration ?? const Duration(seconds: 3);
    await Future.delayed(delay);
    OverlayHelper().closeOverlay(key);
  }

  /// 应用内横幅提示
  /// 因为和界面耦合，所以使用[AppLogic]提供的方法 这里只是方便调用
  void inAppNotification({
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
    String noticeKey = key ?? const Uuid().v1();
    appLogic.showNotification(
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
                            style: ThemeHelper().themeData.textTheme.bodyText1,
                          ),
                      if (message != null || messageWidget != null)
                        messageWidget ??
                            Text(
                              message ?? "",
                              style: ThemeHelper().themeData.textTheme.bodyText2,
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
  /// 因为和界面耦合，所以使用[AppLogic]提供的方法 这里只是方便调用
  void closeInAppNotification(String key) {
    appLogic.closeNotification(key);
  }

  /// 单选提示框
  Future<bool?> showOneChoiceRequest({
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
  Future<bool?> showTwoChoiceRequest({
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

  /// 请求提示框
  Future<T?> showRequest<T>(
    BuildContext context, {
    Widget? message,
    Widget? title,
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    List<T> defaultValue = const [],
    List<T> destructiveValue = const [],
    String cancelText = "取消",
  }) async {
    if (DeviceInfoHelper().isDesktop) {
      return await showCupertinoAlertDialog<T>(
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

  /// 显示漂浮菜单
  /// ios和android使用modalPopup
  Future<T?> showContextMenu<T>(
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
    if (DeviceInfoHelper().isDesktop) {
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
  Future<T?> showPopupContextMenu<T>(
    BuildContext context, {
    required List<T> valueList,
    required Widget Function(T value) childBuilder,
    required Offset position,
  }) async {
    // 菜单项
    List<PopupMenuEntry<T>> items = [];
    for (int i = 0; i < valueList.length; i++) {
      T value = valueList[i];
      items.add(MyPopupMenuItem(
        value: value,
        height: kToolbarHeight / 3 * 2,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: childBuilder(value),
      ));
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
  Future<T?> showCupertinoAlertDialog<T>(
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
  Future<T?> showCupertinoActionSheet<T>(
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
