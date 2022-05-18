import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/util/datetime_util.dart';

import '../entities.dart';

/// 基础时间
abstract class Timing extends SimpleModel {
  late final Attribute<DateTime?> start;
  static const String startKey = "start";

  late final Attribute<DateTime?> end;
  static const String endKey = "end";

  late final SimpleModelListAttribute<Notice> startNotice;
  static const String startNoticerKey = "start_notice";

  late final SimpleModelListAttribute<Notice> endNotice;
  static const String entNoticeKey = "end_notice";

  Timing() {
    start = attributes.datetimeNullable(name: startKey, title: "开始时间");
    end = attributes.datetimeNullable(name: endKey, title: "结束时间");
    startNotice = attributes.simpleModelList(name: startNoticerKey, title: "开始提醒");
    endNotice = attributes.simpleModelList(name: entNoticeKey, title: "结束提醒");
  }

  /// 是否为空
  bool get isNull => start.isNull && end.isNull;

  /// 用于判断两个时间是否相同
  String get uniqueCode => "${start.value?.millisecondsSinceEpoch}_${end.value?.millisecondsSinceEpoch}";

  @override
  String toString() {
    if (isNull) return "未定义";
    return "开始于${DateTimeUtil.format(start.value)},结束于${DateTimeUtil.format(end.value)}";
  }
}

/// 可重复时间
class RepeatableTiming extends Timing {
  late final CustomAttribute<RepeatRule> repeatRule;
  static const String repeatRuleKey = "repeat_rule";

  RepeatableTiming() {
    repeatRule = attributes.custom<RepeatRule>(name: repeatRuleKey, title: "重复规则");
  }

  @override
  String get uniqueCode => "${super.uniqueCode}_${repeatRule.value.uniqueCode}";

  @override
  String toString() {
    if (isNull) return "未定义";
    return "开始于${DateTimeUtil.format(start.value)},结束于${DateTimeUtil.format(end.value)},${repeatRule.value.toString()}";
  }

  /// 输出带提醒的字符串
  String toStringWithNotice() {
    if (isNull) return "未定义";
    StringBuffer sb = StringBuffer();
    sb.writeln("开始于${DateTimeUtil.format(start.value)}");
    if (!startNotice.isNull) {
      sb.write("开始提醒: ");
      for (Notice startNotice in startNotice.value) {
        sb.write(startNotice.toString());
      }
      sb.writeln();
    }
    sb.writeln("结束于${DateTimeUtil.format(end.value)}");
    if (!endNotice.isNull) {
      sb.write("结束提醒: ");
      for (Notice endNotice in endNotice.value) {
        sb.write(endNotice.toString());
      }
      sb.writeln();
    }
    sb.writeln(repeatRule.value.toString());
    return sb.toString();
  }

  /// 复制一个派生时间
  SingleTiming asDeriveTiming() {
    SingleTiming derive = SingleTiming(origin: this);
    derive.start.value = start.cvalue;
    derive.end.value = end.cvalue;
    derive.startNotice.value = startNotice.cvalue;
    derive.endNotice.value = endNotice.cvalue;
    return derive;
  }

  /// 派生一个时间，按照顺序(从0开始)，如果为空，说明超出了重复规则的范围
  /// [order]为第order个派生
  SingleTiming? derive(int order) {
    /// 重复规则
    RepeatRule repeatRule = this.repeatRule.value;
    // 无重复规则，不生成
    if (repeatRule.isNull) return _deriveUnRepeat(order);
    // 重复单位
    RepeatUnit unit = repeatRule.unit;
    // 单位数字
    int unitNumber = repeatRule.unitNumber!;
    // 截止日期
    DateTime? deadline = repeatRule.deadline;
    // 截止次数
    int? deadtimes = repeatRule.deadtimes;
    // 根据截止日期派生时间
    if (null != deadline) return _deriveByDeadline(order, unitNumber, unit, deadline);
    // 根据截止次数派生时间
    if (null != deadtimes) return _deriveByDeadtimes(order, unitNumber, unit, deadtimes);
    return _derive(order, unitNumber, unit);
  }

  /// 按照结束时间决定是否派生
  /// order 从0开始
  /// numbers unit的数量
  SingleTiming? _deriveByDeadline(int order, int unitNumber, RepeatUnit unit, DateTime deadline) {
    // 下个派生
    SingleTiming next = _derive(order, unitNumber, unit);
    // 下个派生的开始时间与结束时间
    int thisStart = _getDateTimeValueNullable(next.start.value);
    int thisEnd = _getDateTimeValueNullable(next.end.value);
    if (thisStart == 0) thisStart = thisEnd;
    if (thisEnd == 0) thisEnd = thisStart;
    // 按照截止时间停止重复，按结束时间算，如果超过了结束时间，不派生
    if (thisEnd > deadline.millisecondsSinceEpoch) return null;
    return next;
  }

