import 'cloud.dart';
import 'icloud.dart';

/// 云存储类型枚举
class CloudType {
  final Cloud cloud;

  const CloudType._(this.cloud);

  /// iCloud
  static CloudType iCloud(String containerId) => CloudType._(ICloud(containerId));
}
