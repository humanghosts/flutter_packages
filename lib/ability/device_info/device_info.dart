import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

/// 设备信息助手
class DeviceInfoHelper {
  DeviceInfoHelper._();

  /// 插件
  static final DeviceInfoPlugin plugin = DeviceInfoPlugin();

  /// TODO 是否是桌面端，这么写主要是为了之后可以应用内切换是否是桌面还是移动
  static bool isDesktop = true;

  static BaseDeviceInfo? _baseDeviceInfo;

  /// 是否是web平台
  static get isWeb => kIsWeb;

  /// 初始化
  static Future<void> init() async {
    _baseDeviceInfo = await plugin.deviceInfo;
    if (isWeb) {
      WebBrowserInfo webInfo = deviceInfo as WebBrowserInfo;
      debugPrint(webInfo.userAgent);
      isDesktop = !(webInfo.userAgent ?? "").contains("Mobile");
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
        case TargetPlatform.macOS:
          isDesktop = true;
          break;
        case TargetPlatform.android:
        case TargetPlatform.iOS:
          isDesktop = false;
      }
    }
  }

  /// 获取设备信息
  static BaseDeviceInfo get deviceInfo {
    assert(_baseDeviceInfo != null, "先初始化设备信息");
    return _baseDeviceInfo!;
  }

  /// TODO web判断设备类型
  static TargetPlatform get targetPlatform {
    if (!kIsWeb) return defaultTargetPlatform;
    // WebBrowserInfo webInfo = deviceInfo as WebBrowserInfo;
    // String agent = webInfo.userAgent ?? "";
    return TargetPlatform.android;
  }

  /// TODO 实际类型
  static DevicePlatform get devicePlatform {
    return DevicePlatform.iOS;
  }
}

enum DevicePlatform {
  iOS,
  iPadOS,
  android,
  macOS,
  windows,
  linux,
  web,
  webIos,
  webAndroid,
  webIPadOS,
  webMacOS,
  webWindows,
  webLinux,
}