  /// 按照重复次数决定是否派生
  /// order顺序 从0开始
  /// numbers unit的数量
  SingleTiming? _deriveByDeadtimes(int order, int unitNumber, RepeatUnit unit, int deadtimes) {
    if (order >= deadtimes) return null;
    return _derive(order, unitNumber, unit);
  }

  /// 派生
  /// order顺序 从0开始
  /// numbers unit的数量
  SingleTiming _derive(int order, int numbers, RepeatUnit unit) {
    SingleTiming next = SingleTiming(origin: this);
    // 下一个时间
    if (!start.isNull) next.start.value = _next(start.value!, order, numbers, unit);
    if (!end.isNull) next.end.value = _next(end.value!, order, numbers, unit);
    // 下一个提醒
    next.startNotice.value = startNotice.value;
    next.endNotice.value = endNotice.value;
    return next;
  }

  SingleTiming? _deriveUnRepeat(int order) {
    if (order != 0) return null;
    SingleTiming next = SingleTiming(origin: this);
    next.start.value = start.value;
    next.end.value = end.value;
    // 下一个提醒
    next.startNotice.value = startNotice.value;
    next.endNotice.value = endNotice.value;
    return next;
  }

  /// 计算等差数列的下一个
  /// order顺序 从0开始
  /// numbers unit的数量
  DateTime _next(DateTime dateTime, int order, int numbers, RepeatUnit unit) {
    // 公差
    int d = numbers;
    // 序号
    int n = order + 1;
    // 第n项
    return unit.next(dateTime, (n - 1) * d);
  }
}

/// 又repeatableTiming派生出的具体时间，不可重复
class SingleTiming extends Timing {
  /// 这里使用int记录origin的uniqueCode,防止一模一样的timing重复生成事件
  late final Attribute<String?> origin;
  static const String originKey = "origin";

  SingleTiming({RepeatableTiming? origin}) {
    this.origin = attributes.stringNullable(name: originKey, value: origin?.uniqueCode, title: "源时间");
  }

  /// 是否是源时间
  bool isOrigin(RepeatableTiming origin) => this.origin.value == origin.uniqueCode;
}

/// timing可比较扩展
extension CompareableTiming on Timing {
  /// 是否包含指定时间，
  /// [isEqualInclude]决定相等的的时候是否算包，也就是是否是闭区间
  /// 都是空算相等
  bool isInclude(Timing timing, {bool isEqualInclude = true}) {
    // 比较开始时间
    DateTime? thisStart = this.start.value;
    DateTime? otherStart = timing.start.value;
    // 开始时间是否包含(小于[等于])
    bool isStartInclude = false;
    int start = _compare(thisStart, otherStart);
    if ((start < 0) || (start == 0 && isEqualInclude)) isStartInclude = true;
    // 如果开始时间不包含，说明不包含，返回
    if (!isStartInclude) return isStartInclude;
    // 比较结束时间
    DateTime? thisEnd = this.end.value;
    DateTime? otherEnd = timing.start.value;
    // 结束时间是否包含(大于[等于])
    bool isEndInclude = false;
    int end = _compare(thisEnd, otherEnd);
    if ((end > 0) || (end == 0 && isEqualInclude)) isEndInclude = true;
    // 返回结束时间是否包含即可
    return isEndInclude;
  }

  /// timing是否包含
  static bool isIncludeNullable(Timing? a, Timing? b) {
    if (a == null || b == null) return false;
    return a.isInclude(b);
  }

  // 比较时间大小
  int _compare(DateTime? a, DateTime? b) {
    // a和b都为null，相等
    if (a == null && b == null) return 0;
    // a为null b非null，a<b
    if (a == null && b != null) return -1;
    // a非null b为null a>b
    if (a != null && b == null) return 1;
    // ab都非null，比较int值
    return _getDateTimeValue(a!).compareTo(_getDateTimeValue(b!));
  }

