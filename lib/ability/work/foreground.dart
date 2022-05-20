import '../notification/notification.dart';

class ForegroundWorkHelper {
  ForegroundWorkHelper._();

  /// 初始化任务
  static Future<void> init() async {
    NotificationHelper.checkAutoNotification();
  }
}
