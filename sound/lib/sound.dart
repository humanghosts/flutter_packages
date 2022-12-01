import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:hgs_device_info/device_info.dart';
import 'package:hgs_framework/util/singleton_catch.dart';
import 'package:soundpool/soundpool.dart';

export 'package:soundpool/soundpool.dart';

/// 音效助手
/// TODO 暂时没用，代码可能有问题
class SoundHelper {
  String directory;

  SoundHelper._({String? directory}) : directory = directory ?? "";

  factory SoundHelper({String? directory}) => SingletonCache.putIfAbsent(SoundHelper._(directory: directory));

  /// ---- 音频操作 ----
  final Map<String, int> _soundIdMap = {};

  /// 通知音效播放器
  final Soundpool _notificationPool = Soundpool.fromOptions(
    options: const SoundpoolOptions(
      streamType: StreamType.notification,
    ),
  );

  /// 加载音频
  Future<int> loadSound(String soundPath) async {
    ByteData byteData = await rootBundle.load(soundPath);
    int soundId = await _notificationPool.load(byteData);
    _soundIdMap[soundPath] = soundId;
    return soundId;
  }

  /// 播放音频
  Future<void> playNotification(String soundPath, {String? directory}) async {
    if (DeviceInfoHelper().targetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = DeviceInfoHelper().deviceInfo as IosDeviceInfo;
      String version = iosDeviceInfo.systemVersion ?? "12.0";
      double versionD = double.parse(version);
      if (versionD < 14.5) return;
    }
    directory ??= this.directory;
    String path = "$directory$soundPath";
    int? soundId = _soundIdMap[path];
    soundId ??= await loadSound(path);
    int res = await _notificationPool.play(soundId);
    log("音频文件:$soundPath播放$res");
  }
}
