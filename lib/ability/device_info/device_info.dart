import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoHelper {
  DeviceInfoHelper._();

  static final DeviceInfoPlugin plugin = DeviceInfoPlugin();

  static BaseDeviceInfo? _baseDeviceInfo;

  static Future<void> init() async {
    _baseDeviceInfo = await plugin.deviceInfo;
  }

  /// init first
  static BaseDeviceInfo get deviceInfo => _baseDeviceInfo!;
}