  /// 获取精确到分的时间
  int _getDateTimeValue(DateTime dateTime) {
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.hour,
      dateTime.minute,
    ).millisecondsSinceEpoch;
  }

  /// 获取精确到分的时间
  int _getDateTimeValueNullable(DateTime? dateTime) {
    if (null == dateTime) return 0;
    return _getDateTimeValue(dateTime);
  }

  /// 根据结束时间排序，无关开始时间
  int compareByEnd(Timing timing) {
    int thisEnd = _getDateTimeValueNullable(end.value);
    int otherEnd = _getDateTimeValueNullable(timing.start.value);
    return thisEnd - otherEnd;
  }

  /// 根据开始时间排序，无关结束时间
  int compareByStart(Timing timing) {
    int thisStart = _getDateTimeValueNullable(start.value);
    int otherStart = _getDateTimeValueNullable(timing.start.value);
    return thisStart - otherStart;
  }

  /// 根据开始时间排序，无关结束时间
  static int compareByStartNullable(Timing? a, Timing? b) {
    if (a == null && b == null) return 0;
    if (a != null && b != null) return a.compareByStart(b);
    if (a != null) return 1;
    return -1;
  }

  /// 根据结束时间排序，无关开始时间
  static compareByEndNullable(Timing? a, Timing? b) {
    if (a == null && b == null) return 0;
    if (a != null && b != null) return a.compareByEnd(b);
    if (a != null) return 1;
    return -1;
  }

  /// 比较指定时间，用于排序
  /// 0相等 >0大于 <0小于
  int compare(Timing timing) {
    int thisStart = _getDateTimeValueNullable(start.value);
    int otherStart = _getDateTimeValueNullable(timing.start.value);
    int thisEnd = _getDateTimeValueNullable(end.value);
    int otherEnd = _getDateTimeValueNullable(timing.start.value);
    // 开始时间不存在，使用结束时间替代 结束时间不存在，使用开始事件替代
    if (thisStart == 0) thisStart = thisEnd;
    if (thisEnd == 0) thisEnd = thisStart;
    if (otherStart == 0) otherStart = otherEnd;
    if (otherEnd == 0) otherEnd = otherStart;
    // 先比较开始时间
    if (thisStart < otherStart) return -1;
    if (thisStart > otherStart) return 1;
    // 开始时间相同，比较结束时间
    if (thisEnd < otherEnd) return -1;
    if (thisEnd > otherEnd) return 1;
    // 都相同 相等
    return 0;
  }

  /// 比较
  static compareNullable(Timing? a, Timing? b) {
    if (a == null && b == null) return 0;
    if (a != null && b != null) return a.compare(b);
    if (a != null) return 1;
    return -1;
  }

  /// 判断时间是否相等(不考虑id是否相等)
  bool equals(Timing timing) {
    return uniqueCode == timing.uniqueCode;
  }
}

/// 构建组件的扩展
extension WidgetableTiming on Timing {
  /// 构建组件
  Widget toWidget({bool isShowDay = true, DateTime? base, Color? color}) {
    return buildTiming(isShowDay: isShowDay, base: base, color: color);
  }

  /// 构建时间
  Widget buildTiming({bool isShowDay = true, DateTime? base, Color? color}) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    color ??= themeData.iconTheme.color;
    Timing timing = this;
    if (timing.isNull) return const Text("");
    Attribute<DateTime?> startDateTime = timing.start;
    SimpleModelListAttribute<Notice> startNoticeList = timing.startNotice;
    Attribute<DateTime?> endDateTime = timing.end;
    SimpleModelListAttribute<Notice> endNoticeList = timing.endNotice;
    String periodStr = DateTimeUtil.period(startDateTime.value, endDateTime.value, joinStr: "~", isShowDay: isShowDay, base: base);
    List<String> strList = periodStr.split("~");
    String startStr = strList[0];
    String endStr = strList[1];
    if (startNoticeList.isNull && endNoticeList.isNull) {
      if (startStr == endStr) {
        return _buildText(startStr, color);
      } else {
        return _buildText(periodStr, color);
      }
    } else {
      List<Widget> children = [];
      children.add(Row(
        children: [_buildText(startStr, color), startNoticeList.isNull ? Container() : _buildIcon(Icons.notifications, color)],
      ));
      children.add(Row(
        children: [_buildText(endStr, color), endNoticeList.isNull ? Container() : _buildIcon(Icons.notifications, color)],
      ));
      if (children.length > 1) {
        children.insert(1, _buildText("~", color));
      }
      return Row(children: children);
    }
  }

  /// 构建文本
  Widget _buildText(String text, Color? color) {
    return Text(text, style: TextStyle(color: color));
  }

  /// 构建图标
  Widget _buildIcon(IconData icon, Color? color) {
    return Icon(icon, color: color, size: 16);
  }
}

/// 可重复时间的组件扩展
extension WidgetableRepeatableTiming on RepeatableTiming {
  Widget toWidget({bool isShowDay = true, DateTime? base, Color? color}) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    color ??= themeData.iconTheme.color;
    RepeatableTiming timing = this;
    Widget title = buildTiming(isShowDay: isShowDay, base: base, color: color);
    // 构建尾部标识
    List<Widget> children = [title];
    if (!timing.repeatRule.isNull) {
      children.add(Text(" " + timing.repeatRule.value.toString(), style: TextStyle(color: color)));
    }
    return Row(children: children);
  }
}
