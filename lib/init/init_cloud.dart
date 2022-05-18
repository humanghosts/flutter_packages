import 'package:hg_logger/ability/cloud/cloud.dart';
import 'package:hg_logger/ability/cloud/cloud_type.dart';

import '../config.dart';

/// Cloud初始化
Future<void> cloudInit() async {
  await CloudHelper.init(CloudType.iCloud(AppConfig.iosConfig.iCloudContainerName));
}
