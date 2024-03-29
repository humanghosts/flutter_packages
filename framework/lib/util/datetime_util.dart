import 'package:dart_date/dart_date.dart';
import 'package:date_format/date_format.dart';

class DateTimeUtil {
  DateTimeUtil._();

  /// 格式化
  static String format(DateTime? dateTime, {List<String>? formats, DateTime? base}) {
    if (null == dateTime) return "";
    if (null != formats) return formatDate(dateTime, formats);
    DateTime now = base ?? DateTime.now();
    if (now.isSameDay(dateTime)) return timeFormat(dateTime);
    return "${dateFormat(dateTime, base: base)} ${timeFormat(dateTime)}";
  }

  /// 格式化日期，忽略时间
  static String dateFormat(DateTime? dateTime, {DateTime? base}) {
    if (null == dateTime) return "";
    DateTime now = base ?? DateTime.now();
    List<String> dateFormats;
    // 处理年和月
    if (now.isSameYear(dateTime)) {
      int monthDiff = dateTime.month - now.month;
      if (monthDiff == 1) {
        dateFormats = ["次月", dd, "日"];
      } else if (monthDiff == -1) {
        dateFormats = ["上月", dd, "日"];
      } else {
        dateFormats = [mm, "月", dd, "日"];
      }
      dateFormats = [mm, "月", dd, "日"];
    } else {
      int yearDiff = dateTime.year - now.year;
      if (yearDiff == 1) {
        dateFormats = ["明年", mm, "月", dd, "日"];
      } else if (yearDiff == -1) {
        dateFormats = ["去年", mm, "月", dd, "日"];
      } else {
        dateFormats = [yyyy, "年", mm, "月", dd, "日"];
      }
    }
    // 处理天
    if (dateTime.isSameDay(now)) return "今天";

    int dayDiff = dateTime.difference(now).inDays;
    if (dayDiff == 0) {
      // 用微秒比较精确，防止 59:59和00:00判断为同一天
      int hourDiff = dateTime.difference(now).inMicroseconds;
      if (hourDiff > 0) {
        return "明天";
      } else {
        return "昨天";
      }
    } else if (dayDiff == 1) {
      return "明天";
    } else if (dayDiff == 2) {
      return "后天";
    } else if (dayDiff == -1) {
      return "昨天";
    } else if (dayDiff == -2) {
      return "前天";
    } else if (dayDiff.abs() < 14) {
      int weekDiff = dateTime.getWeekYear - now.getWeekYear;
      if (weekDiff == 0) {
        return "本周${dateTime.weekdayTitle}";
      } else if (weekDiff == 1) {
        return "下周${dateTime.weekdayTitle}";
      } else if (weekDiff == -1) {
        return "上周${dateTime.weekdayTitle}";
      } else if (now.isSameMonth(dateTime)) {
        dateFormats = [dd, "日"];
      }
    } else if (now.isSameMonth(dateTime)) {
      dateFormats = [dd, "日"];
    }

    return format(dateTime, formats: dateFormats);
  }

  /// 格式化时间，忽略日期
  static String timeFormat(DateTime? dateTime, {List<String> formats = const [HH, ":", nn]}) {
    if (null == dateTime) return "";
    return format(dateTime, formats: formats);
  }

  /// [base] 是对比时间
  /// [isShowDay] 是是否显示日期
  static String period(DateTime? start, DateTime? end, {String joinStr = " ", DateTime? base}) {
    if (null == start && null == end) return "";

    DateTime now = base ?? DateTime.now();

    List<String> dateStringList = [];
    // format Start
    if (null != start) dateStringList.add(format(start, base: now));
    // format end
    if (null != end) {
      if (null == start) {
        dateStringList.add(format(end, base: now));
      } else {
        if (!start.isSameMinute(end)) dateStringList.add(format(end, base: start));
      }
    }

    return dateStringList.join(joinStr);
  }

  /// 比较时间大小 精确到豪秒
  static int compare(DateTime? a, DateTime? b) {
    // a和b都为null，相等
    if (a == null && b == null) return 0;
    // a为null b非null，a<b
    if (a == null && b != null) return -1;
    // a非null b为null a>b
    if (a != null && b == null) return 1;
    // ab都非null，比较int值
    return (a!.millisecondsSinceEpoch).compareTo(b!.millisecondsSinceEpoch);
  }
}

/// 时间比较拓展
extension DateTimeCompare on DateTime {
  /// 是否同年
  bool isSameYearNullable(DateTime? other) {
    if (null == other) return false;
    return year == other.year;
  }

  /// 是否同月
  bool isSameMonthNullable(DateTime? other) {
    if (null == other) return false;
    return isSameYear(other) && month == other.month;
  }

  /// 是否同周
  bool isSameWeekNullable(DateTime? other) {
    if (null == other) return false;
    int dayDiff = difference(other).inDays;
    if (dayDiff.abs() > 7) return false;
    int otherWeekDay = dayDiff + weekday;
    return otherWeekDay > 0 && otherWeekDay <= 7;
  }

  /// 是否同日
  bool isSameDayNullable(DateTime? other) {
    if (null == other) return false;
    return isSameMonth(other) && day == other.day;
  }

  /// 是否同时
  bool isSameHourNullable(DateTime? other) {
    if (null == other) return false;
    return isSameDay(other) && hour == other.hour;
  }

  /// 是否同分
  bool isSameMinuteNullable(DateTime? other) {
    if (null == other) return false;
    return isSameHour(other) && minute == other.minute;
  }

  /// 是否小于等于
  bool isBeforeOrEquals(DateTime? other) {
    if (null == other) return false;
    return isAtSameMomentAs(other) || isBefore(other);
  }

  /// 是否大于等于
  bool isAfterOrEquals(DateTime? other) {
    if (null == other) return false;
    return isAtSameMomentAs(other) || isAfter(other);
  }

  String get weekdayTitle {
    if (weekday == DateTime.monday) return "周一";
    if (weekday == DateTime.tuesday) return "周二";
    if (weekday == DateTime.wednesday) return "周三";
    if (weekday == DateTime.thursday) return "周四";
    if (weekday == DateTime.friday) return "周五";
    if (weekday == DateTime.saturday) return "周六";
    if (weekday == DateTime.sunday) return "周日";
    return "";
  }
}
