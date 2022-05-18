import 'package:date_format/date_format.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/export.dart';
import 'package:numberpicker/numberpicker.dart';

@immutable
class TimeRangePickerArgs extends ViewArgs {
  /// 初始化开始时间
  final DateTime initialStart;

  /// 初始化结束时间
  final DateTime initialEnd;

  /// 开始日期
  final DateTime firstDate;

  /// 结束日期
  final DateTime lastDate;

  /// 开始事件变化回调
  final ValueChanged<DateTime>? onStartChanged;

  /// 结束时间变化回调
  final ValueChanged<DateTime>? onEndChanged;

  TimeRangePickerArgs({
    required this.firstDate,
    required this.lastDate,
    required this.initialStart,
    required this.initialEnd,
    this.onStartChanged,
    this.onEndChanged,
  }) {
    assert(initialStart.isSameDay(initialEnd));
  }
}

/// 逻辑
class TimeRangePickerLogic extends ViewLogicOnlyArgs<TimeRangePickerArgs> {
  /// 开始时间
  Rx<DateTime> start = DateTime.now().obs;

  /// 结束时间
  Rx<DateTime> end = DateTime.now().obs;

  /// 日期
  Rx<DateTime> date = DateTime.now().obs;

  /// 月份
  Rx<DateTime> month = DateTime.now().obs;

  /// 打开回调
  @override
  void afterArgsUpdate() {
    start.value = args.initialStart;
    end.value = args.initialEnd;
    date.value = DateTime(start.value.year, start.value.month, start.value.day);
    month.value = date.value;
  }

  void setMonth(DateTime start, DateTime end) {
    month.value = start;
  }

  /// 设置日期
  void setDate(DateTime date) {
    this.date.value = date;
    start.value = DateTime(date.year, date.month, date.day, start.value.hour, start.value.minute);
    end.value = DateTime(date.year, date.month, date.day, end.value.hour, end.value.minute);
    args.onStartChanged?.call(start.value);
    args.onEndChanged?.call(end.value);
  }

  /// 起始时间设置
  void setStartHour(int value) {
    start.value = DateTime(date.value.year, date.value.month, date.value.day, value, start.value.minute);
    args.onStartChanged?.call(start.value);
    if (start.value.isAfter(end.value)) {
      end.value = start.value;
      args.onEndChanged?.call(end.value);
    }
  }

  /// 结束时间设置
  void setEndHour(int value) {
    end.value = DateTime(date.value.year, date.value.month, date.value.day, value, end.value.minute);
    args.onEndChanged?.call(end.value);
    if (end.value.isBefore(start.value)) {
      start.value = end.value;
      args.onStartChanged?.call(start.value);
    }
  }

  /// 起始时间设置
  void setStartMinute(int value) {
    start.value = DateTime(date.value.year, date.value.month, date.value.day, start.value.hour, value);
    args.onStartChanged?.call(start.value);
    if (start.value.isAfter(end.value)) {
      end.value = start.value;
      args.onEndChanged?.call(end.value);
    }
  }

  /// 结束时间设置
  void setEndMinute(int value) {
    end.value = DateTime(date.value.year, date.value.month, date.value.day, end.value.hour, value);
    args.onEndChanged?.call(end.value);
    if (end.value.isBefore(start.value)) {
      start.value = end.value;
      args.onStartChanged?.call(start.value);
    }
  }
}

/// 页面
class TimeRangePicker extends View<TimeRangePickerLogic> {
  TimeRangePicker({
    required String key,
    required TimeRangePickerArgs args,
  }) : super(key: key, args: args, newLogic: TimeRangePickerLogic());

  @override
  Widget buildView(BuildContext context) {
    return Column(
      children: [
        buildDatePicker(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildStart(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildEnd(),
      ],
    );
  }

  /// 日期选择器
  Widget buildDatePicker() {
    return HgNeumorphicExpandedButton(
      key: "time_rage_picker_data_picker",
      args: HgNeumorphicExpandedButtonArgs(
        left: Obx(() => Text("日期:" + DateTimeUtil.dateFormat(logic.date.value))),
        containerPadding: EdgeInsets.zero,
        rowPadding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Obx(() => Text(DateTimeUtil.format(logic.month.value, formats: [yyyy, "年", mm, "月"]))),
            const Padding(padding: EdgeInsets.only(bottom: 6)),
            Obx(() {
              List<DateTime> selected = [];
              selected.add(logic.date.value);
              return Calendar(
                key: 'time_rage_picker_data_picker',
                args: CalendarArgs(
                  mode: CalendarMode.month,
                  initialDate: logic.date.value,
                  firstDate: logic.args.firstDate,
                  lastDate: logic.args.lastDate,
                  selected: selected,
                  onPageChange: logic.setMonth,
                  onDateSelect: logic.setDate,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// 开始时间选择
  Widget buildStart() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicExpandedButton(
      key: "time_rage_picker_start_time_picker",
      args: HgNeumorphicExpandedButtonArgs(
        left: Obx(() => Text("开始时间:" + DateTimeUtil.timeFormat(logic.start.value))),
        containerPadding: EdgeInsets.zero,
        rowPadding: const EdgeInsets.all(8),
        child: Neumorphic(
          style: NeumorphicStyle(depth: -themeData.depth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(() => buildNumberPicker(
                    key: "time_rage_picker_start_time_picker_start_hour",
                    min: 0,
                    max: 23,
                    value: logic.start.value.hour,
                    onChanged: logic.setStartHour,
                    title: "时",
                  )),
              Obx(() => buildNumberPicker(
                    key: "time_rage_picker_start_time_picker_start_minute",
                    min: 0,
                    max: 59,
                    value: logic.start.value.minute,
                    onChanged: logic.setStartMinute,
                    title: "分",
                  )),
            ],
          ),
        ),
      ),
    );
  }

  /// 结束时间选择
  Widget buildEnd() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicExpandedButton(
      key: "time_rage_picker_end_time_picker",
      args: HgNeumorphicExpandedButtonArgs(
        left: Obx(() => Text("结束时间:" + DateTimeUtil.timeFormat(logic.end.value))),
        containerPadding: EdgeInsets.zero,
        rowPadding: const EdgeInsets.all(8),
        child: Neumorphic(
          style: NeumorphicStyle(depth: -themeData.depth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(() => buildNumberPicker(
                    key: "time_rage_picker_end_time_picker_end_hour",
                    min: 0,
                    max: 23,
                    value: logic.end.value.hour,
                    onChanged: logic.setEndHour,
                    title: "时",
                  )),
              Obx(() => buildNumberPicker(
                    key: "time_rage_picker_end_time_picker_end_minute",
                    min: 0,
                    max: 59,
                    value: logic.end.value.minute,
                    onChanged: logic.setEndMinute,
                    title: "分",
                  )),
            ],
          ),
        ),
      ),
    );
  }

  /// 数字选择器
  Widget buildNumberPicker({
    required String key,
    required int max,
    required int min,
    required int value,
    required Function(int value) onChanged,
    required String title,
  }) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Row(
      children: [
        Neumorphic(
          margin: const EdgeInsets.all(16),
          child: NumberPicker(
            key: ValueKey(key),
            minValue: min,
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
