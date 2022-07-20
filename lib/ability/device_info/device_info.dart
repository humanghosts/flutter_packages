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
    // 非web处理 判断是否平板
    if (!kIsWeb) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          IosDeviceInfo deviceInfo = _baseDeviceInfo as IosDeviceInfo;
          if (deviceInfo.model?.toLowerCase().contains("ipad") ?? false) {
            return DevicePlatform.iPadOS;
          } else {
            return DevicePlatform.iOS;
          }
        default:
          return defaultTargetPlatform.device;
      }
    }
    // web处理
    WebBrowserInfo webInfo = deviceInfo as WebBrowserInfo;
    String agent = webInfo.userAgent ?? "";
    String lowAgent = agent.toLowerCase();
    UserAgent userAgent = UserAgent(agent);
    if (userAgent.isWindowsTablet) return DevicePlatform.windowsWeb;
    if (userAgent.isWindowsPhone) return DevicePlatform.windowsWeb;
    if (userAgent.isWindows) return DevicePlatform.windowsWeb;
    if (userAgent.isAndroidTablet) return DevicePlatform.androidWeb;
    if (userAgent.isAndroidPhone) return DevicePlatform.androidWeb;
    if (userAgent.isAndroid) return DevicePlatform.androidWeb;
    if (userAgent.isBlackberryTablet) return DevicePlatform.androidWeb;
    if (userAgent.isBlackberryPhone) return DevicePlatform.androidWeb;
    if (userAgent.isBlackberry) return DevicePlatform.androidWeb;
    if (lowAgent.contains("iPhone".toLowerCase())) return DevicePlatform.iOSWeb;
    if (lowAgent.contains("iPad".toLowerCase())) return DevicePlatform.iPadOSWeb;
    if (userAgent.isMacOS) return DevicePlatform.macOSWeb;
    if (lowAgent.contains("Linux".toLowerCase())) return DevicePlatform.linuxWeb;
    if (lowAgent.contains("fuchsia".toLowerCase())) return DevicePlatform.fuchsiaWeb;
    return DevicePlatform.other;
  }

  /// 是否是web平台
  static bool get isWeb => devicePlatform.isWeb;

  static bool? _isDesktop;

  static void setIsDesktop(bool value) => _isDesktop = value;

  static void resetIsDesktop() => _isDesktop = devicePlatform.isDesktop;

  /// 是否是桌面端
  static bool isDesktop = _isDesktop ??= devicePlatform.isDesktop;

  static bool get isDesktopApp => isDesktop && !isWeb;

  static bool get isDesktopWeb => isDesktop && isWeb;

  /// 是否是移动
  static bool get isMobile => !isDesktop;

  static bool get isMobileApp => isMobile && !isWeb;

  static bool get isMobileWeb => isMobile && isWeb;

  /// 是否是平板
  static bool get isTablet => devicePlatform.isTablet;

  static bool get isTabletApp => isTablet && !isWeb;

  static bool get isTabletWeb => isTablet && isWeb;

  /// 是否是ios
  static bool get isIOS => targetPlatform == TargetPlatform.iOS;

  static bool get isIOSApp => isIOS && !isWeb;

  static bool get isIOSWeb => isIOS && isWeb;

  /// 是否是android
  static bool get isAndroid => targetPlatform == TargetPlatform.android;

  static bool get isAndroidApp => isAndroid && !isWeb;

  static bool get isAndroidWeb => isAndroid && isWeb;

  /// 是否是macos
  static bool get isMacOS => targetPlatform == TargetPlatform.macOS;

  static bool get isMacOSApp => isMacOS && !isWeb;

  static bool get isMacOSWeb => isMacOS && isWeb;

  /// 是否是windows
  static bool get isWindows => targetPlatform == TargetPlatform.windows;

  static bool get isWindowsApp => isWindows && !isWeb;

  static bool get isWindowsWeb => isWindows && isWeb;

  /// 是否是linux
  static bool get isLinux => targetPlatform == TargetPlatform.linux;

  static bool get isLinuxApp => isLinux && !isWeb;

  static bool get isLinuxWeb => isLinux && isWeb;

  /// 是否是fuchsia
  static bool get isFuchsia => targetPlatform == TargetPlatform.fuchsia;

  static bool get isFuchsiaApp => isFuchsia && !isWeb;

  static bool get isFuchsiaWeb => isFuchsia && isWeb;
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
  iOSWeb,
  androidWeb,
  iPadOSWeb,
  macOSWeb,
  windowsWeb,
  linuxWeb,
  fuchsiaWeb,
  other,
}

