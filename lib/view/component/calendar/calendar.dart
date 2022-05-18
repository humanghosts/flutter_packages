import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/export.dart';
import 'package:lunar/lunar.dart';

/// 日历模式
enum CalendarMode {
  /// 月视图
  month,

  /// 周视图
  week,
}

/// 外部参数
@immutable
class CalendarArgs extends ViewArgs {
  /// 日历模式
  final CalendarMode mode;

  /// 初始化时间
  final DateTime initialDate;

  /// 最小时间
  final DateTime firstDate;

  /// 最大时间
  final DateTime lastDate;

  /// 日期选中事件
  final void Function(DateTime dateTime)? onDateSelect;

  /// 选中的日期
  final List<DateTime> selected;

  /// 日历翻页回调
  final void Function(DateTime start, DateTime end)? onPageChange;

  /// 日历样式
  final NeumorphicStyle? style;

  final Widget Function({required DateTime dateTime, required Widget child, required bool isEnable})? wrapper;

  CalendarArgs({
    this.mode = CalendarMode.month,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.selected = const [],
    this.onDateSelect,
    this.onPageChange,
    this.style,
    this.wrapper,
  }) {
    assert(firstDate.isBeforeOrEquals(lastDate));
    assert(firstDate.isBeforeOrEquals(initialDate));
    assert(lastDate.isAfterOrEquals(initialDate));
  }
}

/// 逻辑
class CalendarLogic extends ViewLogicOnlyArgs<CalendarArgs> {
  List<String> weekOfDayText = ["周一", "周二", "周三", "周四", "周五️", "周六", "周日"];

  PageController pageController = PageController(initialPage: 0);

  DateTime start = DateTime.now();
  DateTime end = DateTime.now();

  /// 选中时间
  final Set<int> selected = {};

  @override
  void afterArgsUpdate() {
    selected.clear();
    if (args.selected.isNotEmpty) {
      for (DateTime select in args.selected) {
        selected.add(DateTime(select.year, select.month, select.day).millisecondsSinceEpoch);
      }
    }
    int index = getPageIndex();
    if (pageController.positions.isEmpty) {
      pageController = PageController(initialPage: index);
      return;
    }
    double currentPage = pageController.page ?? 0;
    if ((index - currentPage).abs() > 2) {
      pageController.jumpToPage(index);
    } else {
      pageController.animateToPage(index, duration: AppConfig.animationConfig.middleAnimationDuration, curve: Curves.linear);
    }
  }

  int getPageSize() {
    // 最小时间
    DateTime first = DateTime(args.firstDate.year, args.firstDate.month, args.firstDate.day);
    // 最大时间
    DateTime last = DateTime(args.lastDate.year, args.lastDate.month, args.lastDate.day);
    if (args.mode == CalendarMode.month) {
      int firstYear = first.year;
      int firstMonth = first.month;
      int lastYear = last.year;
      int lastMonth = last.month;
      // 当前时间与开始时间差值
      return (lastYear - firstYear - 1) * 12 + lastMonth + 12 - firstMonth;
    }
    if (args.mode == CalendarMode.week) {
      int firstWeekday = first.weekday;
      int lastWeekday = last.weekday;
      // 天数差
      int firstLastDayDiff = (last.difference(first).inDays + 1) + (firstWeekday - DateTime.monday) + (DateTime.sunday - lastWeekday);
      // 周数 最小是1
      int firstLastWeekDiff = firstLastDayDiff ~/ 7;
      return firstLastWeekDiff;
    }
    return 0;
  }

  int getPageIndex() {
    // 最小时间
    DateTime first = DateTime(args.firstDate.year, args.firstDate.month, args.firstDate.day);
    // 当前时间
    DateTime current = DateTime(args.initialDate.year, args.initialDate.month, args.initialDate.day);
    if (args.mode == CalendarMode.month) {
      int firstYear = first.year;
      int firstMonth = first.month;
      int currentYear = current.year;
      int currentMonth = current.month;
      // 当前时间与开始时间差值
      return (currentYear - firstYear - 1) * 12 + currentMonth + 12 - firstMonth;
    }
    if (args.mode == CalendarMode.week) {
      int firstWeekday = first.weekday;
      int currentWeekday = current.weekday;
      // 当前时间与开始时间周数 最小是1
      int currentFirstWeekDiff = (current.difference(first).inDays + 1) + (firstWeekday - DateTime.monday) + (DateTime.sunday - currentWeekday);
      // 初始页数
      return currentFirstWeekDiff ~/ 7 - 1;
    }
    return 0;
  }

