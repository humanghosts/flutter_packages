import 'package:date_format/date_format.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/export.dart';
import 'package:numberpicker/numberpicker.dart';

@immutable
class DateTimePickerArgs extends ViewArgs {
  /// 最小日期
  final DateTime firstDate;

  /// 默认日期
  final DateTime initialDate;

  /// 最大日期
  final DateTime lastDate;

  /// 日期变化回调
  final ValueChanged<DateTime>? onDateTimeChanged;

  const DateTimePickerArgs({
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
    this.onDateTimeChanged,
  });
}

/// 逻辑
class DateTimePickerLogic extends ViewLogicOnlyArgs<DateTimePickerArgs> {
  /// 当前月份
  Rx<DateTime> month = DateTime.now().obs;

  /// 当前日期
  Rx<DateTime> dateTime = DateTime.now().obs;

  /// 打开回调
  @override
  void afterArgsUpdate() {
    month.value = args.initialDate;
    dateTime.value = args.initialDate;
  }

  /// 月份设置
  void setMonth(DateTime start, DateTime end) {
    month.value = start;
  }

  /// 日期设置
  void setDate(DateTime date) {
    dateTime.value = DateTime(date.year, date.month, date.day, dateTime.value.hour, dateTime.value.minute);
    args.onDateTimeChanged?.call(dateTime.value);
  }

  /// 时间设置
  void setHour(int value) {
    dateTime.value = DateTime(dateTime.value.year, dateTime.value.month, dateTime.value.day, value, dateTime.value.minute);
    args.onDateTimeChanged?.call(dateTime.value);
  }

  /// 分钟设置
  void setMinute(int value) {
    dateTime.value = DateTime(dateTime.value.year, dateTime.value.month, dateTime.value.day, dateTime.value.hour, value);
    args.onDateTimeChanged?.call(dateTime.value);
  }
}

/// 页面
class DateTimePicker extends View<DateTimePickerLogic> {
  DateTimePicker({
    required String key,
    required DateTimePickerArgs args,
  }) : super(key: key, args: args, newLogic: DateTimePickerLogic());

  /// 构建容器
  @override
  Widget buildView(BuildContext context) {
    return Column(
      children: [
        buildDatePicker(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildTimePicker(),
      ],
    );
  }

  /// 日期选择器
  Widget buildDatePicker() {
    return HgNeumorphicExpandedButton(
      key: "date_time_picker_date",
      args: HgNeumorphicExpandedButtonArgs(
        left: Obx(() => Text("日期:" + DateTimeUtil.dateFormat(logic.dateTime.value))),
        containerPadding: EdgeInsets.zero,
        rowPadding: const EdgeInsets.all(8),
        child: buildCalendar(),
      ),
    );
  }

  /// 构建日历
  Widget buildCalendar() {
    return Column(
      children: [
        Obx(() => Text(DateTimeUtil.format(logic.month.value, formats: [yyyy, "年", mm, "月"]))),
        const Padding(padding: EdgeInsets.only(bottom: 6)),
        Obx(
          () => Calendar(
            key: 'filter_custom_date',
            args: CalendarArgs(
              mode: CalendarMode.month,
              initialDate: logic.dateTime.value,
              firstDate: logic.args.firstDate,
              lastDate: logic.args.lastDate,
              selected: [logic.dateTime.value],
              onPageChange: logic.setMonth,
              onDateSelect: logic.setDate,
            ),
          ),
        ),
      ],
    );
  }

  /// 时间选择器
  Widget buildTimePicker() {
    return HgNeumorphicExpandedButton(
      key: "date_time_picker_time",
      args: HgNeumorphicExpandedButtonArgs(
        left: Obx(() => Text("时间:" + DateTimeUtil.timeFormat(logic.dateTime.value))),
        containerPadding: EdgeInsets.zero,
        rowPadding: const EdgeInsets.all(8),
        child: buildTime(),
      ),
    );
  }

  /// 构建时间
  Widget buildTime() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Neumorphic(
      style: NeumorphicStyle(depth: -themeData.depth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(() => buildNumberPicker(23, logic.dateTime.value.hour, logic.setHour, "时")),
          Obx(() => buildNumberPicker(59, logic.dateTime.value.minute, logic.setMinute, "分")),
        ],
      ),
    );
  }

  /// 数字选择器
  Widget buildNumberPicker(int max, int value, Function(int value) onChanged, String title) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Row(
      children: [
        Neumorphic(
          margin: const EdgeInsets.all(16),
          child: NumberPicker(
            key: ValueKey(key.toString() + max.toString()),
            minValue: 0,
            maxValue: max,
            itemCount: 5,
            itemHeight: 30,
            infiniteLoop: false,
            value: value,
            onChanged: onChanged,
            zeroPad: true,
            haptics: true,
            selectedTextStyle: TextStyle(color: themeData.defaultTextColor, fontSize: 24, fontWeight: FontWeight.w500),
            textStyle: TextStyle(color: themeData.disabledColor, fontSize: 12, fontWeight: FontWeight.w300),
          ),
        ),
        Text(title),
      ],
    );
  }
}
