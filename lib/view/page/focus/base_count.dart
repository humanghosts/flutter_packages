import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

/// 外部参数
@immutable
abstract class BaseCountArgs extends ViewArgs {
  /// 计时时长
  final int? initMilliseconds;

  /// 刷新间隔
  final int? refreshDurationInMilliseconds;

  /// 计时变化回调
  final ValueChanged<int>? onMillisecondsChanged;

  /// 计时变化回调
  final ValueChanged<int>? onSecondsChanged;

  /// 上级控制器
  final FocusHomeLogic focusLogic;

  const BaseCountArgs({
    this.initMilliseconds,
    this.refreshDurationInMilliseconds,
    this.onMillisecondsChanged,
    this.onSecondsChanged,
    required this.focusLogic,
  });
}

/// 逻辑
abstract class BaseCountLogic<T extends BaseCountArgs> extends TutorialViewLogicOnlyArgs<T> {
  /// 刷新间隔
  int refreshMillSeconds = 10;

  /// 正计时时长
  Rx<int> milliseconds = 0.obs;

  /// 正计时时长 秒为单位
  Rx<int> countSeconds = 0.obs;

  /// Timer执行间隔
  Duration refreshDuration = const Duration(milliseconds: 10);

  /// 计时器
  Timer? timer;

  /// 打开回调，赋值默认值
  @override
  @mustCallSuper
  void afterArgsUpdate() {
    refreshMillSeconds = args.refreshDurationInMilliseconds ?? 10;
    refreshDuration = Duration(milliseconds: refreshMillSeconds);
    milliseconds.value = args.initMilliseconds ?? 0;
    countSeconds.value = (milliseconds.value / 1000).floor();
  }

  @override
  void onWidgetDispose(BuildContext context, GetBuilderState<GetxController> state) {
    timer?.cancel();
    timer = null;
  }

  /// 刷新页面 并回调
  void refreshPage() {
    milliseconds.value = milliseconds.value + refreshMillSeconds;
    args.onMillisecondsChanged?.call(milliseconds.value);
    int secondsValue = (milliseconds.value / 1000).floor();
    if (secondsValue != countSeconds.value) {
      countSeconds.value = secondsValue;
      args.onSecondsChanged?.call(countSeconds.value);
    }
  }

  /// ---- 为上级提供的方法 ----

  /// 开始
  void start() {
    Timer? timer = this.timer;
    if (timer != null) timer.cancel();
    this.timer = Timer.periodic(refreshDuration, (timer) {
      refreshPage();
    });
  }

  /// 暂停
  void pause() {
    timer?.cancel();
    timer = null;
  }

  /// 结束
  void stop() {
    timer?.cancel();
    timer = null;
  }

  /// 重置数据
  void reset() {
    timer?.cancel();
    timer = null;
    milliseconds.value = 0;
  }

  /// ---- 额外功能 ----

  /// 音频文件路径
  String soundFileName = Sounds.diDa;

  /// 播放音频文件
  Rx<bool> playSound = false.obs;

  /// 设置是否播放声音
  void setPlaySound(bool value) {
    HapticFeedback.lightImpact();
    playSound.value = value;
  }

  /// 播放
  Future<void> play() async {
    if (!playSound.value) return;
    await SoundHelper.playNotification(soundFileName);
  }

  @override
  void buildTutorial() {}

  /// 显示提示
  void showTutorial(BuildContext context) {
    if (!isTutorial) return;
    FocusState focusState = args.focusLogic.focusState.value;
    if (focusState != FocusState.start) return;
    Future.delayed(AppConfig.animationConfig.middleAnimationDuration, () {
      tutorialTargetFocus.clear();
      buildAndAddTargetFocus(
        "fullscreen_button",
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => HgNeumorphicText("点击可全屏显示"),
          ),
        ],
      );
      List<int> keyOrder = tutorialIndex.keys.toList();
      keyOrder.sort((a, b) => a - b);
      List<TargetFocus> targets = [];
      for (var order in keyOrder) {
        String keyStr = tutorialIndex[order]!;
        TargetFocus? targetFocus = tutorialTargetFocus[keyStr];
        if (null == targetFocus) continue;
        targets.add(targetFocus);
      }
      TutorialViewLogic.showTutorial(context, targets, homePage, tutorialSubKey);
    });
  }

  @override
  String? get tutorialSubKey => "count";

  @override
  HomePages get homePage => HomePages.focus;
}

/// 页面
abstract class BaseCount<T extends BaseCountLogic> extends View<T> {
  BaseCount({
    required String key,
    required BaseCountArgs args,
    required T newLogic,
  }) : super(key: key, args: args, newLogic: newLogic);

