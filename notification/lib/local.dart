import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:notification/notification.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:theme/theme.dart';
import 'package:timezone/data/latest_all.dart' as tzd;
import 'package:timezone/timezone.dart' as tz;

/// 本地通知发送
class LocalNotificationHelper {
  LocalNotificationHelper._();

  /// 通知插件
  static FlutterLocalNotificationsPlugin? plugin;

  /// 通知启动应用
  static NotificationAppLaunchDetails? launchDetails;

  /// 用于windows的插件
  static NotificationsPlugin? windowPlugin;

  /// 应用内通知插件
  static late InAppNotificationsPlugin inApp;

  static late String timeZoneName;

  /// 初始化通知组件
  static Future<bool?> init() async {
    if (DeviceInfoHelper().isWeb) return await _initInApp();
    if (DeviceInfoHelper().isWindowsApp) {
      await initLocalNotifier();
    } else {
      await _initFlutterLocalNotifications();
    }
    return await _initInApp();
  }

  /// local_notifier插件
  static Future<bool?> initLocalNotifier() async {
    // 在 main 方法中添加。参数 shortcutPolicy 仅适用于 Windows
    await localNotifier.setup(appName: appConfig.appName, shortcutPolicy: ShortcutPolicy.requireCreate);
    windowPlugin = DesktopNotificationsPlugin(onSelectNotification);
    return true;
  }

  /// 应用内通知
  static Future<bool?> _initInApp() async {
    inApp = InAppNotificationsPlugin(onSelectNotification);
    return true;
  }

  /// flutter_local_notifications插件
  static Future<bool?> _initFlutterLocalNotifications() async {
    plugin = FlutterLocalNotificationsPlugin();
    // 时区初始化
    tzd.initializeTimeZones();
    timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    // 是否通过通知启动应用 来判断应该进入哪个页面
    launchDetails = DeviceInfoHelper().targetPlatform == TargetPlatform.linux ? null : await plugin!.getNotificationAppLaunchDetails();
    // app_icon是应用图标文件 放在android drawable下
    AndroidInitializationSettings android = const AndroidInitializationSettings('app_icon');
    // ios配置 [onDidReceiveLocalNotification]是ios10 之前的系统点击通知回调的方法
    IOSInitializationSettings ios = IOSInitializationSettings(onDidReceiveLocalNotification: ((id, title, body, payload) => onSelectNotification(payload)));
    // macOS配置
    MacOSInitializationSettings macOS = const MacOSInitializationSettings();
    // 插件配置
    InitializationSettings settings = InitializationSettings(android: android, iOS: ios, macOS: macOS);
    // 插件初始化
    return await plugin!.initialize(settings, onSelectNotification: onSelectNotification);
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
    // 检查权限 没有权限使用系统内通知 web端也使用系统内通知
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission || DeviceInfoHelper().isWeb) return await inApp.show(id, title, body, details, payload: payload?.encode());
    // 调用本地通知
    await windowPlugin?.show(id, title, body, details, payload: payload?.encode());
    await plugin?.show(id, title, body, details, payload: payload?.encode());
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
    // 检查权限 没有权限使用系统内通知 web端也使用系统内通知
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission || DeviceInfoHelper().isWeb) {
      await inApp.zonedSchedule(
        id,
        title,
        body,
        DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute),
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload?.encode(),
        matchDateTimeComponents: matchDateTimeComponents,
      );
      return true;
    }
    windowPlugin?.zonedSchedule(
      id,
      title,
      body,
      DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload?.encode(),
      matchDateTimeComponents: matchDateTimeComponents,
    );
    if (null == plugin) return true;
    tz.TZDateTime now = tz.TZDateTime.now(tz.getLocation(timeZoneName));
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.getLocation(timeZoneName), dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute);
    if (now.isAfter(scheduledDate)) return false;
    await plugin?.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      details ?? const NotificationDetails(),
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
    // 检查权限 没有权限使用系统内通知 web端也使用系统内通知
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission || DeviceInfoHelper().isWeb) {
      return await inApp.periodicallyShow(
        id,
        title,
        body,
        repeatInterval,
        details,
        androidAllowWhileIdle: true,
        payload: payload?.encode(),
      );
    }
    windowPlugin?.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      details,
      androidAllowWhileIdle: true,
      payload: payload?.encode(),
    );
    await plugin?.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      details ?? const NotificationDetails(),
      androidAllowWhileIdle: true,
      payload: payload?.encode(),
    );
  }

  /// 检查待发送通知列表
  static Future<List<PendingNotificationRequest>> checkPendingNotificationRequests() async {
    // 检查权限 没有权限使用系统内通知 web端也使用系统内通知
    bool hasPermission = await checkNotificationPermission();
    if (!hasPermission || DeviceInfoHelper().isWeb) return inApp.pendingNotificationRequests();
    if (null != plugin) return plugin!.pendingNotificationRequests();
    return windowPlugin?.pendingNotificationRequests() ?? [];
  }

  /// 取消指定通知
  static Future<void> cancelNotification(int id) async {
    await windowPlugin?.cancel(id);
    await plugin?.cancel(id);
    await inApp.cancel(id);
  }

  /// 取消所有通知
  static Future<void> cancelAllNotifications() async {
    await windowPlugin?.cancelAll();
    await plugin?.cancelAll();
    await inApp.cancelAll();
  }

  /// 检查是否有通知权限
  static Future<bool> checkNotificationPermission() async {
    if (DeviceInfoHelper().isWeb) return false;
    DevicePlatform platform = DeviceInfoHelper().devicePlatform;
    if (platform == DevicePlatform.macOS) {
      bool? macResult = await plugin?.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return macResult ?? false;
    }
    Permission notification = Permission.notification;
    PermissionStatus status = await notification.status;
    // 权限拒绝 一般是第一次
    if (status == PermissionStatus.denied) return requestNotificationPermission();
    // 权限永久拒绝 设置里面没开
    if (status == PermissionStatus.permanentlyDenied) {
      //  询问用户是否打开设置
      bool? isOpen = await ToastHelper().showOneChoiceRequest(title: "没有通知权限", msg: "是否打开系统设置");
      if (isOpen == true) {
        isOpen = await openAppSettings();
        if (isOpen == false) {
          ToastHelper().inAppNotification(leading: Icon(Icons.sms_failed_outlined, color: ThemeHelper().themeData.errorColor), title: "打开系统设置失败,请手动打开");
        }
      }
      return false;
    }
    return true;
  }

  /// 请求通知权限
  static Future<bool> requestNotificationPermission() async {
    Permission notification = Permission.notification;
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
    NotificationDetails? notificationDetails, {
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
    NotificationDetails? notificationDetails, {
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
      LogHelper.info('onShow ${notification.identifier}');
    };
    notification.onClose = (closeReason) {
      LogHelper.info('onClose ${notification.identifier} - $closeReason');
    };
    notification.onClick = () {
      LogHelper.info('onClick ${notification.identifier}');
      onSelectNotification.call(payload);
    };
    notification.onClickAction = (actionIndex) {
      LogHelper.info('onClickAction ${notification.identifier} - $actionIndex');
    };
    notification.show();
  }
}

/// 应用内提醒插件
class InAppNotificationsPlugin extends NotificationsPlugin {
  InAppNotificationsPlugin(super.onSelectNotification);

  @override
  void _show({required int id, String? title, String? body, String? payload}) {
    ToastHelper().inAppNotification(
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
