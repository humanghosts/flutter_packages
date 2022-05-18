import '../../service/config/cloud/cloud_config.dart';
import '../notification/notification.dart';

class ForegroundWorkHelper {
  ForegroundWorkHelper._();

  /// 初始化任务
  static Future<void> init() async {
    CloudConfigService.instance.autoUpload();
    NotificationHelper.checkAutoNotification();
  }
}