  @override
  Widget buildView(BuildContext context) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Neumorphic(
      margin: const EdgeInsets.all(12),
      style: NeumorphicStyle(boxShape: const NeumorphicBoxShape.circle(), depth: -themeData.depth),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 进度条
          AspectRatio(aspectRatio: 1, child: buildIndicator()),
          // 时间
          AspectRatio(
            aspectRatio: 1,
            child: Obx(() {
              FocusState focusState = logic.args.focusLogic.focusState.value;
              logic.showTutorial(context);
              return HgNeumorphicButton(
                key: logic.addTutorialTargetKey(0, "fullscreen_button"),
                margin: const EdgeInsets.all(16),
                style: NeumorphicStyle(
                  boxShape: const NeumorphicBoxShape.circle(),
                  depth: focusState == FocusState.stop ? 0 : themeData.depth,
                  border: focusState == FocusState.stop ? const NeumorphicBorder.none() : const NeumorphicBorder(),
                ),
                child: Center(child: buildContent()),
                onPressed: showOverlay,
              );
            }),
          ),
        ],
      ),
    );
  }

  /// 点击内容回调
  void showOverlay() async {
    FocusState focusState = logic.args.focusLogic.focusState.value;
    if (logic.milliseconds.value <= 0 || focusState != FocusState.start) return;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    RouteHelper.overlay(
      buildOverlay(),
      backgroundColor: themeData.baseColor,
      onClose: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      },
    );
  }

  /// 全屏界面的组件
  Widget buildOverlay() {
    return Obx(() {
      // 计数 秒为单位
      int seconds = logic.countSeconds.value;
      debugPrint("$seconds");
      // 播放声音
      logic.play();
      // 每秒一次查看屏幕方向
      DeviceOrientation? currentDeviceOrientation = MainLogic.instance.deviceOrientation;
      return buildRxClock(currentDeviceOrientation);
    });
  }

  /// 构建反应式时钟bb
  Widget buildRxClock(DeviceOrientation? deviceOrientation);

  /// 构建覆盖的时钟
  Widget buildOverlayClock({
    required int countSeconds,
    required DeviceOrientation? deviceOrientation,
  }) {
    // 屏幕宽度
    double screenWidth;
    // 旋转
    int quarterTurns;
    if (deviceOrientation == DeviceOrientation.landscapeLeft) {
      screenWidth = Get.height;
      quarterTurns = 3;
    } else if (deviceOrientation == DeviceOrientation.landscapeRight) {
      screenWidth = Get.height;
      quarterTurns = 1;
    } else {
      screenWidth = Get.width;
      quarterTurns = 0;
    }
    double width = screenWidth / 14;
    int hours = countSeconds ~/ (60 * 60);
    int minutes = (countSeconds - hours * 60 * 60) ~/ (60);
    int seconds = countSeconds - hours * 60 * 60 - minutes * 60;
    String text = "${hours.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
    List<Widget> children = [];
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    List<String> characters = text.characters.toList();
    for (int i = 0; i < characters.length; i++) {
      String character = characters[i];
      double size = character == ":" ? width : width * 2;
      children.add(SizedBox(
        width: size,
        height: size,
        child: FittedBox(
          child: NeumorphicText(
            character,
            key: ValueKey(character),
            textStyle: NeumorphicTextStyle(fontWeight: FontWeight.bold),
            style: NeumorphicStyle(depth: 1, border: const NeumorphicBorder.none(), color: themeData.defaultTextColor),
          ),
        ),
      ));
    }
    return RotatedBox(
      key: ValueKey(logic.key),
      quarterTurns: quarterTurns,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElasticIn(
                key: ValueKey("${logic.key}_${deviceOrientation}_time"),
                child: Row(children: children),
              ),
            ],
          ),
          Positioned(
            child: FadeIn(
              key: ValueKey("${logic.key}_${deviceOrientation}_tool"),
              child: buildSoundSwitch(),
            ),
            bottom: 24,
            right: 24,
          ),
        ],
      ),
    );
  }

  /// 构建声音开关
  Widget buildSoundSwitch() {
    BaseDeviceInfo deviceInfo = DeviceInfoHelper.deviceInfo;
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = deviceInfo as IosDeviceInfo;
      String version = iosDeviceInfo.systemVersion ?? "12.0";
      double versionD = double.parse(version);
      if (versionD < 14.5) {
        return Container();
      }
    }
    return Obx(
      () => NeumorphicSwitch(
        value: logic.playSound.value,
        onChanged: logic.setPlaySound,
        child: Icon(logic.playSound.value ? Icons.volume_up : Icons.volume_off),
      ),
    );
  }

  /// 构建倒计时
  Widget buildIndicator() {
    return Container();
  }

  /// 构建内容
  Widget buildContent() {
    return Container();
  }
}