  /// 日期选择
  void selectDate(DateTime dateTime) {
    args.onDateSelect?.call(dateTime);
  }

  @override
  void onWidgetInitState(BuildContext context, GetBuilderState state) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      args.onPageChange?.call(start, end);
    });
  }

  @override
  void onWidgetDidUpdateWidget(BuildContext context, GetBuilder<GetxController> oldWidget, GetBuilderState<GetxController> state) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      args.onPageChange?.call(start, end);
    });
  }
}

/// 页面
class Calendar extends View<CalendarLogic> {
  Calendar({required String key, required CalendarArgs args}) : super(key: key, args: args, newLogic: CalendarLogic());

  /// 构建日历需要的东西
  /// 1.按照月/周视图显示
  /// 2.月视图非本月的灰色显示，所有视图非限定范围的灰色显示且不可选取
  /// 3.月视图 每月35天
  @override
  Widget buildView(BuildContext context) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    bool isMonth = logic.args.mode == CalendarMode.month;
    return Container(
      clipBehavior: Clip.none,
      height: isMonth ? 290 : 85,
      child: Neumorphic(
        padding: const EdgeInsets.symmetric(vertical: 4),
        style: logic.args.style ?? NeumorphicStyle(depth: -themeData.depth),
        child: Column(
          children: [
            Expanded(flex: 0, child: buildDayOfWeek()),
            Expanded(child: buildCalendar()),
          ],
        ),
      ),
    );
  }

  Widget buildCalendar() {
    if (logic.args.mode == CalendarMode.month) {
      return buildMonthCalendar();
    } else if (logic.args.mode == CalendarMode.week) {
      return buildWeekCalendar();
    } else {
      return Container();
    }
  }

  /// 构建周标题
  Widget buildDayOfWeek() {
    List<Widget> children = [];
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    for (String text in logic.weekOfDayText) {
      children.add(Neumorphic(
        padding: const EdgeInsets.all(6),
        style: const NeumorphicStyle(disableDepth: true, border: NeumorphicBorder.none()),
        child: Center(child: Text(text, style: TextStyle(color: themeData.disabledColor))),
      ));
    }
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: children);
  }

  /// 构建月历
  Widget buildMonthCalendar() {
    return buildPage("month", buildMonth, (index) {
      // 开日日期
      DateTime first = logic.args.firstDate;
      // 当月1号
      DateTime month = DateTime(first.year, first.month + index, 1);
      DateTime monthEnd = DateTime(month.year, month.month + 1, 1).add(const Duration(days: -1));
      logic.start = month;
      logic.end = monthEnd;
      logic.args.onPageChange?.call(month, monthEnd);
    });
  }

  /// 构建日历页
  Widget buildPage(String key, Widget Function(int index) builder, Function(int index) onIndexChange) {
    return PageView.builder(
      key: ValueKey(key),
      itemCount: logic.getPageSize(),
      controller: logic.pageController,
      itemBuilder: (context, index) {
        return builder(index);
      },
      onPageChanged: onIndexChange,
      clipBehavior: Clip.none,
    );
  }

  /// 构建月份
  /// [monthIndex]值从firstDate开始的月份序号
  Widget buildMonth(int monthIndex) {
    // 开日日期
    DateTime first = DateTime(logic.args.firstDate.year, logic.args.firstDate.month, logic.args.firstDate.day);
    DateTime last = DateTime(logic.args.lastDate.year, logic.args.lastDate.month, logic.args.lastDate.day);

    // 当月1号
    DateTime month = DateTime(first.year, first.month + monthIndex, 1);
    // 月底
    DateTime monthEnd = DateTime(month.year, month.month + 1, 1).add(const Duration(days: -1));
    // 当月1号的星期 1是星期一，7是星期日
    int weekday = month.weekday;
    // 距离周一的天数
    int weekDiff = weekday - DateTime.monday;
    logic.start = month;
    logic.end = monthEnd;
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.1,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        DateTime dateTime = DateTime(month.year, month.month, month.day - weekDiff + index);
        bool isSameMonth = month.isSameMonth(dateTime);
        bool isEnable = isSameMonth && first.isBeforeOrEquals(dateTime) && last.isAfterOrEquals(dateTime);
        return buildDay(isEnable, dateTime);
      },
      itemCount: 5 * 7,
      clipBehavior: Clip.none,
    );
  }

  /// 构建周历
  Widget buildWeekCalendar() {
    return buildPage("week", buildWeek, (index) {
      // 开始日期
      DateTime first = logic.args.firstDate;
      int firstWeekday = first.weekday;
      // 当周周一
      DateTime monday = DateTime(first.year, first.month, first.day - (firstWeekday - DateTime.monday) + index * 7);
      DateTime sunday = DateTime(monday.year, monday.month, monday.day + 6);
      logic.start = monday;
      logic.end = sunday;
      logic.args.onPageChange?.call(monday, sunday);
    });
  }

  /// [weekIndex]从0开始
  Widget buildWeek(int weekIndex) {
    // 开日日期
    DateTime first = DateTime(logic.args.firstDate.year, logic.args.firstDate.month, logic.args.firstDate.day);
    int firstWeekday = first.weekday;
    // 当周周一
    DateTime monday = DateTime(first.year, first.month, first.day - (firstWeekday - DateTime.monday) + weekIndex * 7);
    DateTime sunday = DateTime(monday.year, monday.month, monday.day + 6);
    logic.start = monday;
    logic.end = sunday;
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        DateTime dateTime = DateTime(monday.year, monday.month, monday.day + index);
        return buildDay(true, dateTime);
      },
      itemCount: 1 * 7,
      clipBehavior: Clip.none,
    );
  }

  /// 构建每一天
  Widget buildDay(bool isEnable, DateTime dateTime) {
    int key = dateTime.millisecondsSinceEpoch;
    // 是否选中
    bool isSelected = logic.selected.contains(key);
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    DateTime now = DateTime.now();
    // 是否当日
    bool isToday = now.isSameDay(dateTime);
    // 农历
    Lunar lunar = Lunar.fromDate(dateTime);
    String lunarText;
    // 节日
    List<String> jieRi = lunar.getFestivals();
    // 节气
    String jieQi = lunar.getJieQi();
    // 农历日期
    String day = lunar.getDayInChinese();
    int dayInt = lunar.getDay();
    // 农历月首日显示为某月
    if (dayInt == 1) day = lunar.getMonthInChinese() + "月";
    // 节日显示节日名称 节气显示节气名称
    if (jieRi.isEmpty) {
      if (jieQi.isEmpty) {
        lunarText = day;
      } else {
        lunarText = jieQi;
      }
    } else {
      lunarText = jieRi.first;
    }
    // 日期文字颜色
    Color textColor = isEnable
        ? isToday
            ? Colors.redAccent
            : themeData.defaultTextColor
        : themeData.disabledColor;
    Widget button = HgNeumorphicButton(
      padding: EdgeInsets.zero,
      style: NeumorphicStyle(
        depth: isSelected ? -themeData.depth : themeData.depth,
        border: isSelected ? const NeumorphicBorder() : const NeumorphicBorder.none(),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dateTime.day.toString(), style: TextStyle(color: textColor, fontSize: 16)),
            Text(lunarText, style: TextStyle(color: textColor, fontSize: 8)),
          ],
        ),
      ),
      onPressed: isEnable ? () => logic.selectDate(dateTime) : null,
    );
    return Container(
      margin: const EdgeInsets.all(8),
      child: logic.args.wrapper?.call(dateTime: dateTime, child: button, isEnable: isEnable) ?? button,
    );
  }
}
