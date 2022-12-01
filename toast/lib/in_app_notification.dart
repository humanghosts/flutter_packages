import 'package:flutter/material.dart';
import 'package:hgs_components/components.dart';
import 'package:hgs_device_info/device_info.dart';
import 'package:hgs_framework/framework.dart';

import 'overlay.dart';

/// 应用内通知助手
class InAppNotificationHelper {
  RxInt inAppNotificationUpdateFlag = 0.obs;

  /// ID:组件
  Map<String, Widget> indexNotificationWidget = {};

  /// 顺序:ID_SET
  Map<int, Set<String>> indexNotificationKeys = {};

  /// ID:顺序
  Map<String, int> notificationKeyIndex = {};

  /// 动画控制器
  Map<String, AnimationController> notificationController = {};

  /// 通知
  void showNotification(String key, Widget widget, [int? index]) {
    int order = index ?? indexNotificationKeys.length;
    indexNotificationWidget[key] = widget;
    notificationKeyIndex[key] = order;
    indexNotificationKeys.putIfAbsent(order, () => {}).add(key);
    if (indexNotificationWidget.length == 1) {
      OverlayHelper().showOverlay(
        key: "in_app_notification",
        widget: Obx(() {
          inAppNotificationUpdateFlag.value;
          Map<int, Set<String>> indexKeys = indexNotificationKeys;
          if (indexKeys.isEmpty) return const SizedBox.shrink();
          // 子通知
          List<Widget> children = [];
          // 通知
          List<int> indexList = indexKeys.keys.toList();
          indexList.sort();
          for (int index in indexList) {
            Set<String>? overlayKeySet = indexKeys[index];
            if (null == overlayKeySet || overlayKeySet.isEmpty) continue;
            for (String overlayKey in overlayKeySet) {
              Widget? overlayWidget = indexNotificationWidget[overlayKey];
              if (null == overlayWidget) continue;

              // 动画控制器
              AnimationController controller = notificationController.putIfAbsent(
                overlayKey,
                () => AnimationController(
                  duration: appConfig.animationConfig.middleAnimationDuration,
                  vsync: SimpleTickerProvider(),
                ),
              );

              Animation<double> animation = Tween<double>(begin: (DeviceInfoHelper().isDesktop ? 400 : Get.width), end: 0).animate(CurvedAnimation(
                parent: controller,
                curve: Curves.easeOut,
              ));
              // 立即播放动画
              Future.delayed(Duration.zero, () => controller.forward());

              children.add(AnimatedBuilder(
                key: ValueKey(overlayKey),
                animation: controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                    offset: Offset(animation.value, 0),
                    child: child,
                  );
                },
                child: Dismissible(
                  key: ValueKey(overlayKey),
                  child: overlayWidget,
                  onDismissed: (direction) {
                    closeNotification(overlayKey);
                  },
                ),
              ));
            }
          }
          if (children.isEmpty) return const SizedBox.shrink();
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: DeviceInfoHelper().isDesktop ? 400 : Get.width,
                padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
                child: SingleChildScrollView(
                  child: Column(children: children),
                ),
              ),
            ],
          );
        }),
        background: const SizedBox.shrink(),
      );
    }
    inAppNotificationUpdateFlag++;
  }

  /// 关闭通知
  void closeNotification(String key) async {
    if (!indexNotificationWidget.containsKey(key)) return;
    int order = notificationKeyIndex[key]!;
    indexNotificationWidget.remove(key);
    notificationKeyIndex.remove(key);
    indexNotificationKeys[order]?.remove(key);
    await notificationController[key]?.reverse();
    if (indexNotificationWidget.isEmpty) {
      OverlayHelper().closeOverlay("in_app_notification");
    }
    inAppNotificationUpdateFlag++;
  }
}