extension DevicePlatformEx on DevicePlatform {
  TargetPlatform get targetPlatform {
    switch (this) {
      case DevicePlatform.iOS:
      case DevicePlatform.iPadOS:
      case DevicePlatform.iOSWeb:
      case DevicePlatform.iPadOSWeb:
        return TargetPlatform.iOS;
      case DevicePlatform.android:
      case DevicePlatform.androidWeb:
        return TargetPlatform.macOS;
      case DevicePlatform.macOS:
      case DevicePlatform.macOSWeb:
        return TargetPlatform.macOS;
      case DevicePlatform.windows:
      case DevicePlatform.windowsWeb:
        return TargetPlatform.windows;
      case DevicePlatform.other:
      case DevicePlatform.linux:
      case DevicePlatform.linuxWeb:
        return TargetPlatform.linux;
      case DevicePlatform.fuchsia:
      case DevicePlatform.fuchsiaWeb:
        return TargetPlatform.fuchsia;
    }
  }

  DeviceType get deviceType {
    switch (this) {
      case DevicePlatform.iOS:
      case DevicePlatform.iOSWeb:
      case DevicePlatform.android:
      case DevicePlatform.androidWeb:
        return DeviceType.phone;
      case DevicePlatform.iPadOS:
      case DevicePlatform.iPadOSWeb:
        return DeviceType.tablet;
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.fuchsia:
      case DevicePlatform.other:
      case DevicePlatform.macOSWeb:
      case DevicePlatform.windowsWeb:
      case DevicePlatform.linuxWeb:
      case DevicePlatform.fuchsiaWeb:
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
      case DevicePlatform.iOSWeb:
      case DevicePlatform.androidWeb:
      case DevicePlatform.iPadOSWeb:
      case DevicePlatform.macOSWeb:
      case DevicePlatform.windowsWeb:
      case DevicePlatform.linuxWeb:
      case DevicePlatform.fuchsiaWeb:
        return true;
    }
  }

  bool get isDesktop {
    switch (this) {
      case DevicePlatform.iOS:
      case DevicePlatform.iOSWeb:
      case DevicePlatform.iPadOS:
      case DevicePlatform.iPadOSWeb:
      case DevicePlatform.android:
      case DevicePlatform.androidWeb:
        return false;
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.fuchsia:
      case DevicePlatform.other:
      case DevicePlatform.macOSWeb:
      case DevicePlatform.windowsWeb:
      case DevicePlatform.linuxWeb:
      case DevicePlatform.fuchsiaWeb:
        return true;
    }
  }

  bool get isMobile {
    switch (this) {
      case DevicePlatform.iOS:
      case DevicePlatform.iOSWeb:
      case DevicePlatform.iPadOS:
      case DevicePlatform.iPadOSWeb:
      case DevicePlatform.android:
      case DevicePlatform.androidWeb:
        return true;
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.fuchsia:
      case DevicePlatform.other:
      case DevicePlatform.macOSWeb:
      case DevicePlatform.windowsWeb:
      case DevicePlatform.linuxWeb:
      case DevicePlatform.fuchsiaWeb:
        return false;
    }
  }

  bool get isPhone {
    switch (this) {
      case DevicePlatform.iOS:
      case DevicePlatform.iOSWeb:
      case DevicePlatform.android:
      case DevicePlatform.androidWeb:
        return true;
      case DevicePlatform.iPadOS:
      case DevicePlatform.iPadOSWeb:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.fuchsia:
      case DevicePlatform.other:
      case DevicePlatform.macOSWeb:
      case DevicePlatform.windowsWeb:
      case DevicePlatform.linuxWeb:
      case DevicePlatform.fuchsiaWeb:
        return false;
    }
  }

  bool get isTablet {
    switch (this) {
      case DevicePlatform.iPadOS:
      case DevicePlatform.iPadOSWeb:
        return true;
      case DevicePlatform.iOS:
      case DevicePlatform.iOSWeb:
      case DevicePlatform.android:
      case DevicePlatform.androidWeb:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
      case DevicePlatform.linux:
      case DevicePlatform.fuchsia:
      case DevicePlatform.other:
      case DevicePlatform.macOSWeb:
      case DevicePlatform.windowsWeb:
      case DevicePlatform.linuxWeb:
      case DevicePlatform.fuchsiaWeb:
        return false;
    }
  }
}
