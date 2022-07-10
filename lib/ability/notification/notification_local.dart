import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scheduled_timer/scheduled_timer.dart';
import 'package:timezone/data/latest_all.dart' as tzd;
import 'package:timezone/timezone.dart' as tz;

/// 本地通知发送
class LocalNotificationHelper {
  LocalNotificationHelper._();

  /// 通知插件
  static FlutterLocalNotificationsPlugin? mobilePlugin;
  static NotificationsPlugin? pluginIn;

  /// 通知启动应用
  static NotificationAppLaunchDetails? mobileLaunchDetails;

  /// 初始化通知组件
  static Future<bool?> init() async {
    if (DeviceInfoHelper.isWeb) return await initWeb();
    if (DeviceInfoHelper.isDesktopDevice) return await initDesktop();
    return await initMobile();
  }

  /// 桌面端通知 TODO 应用内提醒 local_notifier
  static Future<bool?> initDesktop() async {
    // 在 main 方法中添加。参数 shortcutPolicy 仅适用于 Windows
    await localNotifier.setup(appName: AppLogic.appConfig.appName, shortcutPolicy: ShortcutPolicy.requireCreate);
    pluginIn = DesktopNotificationsPlugin(onSelectNotification);
    return true;
  }

  /// web端通知
  static Future<bool?> initWeb() async {
    pluginIn = InAppNotificationsPlugin(onSelectNotification);
    return true;
  }

  /// 移动端通知
  static Future<bool?> initMobile() async {
    mobilePlugin = FlutterLocalNotificationsPlugin();
    // 时区初始化
    tzd.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    // 是否通过通知启动应用 来判断应该进入哪个页面
    mobileLaunchDetails = DeviceInfoHelper.targetPlatform == TargetPlatform.linux ? null : await mobilePlugin!.getNotificationAppLaunchDetails();
    //  app_icon是应用图标文件
    AndroidInitializationSettings android = const AndroidInitializationSettings('app_icon');
    // ios配置
    IOSInitializationSettings ios = IOSInitializationSettings(
      // ios10 之前的系统点击通知回调的方法
      onDidReceiveLocalNotification: ((id, title, body, payload) => onSelectNotification(payload)),
    );
    // macOS配置
    MacOSInitializationSettings macOS = const MacOSInitializationSettings();
    // 插件配置
    InitializationSettings settings = InitializationSettings(android: android, iOS: ios, macOS: macOS);
    bool? isInit = await mobilePlugin!.initialize(settings, onSelectNotification: onSelectNotification);
    return isInit;
  }

  /// 通知点击回调
  static void onSelectNotification(String? payload) => NotificationCallback.callback(payload);

