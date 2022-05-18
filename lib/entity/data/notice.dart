import 'dart:developer';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/component/export.dart';

import '../entities.dart';

/// 提醒实体
/// 如果提醒类型是before，则是根据时间计算提醒时间
/// 如果提醒类型是fixed，根据天数计算提醒日期，固定提醒时间
class Notice extends SimpleModel {
  late final Attribute<int> type;
  late final Attribute<int> days;
  late final Attribute<int> hours;
  late final Attribute<int> minutes;
  late final Attribute<DateTime?> fixedTime;

  Notice() {
    type = attributes.integer(name: "type", title: "提醒类型", dvalue: NoticeType.before.value);
    days = attributes.integer(name: "days", title: "提前天数", dvalue: 0);
    hours = attributes.integer(name: "hours", title: "提前小时数", dvalue: 0);
    minutes = attributes.integer(name: "minutes", title: "提前分钟数", dvalue: 0);
    fixedTime = attributes.datetimeNullable(name: "fixed_time", title: "固定提醒时间");
  }

  /// 判断两个提醒是否相同
  int get uniqueCode => "${type.value}${days.value}${hours.value}${minutes.value}${fixedTime.value}".hashCode;

  /// 获取最终提醒时间
  /// [base]为提前提醒的基础时间
  /// 返回为空说明不需要提醒
  DateTime? getNoticeTime(DateTime? base) {
    DateTime now = DateTime.now();
    // 固定时间提醒
    if (type.value == NoticeType.fixed.value) {
      // 没有值不提醒
      if (fixedTime.isNull) {
        log("固定提醒不存在，不提醒", name: "提醒实体");
        return null;
      }
      // 当前时刻之前，不提醒
      if (now.isAfter(fixedTime.value!)) {
        log("提醒时间${fixedTime.value}早于当前时间，已过期，不提醒", name: "提醒实体");
        return null;
      }
      return fixedTime.value;
    }
    // 提前量提醒
    else {
      // 没有基础量不提醒
      if (null == base) {
        log("提前提醒没有基础时间，不提醒", name: "提醒实体");
        return null;
      }
      DateTime noticeDateTime = DateTime(base.year, base.month, base.day - days.value, base.hour - hours.value, base.minute - minutes.value);
      // 当前时刻之前，不提醒
      if (now.isAfter(noticeDateTime)) {
        log("提醒时间$noticeDateTime早于当前时间，已过期，不提醒", name: "提醒实体");
        return null;
      }
      return noticeDateTime;
    }
  }

  bool get isNull => false;

  @override
  String toString() {
    if (isNull) return "未定义提醒";
    if (NoticeType.before.value == type.value) {
      if (days.value + hours.value + minutes.value == 0) return "准时提醒";
      String dayText = "";
      String hourText = "";
      String minuteText = "";
      if (days.value > 0) dayText = "${days.value}天";
      if ((days.value > 0 && minutes.value > 0) || hours.value > 0) hourText = "${hours.value}小时";
      if (minutes.value > 0) minuteText = "${minutes.value}分钟";
      return "提前$dayText$hourText$minuteText提醒";
    }
    return "${DateTimeUtil.format(fixedTime.value)}提醒";
  }

  Widget toWidget([bool useNeumorphic = true]) {
    return Row(
      children: [
        Text(toString(), style: const TextStyle(fontSize: 12)),
        useNeumorphic ? HgNeumorphicIcon(Icons.notifications, size: 12) : const Icon(Icons.notifications, size: 12),
      ],
    );
  }
}
