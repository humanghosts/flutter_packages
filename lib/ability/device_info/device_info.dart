import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:user_agent_analyzer/user_agent_analyzer.dart';

/// 设备信息助手
/// 支持包括web在内所有平台设备信息，基于device_info_plus插件
class DeviceInfoHelper with AppInitPlugin {
  DeviceInfoHelper._({bool? storeDesktopConfig}) : _storeDesktopConfig = storeDesktopConfig ?? false;

  factory DeviceInfoHelper({bool? storeDesktopConfig}) => SingletonCache.putIfAbsent(DeviceInfoHelper._(storeDesktopConfig: storeDesktopConfig));

  /// 第三方插件
  final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

  /// 设备信息
  late BaseDeviceInfo _baseDeviceInfo;

  /// 设备平台 可以手动指定
  late DevicePlatform devicePlatform;

  /// 用于存储是否桌面平台
  final String _isDesktopKey = "_isDesktop";

  /// 是否存储指定桌面模式的设置
  late bool _storeDesktopConfig = false;

  /// 初始化
  @override
  Future<void> init(AppConfig config) async {
    bool isPrefsInit = PrefsHelper().isInit;
    if (_storeDesktopConfig && !isPrefsInit) {
      throw Exception("存储桌面模式设置需要shared_preferences支持，请优先初始化。");
    }
    _baseDeviceInfo = await _plugin.deviceInfo;
    devicePlatform = getDevicePlatform();
    if (_storeDesktopConfig) _isDesktop = PrefsHelper().prefs.getBool(_isDesktopKey);
  }

  /// 获取设备信息
  BaseDeviceInfo get deviceInfo => _baseDeviceInfo;

  /// 判断设备操作系统类型
  TargetPlatform get targetPlatform => devicePlatform.targetPlatform;

  /// 实际类型
  DevicePlatform getDevicePlatform() {
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
  bool get isWeb => devicePlatform.isWeb;

  /// 是否桌面端变量
  bool? _isDesktop;

  /// 指定是否桌面端
  Future<void> setIsDesktop(bool value) async {
    _isDesktop = value;
    if (_storeDesktopConfig) await PrefsHelper().prefs.setBool(_isDesktopKey, value);
  }

  /// 根据设备类型重制是否桌面端
  Future<void> resetIsDesktop() async => await setIsDesktop(devicePlatform.isDesktop);

  /// 忽略用户设置，直接返回是否桌面设备
  bool get isDesktopDevice => devicePlatform.isDesktop;

  bool get isDesktopDeviceApp => isDesktopDevice && !isWeb;

  bool get isDesktopDeviceWeb => isDesktopDevice && isWeb;

  /// 忽略用户设置，直接返回是否移动设备
  bool get isMobileDevice => !isDesktopDevice;

  bool get isMobileDeviceApp => isMobileDevice && !isWeb;

  bool get isMobileDeviceWeb => isMobileDevice && isWeb;

  /// 是否是桌面端 可由用户更改
  bool get isDesktop => _isDesktop ??= devicePlatform.isDesktop;

  bool get isDesktopApp => isDesktop && !isWeb;

  bool get isDesktopWeb => isDesktop && isWeb;

  /// 是否是移动
  bool get isMobile => !isDesktop;

  bool get isMobileApp => isMobile && !isWeb;

  bool get isMobileWeb => isMobile && isWeb;

  /// 是否是平板
  bool get isTablet => devicePlatform.isTablet;

  bool get isTabletApp => isTablet && !isWeb;

  bool get isTabletWeb => isTablet && isWeb;

  /// 是否是ios
  bool get isIOS => targetPlatform == TargetPlatform.iOS;

  bool get isIOSApp => isIOS && !isWeb;

  bool get isIOSWeb => isIOS && isWeb;

  /// 是否是android
  bool get isAndroid => targetPlatform == TargetPlatform.android;

  bool get isAndroidApp => isAndroid && !isWeb;

  bool get isAndroidWeb => isAndroid && isWeb;

  /// 是否是macos
  bool get isMacOS => targetPlatform == TargetPlatform.macOS;

  bool get isMacOSApp => isMacOS && !isWeb;

  bool get isMacOSWeb => isMacOS && isWeb;

  /// 是否是windows
  bool get isWindows => targetPlatform == TargetPlatform.windows;

  bool get isWindowsApp => isWindows && !isWeb;

  bool get isWindowsWeb => isWindows && isWeb;

  /// 是否是linux
  bool get isLinux => targetPlatform == TargetPlatform.linux;

  bool get isLinuxApp => isLinux && !isWeb;

  bool get isLinuxWeb => isLinux && isWeb;

  /// 是否是fuchsia
  bool get isFuchsia => targetPlatform == TargetPlatform.fuchsia;

  bool get isFuchsiaApp => isFuchsia && !isWeb;

  bool get isFuchsiaWeb => isFuchsia && isWeb;
}

extension TargetPlatformEx on TargetPlatform {
  String get value => name;

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

  TargetPlatform? fromValue(String? value) {
    if (null == value) return null;
    return TargetPlatform.values.firstWhereOrNull((e) => e.value == value);
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
        return TargetPlatform.android;
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
