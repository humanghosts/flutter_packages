import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scheduled_timer/scheduled_timer.dart';
import 'package:timezone/data/latest_all.dart' as tzd;
import 'package:timezone/timezone.dart' as tz;

/// 本地通知发送
class LocalNotificationHelper {
  LocalNotificationHelper._();

  /// 通知插件
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  static InAppNotificationsPlugin? inAppNotificationsPlugin;

  /// 通知启动应用
  static NotificationAppLaunchDetails? notificationAppLaunchDetails;

  /// 初始化通知组件
  static Future<bool?> init() async {
    // todo 如果是web或者是windows 由于插件没有相关功能，暂时使用应用内提醒
    if (AppLogic.isDesktop || kIsWeb) {
      inAppNotificationsPlugin = InAppNotificationsPlugin(onSelectNotification);
      return true;
    }
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // 时区初始化
    tzd.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    // 是否通过通知启动应用 来判断应该进入哪个页面
    notificationAppLaunchDetails =
        DeviceInfoHelper.platform == TargetPlatform.linux ? null : await flutterLocalNotificationsPlugin!.getNotificationAppLaunchDetails();
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
    bool? isInit = await flutterLocalNotificationsPlugin!.initialize(settings, onSelectNotification: onSelectNotification);
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
    inAppNotificationsPlugin?.show(
      id,
      title,
      body,
      details ?? buildNotificationDetail(),
      payload: payload?.encode(),
    );
    if (null == flutterLocalNotificationsPlugin) return;
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission) {
      bool isOpen = Get.isSnackbarOpen;
      if (!isOpen) ToastHelper.inAppNotification(title: "没有通知权限,添加提醒失败");
      return;
    }
    // 发送通知
    await flutterLocalNotificationsPlugin?.show(
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
    inAppNotificationsPlugin?.zonedSchedule(
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
    if (null == flutterLocalNotificationsPlugin) return true;
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute);
    if (now.isAfter(scheduledDate)) return false;
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission) {
      bool isOpen = Get.isSnackbarOpen;
      if (!isOpen) ToastHelper.inAppNotification(title: "没有通知权限,添加提醒失败");
      return false;
    }
    await flutterLocalNotificationsPlugin?.zonedSchedule(
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
    inAppNotificationsPlugin?.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      details ?? buildNotificationDetail(),
      androidAllowWhileIdle: true,
      payload: payload?.encode(),
    );
    if (flutterLocalNotificationsPlugin == null) return;
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission) {
      bool isOpen = Get.isSnackbarOpen;
      if (!isOpen) ToastHelper.inAppNotification(title: "没有通知权限,添加提醒失败");
      return;
    }
    await flutterLocalNotificationsPlugin?.periodicallyShow(
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
    if (null != inAppNotificationsPlugin) {
      return inAppNotificationsPlugin!.pendingNotificationRequests();
    }
    return await flutterLocalNotificationsPlugin?.pendingNotificationRequests() ?? [];
  }

  /// 取消指定通知
  static Future<void> cancelNotification(int id) async {
    await inAppNotificationsPlugin?.cancel(id);
    await flutterLocalNotificationsPlugin?.cancel(id);
  }

  /// 取消所有通知
  static Future<void> cancelAllNotifications() async {
    await inAppNotificationsPlugin?.cancelAll();
    await flutterLocalNotificationsPlugin?.cancelAll();
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
    if (inAppNotificationsPlugin != null) {
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
          ToastHelper.toast(msg: "打开系统设置失败,请手动打开");
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

/// 应用内提醒插件
class InAppNotificationsPlugin {
  final SelectNotificationCallback onSelectNotification;

  InAppNotificationsPlugin(this.onSelectNotification);

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

  void _show({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) {
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
