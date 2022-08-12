import 'package:date_format/date_format.dart';

class DateTimeUtil {
  DateTimeUtil._();

  /// 格式化
  static String format(DateTime? dateTime, {List<String>? formats, DateTime? base}) {
    if (null == dateTime) return "";
    if (null != formats) return formatDate(dateTime, formats);
    List<String> dateFormats;

    DateTime now = base ?? DateTime.now();
    if (now.isSameDay(dateTime)) {
      dateFormats = [HH, ":", nn];
    } else if (now.isSameMonth(dateTime)) {
      dateFormats = [dd, "日 ", HH, ":", nn];
    } else if (now.isSameYear(dateTime)) {
      dateFormats = [mm, "月", dd, "日 ", HH, ":", nn];
    } else {
      dateFormats = [yyyy, "年", mm, "月", dd, "日 ", HH, ":", nn];
    }

    return formatDate(dateTime, dateFormats);
  }

  /// 格式化日期，忽略时间
  static String dateFormat(DateTime? dateTime, {DateTime? base}) {
    if (null == dateTime) return "";
    DateTime now = base ?? DateTime.now();
    List<String> dateFormats;
    if (now.isSameMonth(dateTime)) {
      dateFormats = [dd, "日"];
    } else if (now.isSameYear(dateTime)) {
      dateFormats = [mm, "月", dd, "日"];
    } else {
      dateFormats = [yyyy, "年", mm, "月", dd, "日"];
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
  bool isSameYear(DateTime? other) {
    if (null == other) return false;
    return year == other.year;
  }

  /// 是否同月
  bool isSameMonth(DateTime? other) {
    if (null == other) return false;
    return isSameYear(other) && month == other.month;
  }

  /// 是否同日
  bool isSameDay(DateTime? other) {
    if (null == other) return false;
    return isSameMonth(other) && day == other.day;
  }

  /// 是否同时
  bool isSameHour(DateTime? other) {
    if (null == other) return false;
    return isSameDay(other) && hour == other.hour;
  }

  /// 是否同分
  bool isSameMinute(DateTime? other) {
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
}
