import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:theme/theme.dart';

/// 蒙版助手
class OverlayHelper {
  OverlayHelper._();

  factory OverlayHelper() => SingletonCache.putIfAbsent(OverlayHelper._());

  /// 蒙版关闭缓存
  Map<String, VoidCallback> closeFuncMap = {};

  /// 显示加载
  void showLoading(String key, {Widget? message, bool onlyDebug = false}) {
    if (onlyDebug && kDebugMode) return;
    showOverlay(
      key: key,
      widget: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitCircle(color: ThemeHelper().themeData.iconTheme.color),
            if (null != message) message,
          ],
        ),
      ),
    );
  }

  /// 关闭加载
  void closeLoading(String key) => closeOverlay(key);

  /// 显示蒙版 index越高越靠上
  void showOverlay({required String key, required Widget widget, Widget? background}) {
    if (closeFuncMap.containsKey(key)) return;
    overlayBuilder(
      (context) {
        return widget;
      },
      backgroundBuilder: (context) {
        return background ??
            BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
              child: const SizedBox.shrink(),
            );
      },
      close: (action) => closeFuncMap[key] = action,
    );
  }

  /// 关闭蒙版
  void closeOverlay(String key) {
    closeFuncMap[key]?.call();
    closeFuncMap.remove(key);
  }

  /// 蒙版构建器
  void overlayBuilder(
    Widget Function(BuildContext context) builder, {
    Widget Function(BuildContext context)? backgroundBuilder,
    // 关闭弹框方法
    void Function(VoidCallback action)? close,
  }) {
    ThemeData themeData = ThemeHelper().themeData;
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
}
