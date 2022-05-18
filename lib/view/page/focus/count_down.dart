import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:numberpicker/numberpicker.dart';

import 'base_count.dart';
import 'focus.dart';

/// 外部参数
@immutable
class CountDownArgs extends BaseCountArgs {
  /// 倒计时完成后回调
  final VoidCallback? onCountDownFinish;

  const CountDownArgs({
    int? initMilliseconds,
    int? refreshDurationInMilliseconds,
    this.onCountDownFinish,
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
class CountDownLogic extends BaseCountLogic<CountDownArgs> {
  /// 专注服务
  static final FocusService _focusService = FocusService.instance;

  /// 倒计时时长
  Rx<int> countDownMilliseconds = (25 * 60 * 1000).obs;

  /// 倒计时小时数
  Rx<int> hours = 0.obs;

  /// 倒计时分钟数
  Rx<int> minutes = 0.obs;

  /// 倒计时秒数
  Rx<int> seconds = 0.obs;

  /// 倒计时是否更新过
  bool isCountUpdate = false;

  /// 打开回调，赋值默认值
  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    if (countDownMilliseconds.value <= milliseconds.value) {
      args.focusLogic.focusState.value = FocusState.pause;
      args.onCountDownFinish?.call();
    }
    readTemp();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 读缓存
  void readTemp() {
    int? countDownMilliseconds = _focusService.countDownTempGet();
    if (null != countDownMilliseconds) {
      this.countDownMilliseconds.value = countDownMilliseconds;
    } else {
      this.countDownMilliseconds.value = 25 * 60 * 1000;
    }
    setCountDown();
  }

  /// 写缓存
  void saveTemp() async {
    if (isCountUpdate == false) return;
    isCountUpdate = false;
    await _focusService.countDownTempSave(countDownMilliseconds.value);
  }

  /// 设置倒计时
  void setCountDown() {
    hours.value = countDownMilliseconds.value ~/ (60 * 60 * 1000);
    minutes.value = (countDownMilliseconds.value - hours.value * 60 * 60 * 1000) ~/ (60 * 1000);
    seconds.value = (countDownMilliseconds.value - hours.value * 60 * 60 * 1000 - minutes.value * 60 * 1000) ~/ 1000;
  }

  /// 设置倒计时小时数
  void setHour(int value) {
    hours.value = value;
    refreshCountDownMillSeconds();
  }

  /// 设置倒计时分钟数
  void setMinute(int value) {
    minutes.value = value;
    refreshCountDownMillSeconds();
  }

  /// 设置倒计时秒钟数
  void setSecond(int value) {
    seconds.value = value;
    refreshCountDownMillSeconds();
  }

  /// 更新倒计时毫秒数
  void refreshCountDownMillSeconds() {
    countDownMilliseconds.value = Duration(hours: hours.value, minutes: minutes.value, seconds: seconds.value).inMilliseconds;
    isCountUpdate = true;
    if (countDownMilliseconds.value <= 0) {
      args.focusLogic.startActionEnabled.value = false;
    } else {
      args.focusLogic.startActionEnabled.value = true;
    }
  }

  @override
  void refreshPage() {
    super.refreshPage();
    if (countDownMilliseconds.value <= milliseconds.value) {
      milliseconds.value = countDownMilliseconds.value;
      args.onCountDownFinish?.call();
    }
  }

  /// ---- 为上级提供的方法 ----

  /// 开始
  @override
  void start() {
    super.start();
    saveTemp();
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
class CountDown extends BaseCount<CountDownLogic> {
  CountDown({required String key, required CountDownArgs args})
      : super(
          key: key,
          args: args,
          newLogic: CountDownLogic(),
        );

  @override
  Widget buildIndicator() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(
      () {
        int lastMillSeconds = logic.countDownMilliseconds.value - logic.milliseconds.value;
        double value = logic.countDownMilliseconds.value == 0 ? 0 : lastMillSeconds / logic.countDownMilliseconds.value;
        return CircularProgressIndicator(
          value: value,
          color: logic.milliseconds.value == 0 ? Colors.transparent : themeData.accentColor,
          strokeWidth: 250,
        );
      },
    );
  }

  @override
  Widget buildContent() {
    return Obx(() {
      FocusState focusState = logic.args.focusLogic.focusState.value;
      return Obx(() {
        // 如果没有开始计时，返回数字选择
        if (logic.milliseconds.value <= 0 && focusState == FocusState.stop) return buildSecondsSelect();
        // 剩余时长
        int lastMillSeconds = logic.countDownMilliseconds.value - logic.milliseconds.value;
        // 剩余秒数
        int lastSeconds = (lastMillSeconds / 1000).ceil();
        int hours = lastSeconds ~/ (60 * 60);
        int minutes = (lastSeconds - hours * 60 * 60) ~/ (60);
        int seconds = lastSeconds - hours * 60 * 60 - minutes * 60;
        return Text(
          "${hours.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}",
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        );
      });
    });
  }

  @override
  Widget buildRxClock(DeviceOrientation? deviceOrientation) {
    return Obx(() {
      int lastMillSeconds = ((logic.countDownMilliseconds.value - logic.milliseconds.value) / 1000).ceil();
      return buildOverlayClock(countSeconds: lastMillSeconds, deviceOrientation: deviceOrientation);
    });
  }

  /// 倒计时选择
  Widget buildSecondsSelect() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: buildNumberPicker(23, logic.hours, logic.setHour)),
        const Expanded(flex: 0, child: Text(":", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
        Expanded(child: buildNumberPicker(59, logic.minutes, logic.setMinute)),
        const Expanded(flex: 0, child: Text(":", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
        Expanded(child: buildNumberPicker(59, logic.seconds, logic.setSecond)),
      ],
    );
  }

  /// 构建数字选择器
  Widget buildNumberPicker(int max, Rx<int> value, Function(int value) onChanged) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(() {
      return NumberPicker(
        key: ValueKey(max),
        minValue: 0,
        maxValue: max,
        itemCount: 5,
        itemHeight: 30,
        itemWidth: 50,
        infiniteLoop: false,
        value: value.value,
        onChanged: onChanged,
        zeroPad: true,
        haptics: true,
        selectedTextStyle: TextStyle(color: themeData.defaultTextColor, fontSize: 24, fontWeight: FontWeight.w500),
        textStyle: TextStyle(color: themeData.disabledColor, fontSize: 14, fontWeight: FontWeight.w300),
      );
    });
  }
}
