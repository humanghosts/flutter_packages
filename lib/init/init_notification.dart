import 'package:hg_logger/ability/notification/notification.dart';

/// 通知初始化
Future<void> notificationInit() async {
  await NotificationHelper.init();
}
