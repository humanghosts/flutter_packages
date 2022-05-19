import 'package:hg_orm/hg_orm.dart';

abstract class AppConfig {
  /// 应用名称
  String get appName;

  /// 数据库配置
  DatabaseConfig get databaseConfig;

  /// 通知配置
  NotificationConfig get notificationConfig;
}

/// 通知配置
class NotificationConfig {
  /// 最大通知数量
  int get maxNotificationCount => 60;
}
