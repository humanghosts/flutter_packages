import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';
import 'package:numberpicker/numberpicker.dart';

/// 外部参数
@immutable
class ScheduleSettingsArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 上级导航id
  final int parentNavigatorId;

  /// 保存回调
  final Function(ScheduleConfig config)? onDone;

  const ScheduleSettingsArgs({
    required this.navigatorId,
    required this.parentNavigatorId,
    this.onDone,
  });
}

/// 外部数据源
@immutable
class ScheduleSettingsDataSource extends ViewDataSource {
  final ScheduleConfig config;

  const ScheduleSettingsDataSource({required this.config});
}

class ScheduleSettingsLogic extends ViewLogic<ScheduleSettingsArgs, ScheduleSettingsDataSource> {
  /// 结束提醒更新标识
  Rx<bool> isSendDayEndNoticeValue = false.obs;
  Rx<int> dayEndNoticeTimeHour = 0.obs;
  Rx<int> dayEndNoticeTimeMinute = 0.obs;

  /// 开始提醒更新标识
  Rx<bool> isSendDayStartNoticeValue = false.obs;
  Rx<int> dayStartNoticeTimeHour = 0.obs;
  Rx<int> dayStartNoticeTimeMinute = 0.obs;

  @override
  void afterArgsUpdate() {
    isSendDayStartNoticeValue.value = dataSource.config.isSendDayStartNotice.value;
    dayStartNoticeTimeHour.value = dataSource.config.sendDayStartNoticeTime.value.hour;
    dayStartNoticeTimeMinute.value = dataSource.config.sendDayStartNoticeTime.value.minute;
    isSendDayEndNoticeValue.value = dataSource.config.isSendDayEndNotice.value;
    dayEndNoticeTimeHour.value = dataSource.config.sendDayEndNoticeTime.value.hour;
    dayEndNoticeTimeMinute.value = dataSource.config.sendDayEndNoticeTime.value.minute;
  }

  /// 返回按钮
  void back() {
    RouteHelper.back(id: args.parentNavigatorId);
  }

  /// 确定按钮
  void done() {
    RouteHelper.back(id: args.parentNavigatorId);
    args.onDone?.call(dataSource.config);
  }

  /// 设置发送状态处理提醒后
  void afterSetIsSendStart() {
    ScheduleConfig config = dataSource.config;
    bool isSend = config.isSendDayStartNotice.value;
    if (isSend) {
      DateTime now = DateTime.now();
      DateTime dateTime = config.sendDayStartNoticeTime.value;
      config.sendDayStartNoticeTime.value = DateTime(now.year, now.month, now.day, dateTime.hour, dateTime.minute);
    }
    isSendDayStartNoticeValue.value = config.isSendDayStartNotice.value;
  }

  void afterSetIsSendEnd() {
    ScheduleConfig config = dataSource.config;
    bool isSend = config.isSendDayEndNotice.value;
    if (isSend) {
      DateTime now = DateTime.now();
      DateTime dateTime = config.sendDayEndNoticeTime.value;
      config.sendDayEndNoticeTime.value = DateTime(now.year, now.month, now.day, dateTime.hour, dateTime.minute);
    }
    isSendDayEndNoticeValue.value = config.isSendDayEndNotice.value;
  }

  void setStartTimeHour(int value) {
    ScheduleConfig config = dataSource.config;
    DateTime dateTime = config.sendDayStartNoticeTime.value;
    DateTime now = DateTime.now();
    if (dateTime.hour != value) {
      config.sendDayStartNoticeTime.value = DateTime(now.year, now.month, now.day, value, dateTime.minute);
      dayStartNoticeTimeHour.value = config.sendDayStartNoticeTime.value.hour;
    }
  }

  void setStartTimeMinute(int value) {
    ScheduleConfig config = dataSource.config;
    DateTime dateTime = config.sendDayStartNoticeTime.value;
    DateTime now = DateTime.now();
    if (dateTime.minute != value) {
      config.sendDayStartNoticeTime.value = DateTime(now.year, now.month, now.day, dateTime.hour, value);
      dayStartNoticeTimeMinute.value = config.sendDayStartNoticeTime.value.minute;
    }
  }

  void setEndTimeHour(int value) {
    ScheduleConfig config = dataSource.config;
    DateTime dateTime = config.sendDayEndNoticeTime.value;
    DateTime now = DateTime.now();
    if (dateTime.hour != value) {
      config.sendDayEndNoticeTime.value = DateTime(now.year, now.month, now.day, value, dateTime.minute);
      dayEndNoticeTimeHour.value = config.sendDayEndNoticeTime.value.hour;
    }
  }

