import 'package:device_info_plus/device_info_plus.dart';

/// 设备信息助手
class DeviceInfoHelper {
  DeviceInfoHelper._();

  /// 插件
  static final DeviceInfoPlugin plugin = DeviceInfoPlugin();

  static BaseDeviceInfo? _baseDeviceInfo;

  /// 初始化
  static Future<void> init() async {
    _baseDeviceInfo = await plugin.deviceInfo;
  }

  /// 获取设备信息
  static BaseDeviceInfo get deviceInfo {
    assert(_baseDeviceInfo != null, "先初始化设备信息");
    return _baseDeviceInfo!;
  }
}
