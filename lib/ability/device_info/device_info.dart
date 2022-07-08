import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:user_agent_analyzer/user_agent_analyzer.dart';

/// 设备信息助手
class DeviceInfoHelper {
  DeviceInfoHelper._();

  /// 插件
  static final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

  /// 设备信息
  static late BaseDeviceInfo _baseDeviceInfo;

  /// 设备平台 可以手动指定
  static late DevicePlatform devicePlatform;

  /// 是否是web平台
  static bool get isWeb => devicePlatform.isWeb;

  /// 是否是桌面端
  static bool isDesktop = devicePlatform.isDesktop;

  /// 初始化
  static Future<void> init() async {
    _baseDeviceInfo = await _plugin.deviceInfo;
    devicePlatform = getDevicePlatform();
  }

  /// 获取设备信息
  static BaseDeviceInfo get deviceInfo => _baseDeviceInfo;

  /// 判断设备操作系统类型
  static TargetPlatform get targetPlatform => devicePlatform.targetPlatform;

  /// 实际类型
  static DevicePlatform getDevicePlatform() {
    // todo 如何细分平板和手机
    if (!kIsWeb) return defaultTargetPlatform.device;
    WebBrowserInfo webInfo = deviceInfo as WebBrowserInfo;
    String agent = webInfo.userAgent ?? "";
    String lowAgent = agent.toLowerCase();
    UserAgent userAgent = UserAgent(agent);
    if (userAgent.isWindowsTablet) return DevicePlatform.webWindows;
    if (userAgent.isWindowsPhone) return DevicePlatform.webWindows;
    if (userAgent.isWindows) return DevicePlatform.webWindows;
    if (userAgent.isAndroidTablet) return DevicePlatform.webAndroid;
    if (userAgent.isAndroidPhone) return DevicePlatform.webAndroid;
    if (userAgent.isAndroid) return DevicePlatform.webAndroid;
    if (userAgent.isBlackberryTablet) return DevicePlatform.webAndroid;
    if (userAgent.isBlackberryPhone) return DevicePlatform.webAndroid;
    if (userAgent.isBlackberry) return DevicePlatform.webAndroid;
    if (lowAgent.contains("iPhone".toLowerCase())) return DevicePlatform.webIos;
    if (lowAgent.contains("iPad".toLowerCase())) return DevicePlatform.webIPadOS;
    if (userAgent.isMacOS) return DevicePlatform.webMacOS;
    if (lowAgent.contains("Linux".toLowerCase())) return DevicePlatform.webLinux;
    if (lowAgent.contains("fuchsia".toLowerCase())) return DevicePlatform.webFuchsia;
    return DevicePlatform.other;
  }
}

extension TargetPlatformEx on TargetPlatform {
  DevicePlatform get device {
    switch (this) {
      case TargetPlatform.android:
        return DevicePlatform.android;
      case TargetPlatform.fuchsia:
        return DevicePlatform.fuchsia;
      case TargetPlatform.iOS:
        return DevicePlatform.iOS;
      case TargetPlatform.linux:
        return DevicePlatform.linux;
      case TargetPlatform.macOS:
        return DevicePlatform.macOS;
      case TargetPlatform.windows:
        return DevicePlatform.windows;
    }
  }
}

/// 设备类型
enum DeviceType {
  desktop,
  tablet,
  phone,
}

/// 操作系统版本
enum DevicePlatform {
  iOS,
  iPadOS,
  android,
  macOS,
  windows,
  linux,
  fuchsia,
  webIos,
  webAndroid,
  webIPadOS,
  webMacOS,
  webWindows,
  webLinux,
  webFuchsia,
  other,
}