  void setEndTimeMinute(int value) {
    ScheduleConfig config = dataSource.config;
    DateTime dateTime = config.sendDayEndNoticeTime.value;
    DateTime now = DateTime.now();
    if (dateTime.minute != value) {
      config.sendDayEndNoticeTime.value = DateTime(now.year, now.month, now.day, dateTime.hour, value);
      dayEndNoticeTimeMinute.value = config.sendDayEndNoticeTime.value.minute;
    }
  }

  /// 设置bool值
  void setBool(bool value, Attribute<bool> attribute, Rx<bool> rxValue, {VoidCallback? afterSet}) {
    attribute.value = value;
    rxValue.value = value;
    HapticFeedback.selectionClick();
    afterSet?.call();
  }
}

/// 页面
class ScheduleSettings extends View<ScheduleSettingsLogic> {
  ScheduleSettings({
    required String key,
    required ScheduleSettingsArgs args,
    required ScheduleSettingsDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: ScheduleSettingsLogic());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      trailing: HgNeumorphicDoneButton(onPressed: logic.done),
      title: HgNeumorphicText("日程设置"),
      body: ListView(
        clipBehavior: Clip.none,
        padding: EdgeInsets.only(bottom: Get.height * 0.5),
        children: buildSettings(),
      ),
    );
  }

  List<Widget> buildSettings() {
    ScheduleConfig config = logic.dataSource.config;
    return [
      // 是否提醒
      buildBool(config.isSendDayStartNotice, logic.isSendDayStartNoticeValue, afterSet: logic.afterSetIsSendStart),
      const Padding(padding: EdgeInsets.only(bottom: 16)),
      // 提醒时间
      Obx(() {
        bool isSend = logic.isSendDayStartNoticeValue.value;
        if (!isSend) return Container();
        return Padding(
          child: buildSendNoticeTime(
            logic.dataSource.config.sendDayStartNoticeTime,
            logic.dayStartNoticeTimeHour,
            logic.dayStartNoticeTimeMinute,
            logic.setStartTimeHour,
            logic.setStartTimeMinute,
          ),
          padding: const EdgeInsets.only(bottom: 16),
        );
      }), // 是否提醒
      buildBool(config.isSendDayEndNotice, logic.isSendDayEndNoticeValue, afterSet: logic.afterSetIsSendEnd),
      const Padding(padding: EdgeInsets.only(bottom: 16)),
      // 提醒时间
      Obx(() {
        bool isSend = logic.isSendDayEndNoticeValue.value;
        if (!isSend) return Container();
        return buildSendNoticeTime(
          logic.dataSource.config.sendDayEndNoticeTime,
          logic.dayEndNoticeTimeHour,
          logic.dayEndNoticeTimeMinute,
          logic.setEndTimeHour,
          logic.setEndTimeMinute,
        );
      }),
    ];
  }

  /// 提醒发送时间
  Widget buildSendNoticeTime(
    Attribute attribute,
    Rx<int> rxHour,
    Rx<int> rxMinute,
    ValueChanged<int> setHour,
    ValueChanged<int> setMinute,
  ) {
    return NeumorphicFormField(
      title: Obx(
        () => Text(
          "${attribute.title} "
          "${rxHour.value.toString().padLeft(2, "0")}:"
          "${rxMinute.value.toString().padLeft(2, "0")}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      comment: attribute.comment,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildNumberPicker(23, rxHour, setHour),
            const Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
            buildNumberPicker(59, rxMinute, setMinute),
          ],
        ),
      ),
    );
  }

  /// 数字选择器
  Widget buildNumberPicker(int max, Rx<int> value, Function(int value) onChanged) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Neumorphic(
      child: Obx(
        () => NumberPicker(
          key: ValueKey("auto_status_datetime_time_$max"),
          minValue: 0,
          maxValue: max,
          itemCount: 3,
          itemHeight: 50,
          itemWidth: 50 / 0.618,
          value: value.value,
          onChanged: onChanged,
          zeroPad: true,
          haptics: true,
          selectedTextStyle: TextStyle(color: themeData.defaultTextColor, fontSize: 24, fontWeight: FontWeight.w500),
          textStyle: TextStyle(color: themeData.disabledColor, fontSize: 12, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  /// 构建布尔类型设置
  Widget buildBool(
    Attribute<bool> attribute,
    Rx<bool> rx, {
    VoidCallback? afterSet,
    GlobalKey? key,
    GlobalKey? commentKey,
  }) {
    return NeumorphicFormField(
      title: Text(attribute.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      comment: attribute.comment,
      fieldStyle: NeumorphicStyle(disableDepth: true, boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18))),
      child: Obx(
        () => NeumorphicSwitch(
          value: rx.value,
          onChanged: (value) => logic.setBool(value, attribute, rx, afterSet: afterSet),
        ),
      ),
    );
  }
}
