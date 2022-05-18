import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/main.dart';

import 'base_count.dart';
import 'focus.dart';

/// 外部参数
@immutable
class CountUpArgs extends BaseCountArgs {
  const CountUpArgs({
    int? initMilliseconds,
    int? refreshDurationInMilliseconds,
    ValueChanged<int>? onMillisecondsChanged,
    ValueChanged<int>? onSecondsChanged,
    required FocusHomeLogic focusLogic,
  }) : super(
          initMilliseconds: initMilliseconds,
          refreshDurationInMilliseconds: refreshDurationInMilliseconds,
          onMillisecondsChanged: onMillisecondsChanged,
          onSecondsChanged: onSecondsChanged,
          focusLogic: focusLogic,
        );
}

/// 逻辑
class CountUpLogic extends BaseCountLogic<CountUpArgs> {
  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
  }

  /// 开始
  @override
  void start() {
    super.start();
  }

  /// 暂停
  @override
  void pause() {
    super.pause();
  }

  /// 结束
  @override
  void stop() {
    super.stop();
  }
}

/// 页面
class CountUp extends BaseCount<CountUpLogic> {
  CountUp({required String key, required CountUpArgs args})
      : super(
          key: key,
          args: args,
          newLogic: CountUpLogic(),
        );

  @override
  Widget buildIndicator() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(() {
      int milliseconds = logic.milliseconds.value % 60000;
      return CircularProgressIndicator(
        value: milliseconds / 60000,
        color: themeData.accentColor,
        strokeWidth: 250,
      );
    });
  }

  @override
  Widget buildContent() {
    return Obx(() {
      int lastSeconds = (logic.milliseconds.value / 1000).floor();
      int hours = lastSeconds ~/ (60 * 60);
      int minutes = (lastSeconds - hours * 60 * 60) ~/ (60);
      int seconds = lastSeconds - hours * 60 * 60 - minutes * 60;
      return Text(
        "${hours.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}",
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      );
    });
  }

  @override
  Widget buildRxClock(DeviceOrientation? deviceOrientation) {
    return Obx(() {
      int postSeconds = (logic.milliseconds.value / 1000).floor();
      return buildOverlayClock(countSeconds: postSeconds, deviceOrientation: deviceOrientation);
    });
  }
}