  /// 显示简单通知
  static Future<void> showNotification({
    required int id,
    NotificationPayload? payload,
    String? title,
    String? body,
    NotificationDetails? details,
  }) async {
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission) {
      bool isOpen = Get.isSnackbarOpen;
      if (!isOpen) ToastHelper.inAppNotification(title: "没有通知权限,添加提醒失败");
      return;
    }
    pluginIn?.show(
      id,
      title,
      body,
      details ?? buildNotificationDetail(),
      payload: payload?.encode(),
    );
    // 发送通知
    await mobilePlugin?.show(
      id,
      title,
      body,
      details ?? buildNotificationDetail(),
      payload: payload?.encode(),
    );
  }

  /// 定时通知 精确到分钟 超过当前时间忽略 可以指定重复规则
  /// [matchDateTimeComponents]是重复标识
  static Future<bool> scheduleNotification({
    required int id,
    NotificationPayload? payload,
    required DateTime dateTime,
    String? title,
    String? body,
    NotificationDetails? details,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission) {
      bool isOpen = Get.isSnackbarOpen;
      if (!isOpen) ToastHelper.inAppNotification(title: "没有通知权限,添加提醒失败");
      return false;
    }
    pluginIn?.zonedSchedule(
      id,
      title,
      body,
      DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute),
      details ?? buildNotificationDetail(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload?.encode(),
      matchDateTimeComponents: matchDateTimeComponents,
    );
    if (null == mobilePlugin) return true;
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute);
    if (now.isAfter(scheduledDate)) return false;
    await mobilePlugin?.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      details ?? buildNotificationDetail(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload?.encode(),
      matchDateTimeComponents: matchDateTimeComponents,
    );
    return true;
  }

  /// 重复通知
  static Future<void> repeatNotification({
    required int id,
    NotificationPayload? payload,
    required RepeatInterval repeatInterval,
    String? title,
    String? body,
    NotificationDetails? details,
  }) async {
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission) {
      bool isOpen = Get.isSnackbarOpen;
      if (!isOpen) ToastHelper.inAppNotification(title: "没有通知权限,添加提醒失败");
      return;
    }
    pluginIn?.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      details ?? buildNotificationDetail(),
      androidAllowWhileIdle: true,
      payload: payload?.encode(),
    );
    await mobilePlugin?.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      details ?? buildNotificationDetail(),
      androidAllowWhileIdle: true,
      payload: payload?.encode(),
    );
  }

  /// 检查待发送通知列表
  static Future<List<PendingNotificationRequest>> checkPendingNotificationRequests() async {
    if (null != pluginIn) {
      return pluginIn!.pendingNotificationRequests();
    }
    return await mobilePlugin?.pendingNotificationRequests() ?? [];
  }

  /// 取消指定通知
  static Future<void> cancelNotification(int id) async {
    await pluginIn?.cancel(id);
    await mobilePlugin?.cancel(id);
  }

  /// 取消所有通知
  static Future<void> cancelAllNotifications() async {
    await pluginIn?.cancelAll();
    await mobilePlugin?.cancelAll();
  }

  /// 构建通知配置
  static NotificationDetails buildNotificationDetail({
    AndroidNotificationDetails? android,
    IOSNotificationDetails? ios,
    MacOSNotificationDetails? macOS,
    LinuxNotificationDetails? linux,
  }) {
    //  安卓的通知设置
    AndroidNotificationDetails? androidDetails;
    // IOS的通知设置 可以修改音效等 暂时所有通知都用1
    IOSNotificationDetails iosDetails = ios ?? const IOSNotificationDetails(threadIdentifier: "1");
    // Mac的通知设置
    MacOSNotificationDetails macOSDetails = macOS ?? const MacOSNotificationDetails();
    LinuxNotificationDetails linuxDetails = linux ?? const LinuxNotificationDetails();
    return NotificationDetails(android: android ?? androidDetails, iOS: iosDetails, macOS: macOSDetails, linux: linuxDetails);
  }

  /// 检查是否有通知权限
  static Future<bool> checkNotificationPermission() async {
    if (pluginIn != null) {
      return true;
    }
    Permission notification = Permission.notification;
    PermissionStatus status = await notification.status;
    // 权限拒绝 一般是第一次
    if (status == PermissionStatus.denied) {
      return requestNotificationPermission();
    }
    // 权限永久拒绝 设置里面没开
    else if (status == PermissionStatus.permanentlyDenied) {
      //  询问用户是否打开设置
      bool? isOpen = await showCupertinoDialog<bool>(
        context: Get.context!,
        builder: (context) {
          // TODO 样式
          return CupertinoAlertDialog(
            title: const Text("没有通知权限"),
            content: const Text("是否打开系统设置"),
            actions: <Widget>[
              CupertinoDialogAction(child: const Text("打开"), onPressed: () => RouteHelper.back(result: true)),
              CupertinoDialogAction(child: const Text("取消"), onPressed: () => RouteHelper.back(result: false)),
            ],
          );
        },
      );
      if (isOpen == true) {
        isOpen = await openAppSettings();
        if (isOpen == false) {
          ToastHelper.inAppNotification(
            leading: Icon(Icons.sms_failed_outlined, color: AppLogic.instance.themeData.errorColor),
            title: "打开系统设置失败,请手动打开",
          );
        }
      }
      return false;
    } else {
      return true;
    }
  }

  /// 请求通知权限
  static Future<bool> requestNotificationPermission() async {
    Permission notification = Permission.notification;
    notification.shouldShowRequestRationale;
    PermissionStatus status = await notification.request();
    switch (status) {
      case PermissionStatus.denied:
        return false;
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.restricted:
        return true;
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }
}

abstract class NotificationsPlugin {
  final SelectNotificationCallback onSelectNotification;

  NotificationsPlugin(this.onSelectNotification);

  /// 通知缓存
  final Map<int, PendingNotificationRequest> notificationCache = {};

  /// 查看待发送通知列表
  List<PendingNotificationRequest> pendingNotificationRequests() => notificationCache.values.toList();

  /// 取消通知
  Future<void> cancel(int id) async {
    ScheduledTimer timer = ScheduledTimer.fromId(id: id.toString(), onExecute: () {});
    await timer.clearSchedule();
    notificationCache.remove(id);
  }

  /// 取消所有通知
  Future<void> cancelAll() async {
    for (int key in notificationCache.keys) {
      ScheduledTimer timer = ScheduledTimer.fromId(id: key.toString(), onExecute: () {});
      await timer.clearSchedule();
    }
    notificationCache.clear();
  }

  /// 立即提醒
  Future<void> show(
    int id,
    String? title,
    String? body,
    NotificationDetails? notificationDetails, {
    String? payload,
  }) async {
    _show(id: id, title: title, body: body, payload: payload);
  }

