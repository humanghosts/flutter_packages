import 'package:hg_orm/hg_orm.dart';

class AppConfig {
  AppConfig._();

  /// 应用名称
  static String get appName => "事计";

  /// 根路由id
  static int get rootNavigatorId => 0;

  /// 数据库配置
  static _DbConfig get dbConfig => _DbConfig._();

  /// ios配置
  static _IOSConfig get iosConfig => _IOSConfig._();

  /// 动画配置
  static _AnimationConfig get animationConfig => _AnimationConfig._();

  /// 资源配置
  static _AssetsConfig get assetsConfig => _AssetsConfig._();

  /// 平台版本配置
  static _PlatformVersionConfig get platformVersionConfig => _PlatformVersionConfig._();

  /// 隐私政策版本配置
  static _PrivacyPolicyVersionConfig get privacyPolicyVersionConfig => _PrivacyPolicyVersionConfig._();

  /// 通知配置
  static _NotificationConfig get notificationConfig => _NotificationConfig._();
}

/// 隐私版本配置
class _PrivacyPolicyVersionConfig {
  _PrivacyPolicyVersionConfig._();

  String get version => "1.0.0";
}

/// 版本配置
class _PlatformVersionConfig {
  _PlatformVersionConfig._();

  /// ios版本
  String get ios => "1.0.0";
}

/// 数据库配置
class _DbConfig {
  _DbConfig._();

  /// 数据库文件名称
  String get dbFileName => "logger.db";

  DatabaseType get databaseType => DatabaseType.sembast;
}

/// 资源配置
class _AssetsConfig {
  _AssetsConfig._();

  /// 音频文件路径
  String get soundAssetsPath => "assets/sounds/";

  /// 图片文件路径
  String get imageAssetsPath => "assets/images/";
}

/// 动画配置
class _AnimationConfig {
  _AnimationConfig._();

  /// 快速动画持续时间
  Duration get fastAnimationDuration => const Duration(milliseconds: 200);

  /// 中速动画持续时间
  Duration get middleAnimationDuration => const Duration(milliseconds: 500);

  /// 慢速动画持续时间
  Duration get slowAnimationDuration => const Duration(milliseconds: 800);
}

/// 通知配置
class _NotificationConfig {
  _NotificationConfig._();

  /// 最大通知数量
  int get maxNotificationCount => 60;
}

/// ios特殊配置
class _IOSConfig {
  _IOSConfig._();

  /// icloud容器id
  String get iCloudContainerName => "iCloud.com.humanghosts.logger";

  /// ios 后台任务的id
  String get iosBackgroundFetchId => "com.transistorsoft.fetch";

  String get iosBackgroundTaskId => "com.humanghosts.logger";

  String get iosBackgroundUploadId => "com.humanghosts.logger.upload_data";
}
