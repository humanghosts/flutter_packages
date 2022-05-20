import 'package:hg_orm/hg_orm.dart';

import 'app_init.dart';

/// 应用配置
abstract class AppConfig {
  /// 应用名称
  String get appName;

  /// 数据库配置
  DatabaseConfig get databaseConfig;

  /// 通知配置
  NotificationConfig get notificationConfig => NotificationConfig();

  /// 预置数据
  PresetData? get presetData => null;

  /// 模型和Dao注册
  EntityAndDao? get entityAndDao => null;

  /// 动画配置
  AnimationConfig get animationConfig => AnimationConfig();

  /// 资源配置
  AssetsConfig get assetsConfig => AssetsConfig();
}

/// 通知配置
class NotificationConfig {
  /// 最大通知数量
  int get maxNotificationCount => 60;
}

/// 动画配置
class AnimationConfig {
  /// 快速动画持续时间
  Duration get fastAnimationDuration => const Duration(milliseconds: 200);

  /// 中速动画持续时间
  Duration get middleAnimationDuration => const Duration(milliseconds: 500);

  /// 慢速动画持续时间
  Duration get slowAnimationDuration => const Duration(milliseconds: 800);
}

/// 资源配置
class AssetsConfig {
  /// 音频文件路径
  String get soundAssetsPath => "assets/sounds/";

  /// 图片文件路径
  String get imageAssetsPath => "assets/images/";
}