  /// 定时通知
  Future<void> zonedSchedule(
    int id,
    String? title,
    String? body,
    DateTime scheduledDate,
    NotificationDetails notificationDetails, {
    required UILocalNotificationDateInterpretation uiLocalNotificationDateInterpretation,
    required bool androidAllowWhileIdle,
    String? payload,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    late ScheduledTimer timer;
    timer = ScheduledTimer.fromId(
      id: id.toString(),
      onExecute: () async {
        _show(id: id, title: title, body: body, payload: payload);
        if (matchDateTimeComponents == null) return;
        DateTime? oldScheduledTime = timer.scheduledTime ?? DateTime.now();
        switch (matchDateTimeComponents) {
          case DateTimeComponents.time:
            timer.schedule(oldScheduledTime.add(const Duration(days: 1)));
            break;
          case DateTimeComponents.dayOfWeekAndTime:
            timer.schedule(oldScheduledTime.add(const Duration(days: 7)));
            break;
          case DateTimeComponents.dayOfMonthAndTime:
            timer.schedule(DateTime(
              oldScheduledTime.year,
              oldScheduledTime.month + 1,
              oldScheduledTime.day,
              oldScheduledTime.hour,
              oldScheduledTime.minute,
              oldScheduledTime.second,
              oldScheduledTime.millisecond,
              oldScheduledTime.microsecond,
            ));
            break;
          case DateTimeComponents.dateAndTime:
            timer.schedule(DateTime(
              oldScheduledTime.year + 1,
              oldScheduledTime.month,
              oldScheduledTime.day,
              oldScheduledTime.hour,
              oldScheduledTime.minute,
              oldScheduledTime.second,
              oldScheduledTime.millisecond,
              oldScheduledTime.microsecond,
            ));
            break;
        }
      },
      onMissedSchedule: () {
        timer.execute();
      },
    );
    if (timer.scheduledTime == null) {
      await timer.load();
    }
    DateTime? oldScheduledTime = timer.scheduledTime;
    if (null == oldScheduledTime) {
      await timer.schedule(scheduledDate);
    } else {
      if (scheduledDate.isBefore(DateTime.now()) && matchDateTimeComponents == null) return;
      timer.start();
    }
  }

  /// 重复通知
  Future<void> periodicallyShow(
    int id,
    String? title,
    String? body,
    RepeatInterval repeatInterval,
    NotificationDetails notificationDetails, {
    String? payload,
    bool androidAllowWhileIdle = false,
  }) async {
    late ScheduledTimer timer;
    timer = ScheduledTimer.fromId(
      id: id.toString(),
      onExecute: () async {
        _show(id: id, title: title, body: body, payload: payload);
        DateTime? now = DateTime.now();
        switch (repeatInterval) {
          case RepeatInterval.everyMinute:
            timer.schedule(now.add(const Duration(minutes: 1)));
            break;
          case RepeatInterval.hourly:
            timer.schedule(now.add(const Duration(hours: 1)));
            break;
          case RepeatInterval.daily:
            timer.schedule(now.add(const Duration(days: 1)));
            break;
          case RepeatInterval.weekly:
            timer.schedule(now.add(const Duration(days: 7)));
            break;
        }
      },
      onMissedSchedule: () {
        timer.execute();
      },
    );
    if (timer.scheduledTime == null) {
      await timer.load();
    }
    DateTime? oldScheduledTime = timer.scheduledTime;
    if (null == oldScheduledTime) {
      await timer.schedule(DateTime.now());
    } else {
      timer.start();
    }
  }

  /// 发送通知
  void _show({required int id, String? title, String? body, String? payload});
}

class DesktopNotificationsPlugin extends NotificationsPlugin {
  DesktopNotificationsPlugin(super.onSelectNotification);

  @override
  void _show({required int id, String? title, String? body, String? payload}) {
    LocalNotification notification = LocalNotification(
      identifier: id.toString(),
      title: title ?? (body ?? ""),
      body: title == null ? null : body,
    );
    notification.onShow = () {
      debugPrint('onShow ${notification.identifier}');
    };
    notification.onClose = (closeReason) {
      debugPrint('onClose ${notification.identifier} - $closeReason');
    };
    notification.onClick = () {
      debugPrint('onClick ${notification.identifier}');
      onSelectNotification.call(payload);
    };
    notification.onClickAction = (actionIndex) {
      debugPrint('onClickAction ${notification.identifier} - $actionIndex');
    };
    notification.show();
  }
}

/// 应用内提醒插件
class InAppNotificationsPlugin extends NotificationsPlugin {
  InAppNotificationsPlugin(super.onSelectNotification);

  @override
  void _show({required int id, String? title, String? body, String? payload}) {
    ToastHelper.inAppNotification(
      key: id.toString(),
      message: body,
      title: title,
      leading: const Icon(Icons.alarm_outlined),
      onTap: () {
        onSelectNotification.call(payload);
      },
    );
  }
}
