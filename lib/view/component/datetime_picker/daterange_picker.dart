import 'package:date_format/date_format.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/export.dart';

@immutable
class DateRangePickerArgs extends ViewArgs {
  /// 开始日期
  final DateTime? initialStart;

  /// 结束日期
  final DateTime? initialEnd;

  /// 最小日期
  final DateTime firstDate;

  /// 最大日期
  final DateTime lastDate;

  /// 开始日期变化回调
  final ValueChanged<DateTime>? onStartChanged;

  /// 结束日期变化回调
  final ValueChanged<DateTime>? onEndChanged;

  const DateRangePickerArgs({
    required this.firstDate,
    required this.lastDate,
    this.initialStart,
    this.initialEnd,
    this.onEndChanged,
    this.onStartChanged,
  });
}

/// 逻辑
class DateRangePickerLogic extends ViewLogicOnlyArgs<DateRangePickerArgs> {
  /// 开始日期所在月份
  Rx<DateTime> startMonth = DateTime.now().obs;

  /// 结束日期所在月份
  Rx<DateTime> endMonth = DateTime.now().obs;

  /// 开始日期
  Rx<DateTime> start = DateTime.now().obs;

  /// 结束日期
  Rx<DateTime> end = DateTime.now().obs;

  /// 打开回调
  @override
  void afterArgsUpdate() {
    startMonth.value = args.initialStart ?? DateTime.now();
    start.value = args.initialStart ?? DateTime.now();
    endMonth.value = args.initialEnd ?? DateTime.now();
    end.value = args.initialEnd ?? DateTime.now();
  }

  /// 起始月份设置
  void setStartMonth(DateTime start, DateTime end) {
    startMonth.value = end;
  }

  /// 结束月份设置
  void setEndMonth(DateTime start, DateTime end) {
    endMonth.value = start;
  }

  /// 起始日期设置
  void setStartDate(DateTime date) {
    start.value = DateTime(date.year, date.month, date.day);
    args.onStartChanged?.call(start.value);
    if (start.value.isAfter(end.value)) {
      end.value = start.value;
      endMonth.value = end.value;
      args.onEndChanged?.call(end.value);
    }
  }

  /// 结束日期设置
  void setEndDate(DateTime date) {
    DateTime nextDay = DateTime(date.year, date.month, date.day + 1);
    end.value = DateTime(
      nextDay.year,
      nextDay.month,
      nextDay.day,
      nextDay.hour,
      nextDay.minute,
      nextDay.second,
      nextDay.millisecond,
      nextDay.microsecond - 1,
    );
    args.onEndChanged?.call(end.value);
    if (end.value.isBefore(start.value)) {
      start.value = end.value;
      startMonth.value = start.value;
      args.onStartChanged?.call(start.value);
    }
  }
}

/// 页面
class DateRangePicker extends View<DateRangePickerLogic> {
  DateRangePicker({
    required String key,
    required DateRangePickerArgs args,
  }) : super(key: key, args: args, newLogic: DateRangePickerLogic());

  /// 构建容器
  @override
  Widget buildView(BuildContext context) {
    return Column(children: [buildStart(), const Padding(padding: EdgeInsets.only(top: 16)), buildEnd()]);
  }

  /// 开始日期
  Widget buildStart() {
    return buildDatePicker(
      initial: logic.start,
      title: "开始日期",
      month: logic.startMonth,
      onMonthChanged: logic.setStartMonth,
      onDateChanged: logic.setStartDate,
    );
  }

  /// 结束日期
  Widget buildEnd() {
    return buildDatePicker(
      initial: logic.end,
      title: "结束日期",
      month: logic.endMonth,
      onMonthChanged: logic.setEndMonth,
      onDateChanged: logic.setEndDate,
    );
  }

  /// 日期选择器
  Widget buildDatePicker({
    required Rx<DateTime> initial,
    required String title,
    required Rx<DateTime> month,
    required Function(DateTime start, DateTime end) onMonthChanged,
    required ValueChanged<DateTime> onDateChanged,
  }) {
    return HgNeumorphicExpandedButton(
      key: "date_rage_picker_$title",
      args: HgNeumorphicExpandedButtonArgs(
        left: Obx(() => Text("$title:" + DateTimeUtil.dateFormat(initial.value))),
        containerPadding: EdgeInsets.zero,
        rowPadding: const EdgeInsets.all(8),
        child: buildCalendar(
          key: "date_rage_picker_$title",
          initial: initial,
          month: month,
          onMonthChanged: onMonthChanged,
          onDateChanged: onDateChanged,
        ),
      ),
    );
  }

  /// 构建日历
  Widget buildCalendar({
    required String key,
    Rx<DateTime>? initial,
    required Rx<DateTime> month,
    required Function(DateTime start, DateTime end) onMonthChanged,
    required ValueChanged<DateTime> onDateChanged,
  }) {
    return Column(
      children: [
        Obx(() => Text(DateTimeUtil.format(month.value, formats: [yyyy, "年", mm, "月"]))),
        const Padding(padding: EdgeInsets.only(bottom: 6)),
        Obx(() {
          List<DateTime> selected = [];
          if (initial != null) selected.add(initial.value);
          return Calendar(
            key: key,
            args: CalendarArgs(
              mode: CalendarMode.month,
              initialDate: initial?.value ?? DateTime.now(),
              firstDate: logic.args.firstDate,
              lastDate: logic.args.lastDate,
              selected: selected,
              onPageChange: onMonthChanged,
              onDateSelect: onDateChanged,
            ),
          );
        }),
      ],
    );
  }
}
