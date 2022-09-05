import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:hg_framework/app/logic.dart';
import 'package:soundpool/soundpool.dart';

import '../device_info/device_info.dart';
import '../log/log.dart';

/// 音效助手
class SoundHelper {
  /// ---- 音频操作 ----
  static final Map<String, int> _soundIdMap = {};

  /// 通知音效播放器
  static final Soundpool _notificationPool = Soundpool.fromOptions(
    options: const SoundpoolOptions(
      streamType: StreamType.notification,
    ),
  );

  /// 加载音频
  static Future<int> loadSound(String soundPath) async {
    ByteData byteData = await rootBundle.load(soundPath);
    int soundId = await _notificationPool.load(byteData);
    _soundIdMap[soundPath] = soundId;
    return soundId;
  }

  /// 播放音频
  static Future<void> playNotification(String soundPath, {String? prefix}) async {
    BaseDeviceInfo deviceInfo = DeviceInfoHelper.deviceInfo;
    if (DeviceInfoHelper.targetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = deviceInfo as IosDeviceInfo;
      String version = iosDeviceInfo.systemVersion ?? "12.0";
      double versionD = double.parse(version);
      if (versionD < 14.5) return;
    }
    prefix ??= appConfig.assetsConfig.soundAssetsPath;
    String path = "$prefix$soundPath";
    int? soundId = _soundIdMap[path];
    soundId ??= await loadSound(path);
    int res = await _notificationPool.play(soundId);
    LogHelper.info("音频文件:$soundPath播放$res");
  }
}
