import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/init/init_work.dart';

import 'init_cloud.dart';
import 'init_db.dart';
import 'init_notification.dart';

/// 初始化
Future<void> init() async {
  await DeviceInfoHelper.init();
  // 数据库初始化
  await dbInit();
  // 通知初始化
  await notificationInit();
  // 云同步初始化
  await cloudInit();
  // 任务初始化
  await initWork();
}