extension DevicePlatformEx on DevicePlatform {
  TargetPlatform get targetPlatform {
    switch (this) {
      case DevicePlatform.iOS:
      case DevicePlatform.iPadOS:
      case DevicePlatform.webIos:
      case DevicePlatform.webIPadOS:
        return TargetPlatform.iOS;
      case DevicePlatform.android:
      case DevicePlatform.webAndroid:
        return TargetPlatform.macOS;
      case DevicePlatform.macOS:
      case DevicePlatform.webMacOS:
        return TargetPlatform.macOS;
      case DevicePlatform.windows:
      case DevicePlatform.webWindows:
        return TargetPlatform.windows;
      case DevicePlatform.other:
      case DevicePlatform.linux:
      case DevicePlatform.webLinux:
        return TargetPlatform.linux;
      case DevicePlatform.fuchsia:
      case DevicePlatform.webFuchsia:
        return TargetPlatform.fuchsia;
    }
  }

  DeviceType get deviceType {
    switch (this) {
      case DevicePlatform.iOS:
      case DevicePlatform.webIos:
      case DevicePlatform.android:
      case DevicePlatform.webAndroid:
        return DeviceType.phone;
      case DevicePlatform.iPadOS:
      case DevicePlatform.webIPadOS:
        return DeviceType.tablet;
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.fuchsia:
      case DevicePlatform.other:
      case DevicePlatform.webMacOS:
      case DevicePlatform.webWindows:
      case DevicePlatform.webLinux:
      case DevicePlatform.webFuchsia:
        return DeviceType.desktop;
    }
  }

  bool get isWeb {
    switch (this) {
      case DevicePlatform.iOS:
      case DevicePlatform.iPadOS:
      case DevicePlatform.android:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.fuchsia:
      case DevicePlatform.other:
        return false;
      case DevicePlatform.webIos:
      case DevicePlatform.webAndroid:
      case DevicePlatform.webIPadOS:
      case DevicePlatform.webMacOS:
      case DevicePlatform.webWindows:
      case DevicePlatform.webLinux:
      case DevicePlatform.webFuchsia:
        return true;
    }
  }

  bool get isDesktop {
    switch (this) {
      case DevicePlatform.iOS:
      case DevicePlatform.webIos:
      case DevicePlatform.iPadOS:
      case DevicePlatform.webIPadOS:
      case DevicePlatform.android:
      case DevicePlatform.webAndroid:
        return false;
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.fuchsia:
      case DevicePlatform.other:
      case DevicePlatform.webMacOS:
      case DevicePlatform.webWindows:
      case DevicePlatform.webLinux:
      case DevicePlatform.webFuchsia:
        return true;
    }
  }

  bool get isMobile {
    switch (this) {
      case DevicePlatform.iOS:
      case DevicePlatform.webIos:
      case DevicePlatform.iPadOS:
      case DevicePlatform.webIPadOS:
      case DevicePlatform.android:
      case DevicePlatform.webAndroid:
        return true;
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.fuchsia:
      case DevicePlatform.other:
      case DevicePlatform.webMacOS:
      case DevicePlatform.webWindows:
      case DevicePlatform.webLinux:
      case DevicePlatform.webFuchsia:
        return false;
    }
  }

  bool get isPhone {
    switch (this) {
      case DevicePlatform.iOS:
      case DevicePlatform.webIos:
      case DevicePlatform.android:
      case DevicePlatform.webAndroid:
        return true;
      case DevicePlatform.iPadOS:
      case DevicePlatform.webIPadOS:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.fuchsia:
      case DevicePlatform.other:
      case DevicePlatform.webMacOS:
      case DevicePlatform.webWindows:
      case DevicePlatform.webLinux:
      case DevicePlatform.webFuchsia:
        return false;
    }
  }

  bool get isTablet {
    switch (this) {
      case DevicePlatform.iPadOS:
      case DevicePlatform.webIPadOS:
        return true;
      case DevicePlatform.iOS:
      case DevicePlatform.webIos:
      case DevicePlatform.android:
      case DevicePlatform.webAndroid:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.fuchsia:
      case DevicePlatform.other:
      case DevicePlatform.webMacOS:
      case DevicePlatform.webWindows:
      case DevicePlatform.webLinux:
      case DevicePlatform.webFuchsia:
        return false;
    }
  }
}
