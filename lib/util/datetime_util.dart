import 'package:date_format/date_format.dart';

class DateTimeUtil {
  DateTimeUtil._();
  static String format(DateTime? dateTime, {List<String>? formats}) {
    if (null == dateTime) {
      return "";
    }
    if (null != formats) {
      return formatDate(dateTime, formats);
    }
    List<String> dateFormats = [mm, "月", dd, "日 ", HH, ":", nn];
    if (DateTime.now().year != dateTime.year) {
      dateFormats.insert(0, "年");
      dateFormats.insert(0, yyyy);
    }

    return formatDate(dateTime, dateFormats);
  }

  static String yearFormat(DateTime? dateTime) {
    if (null == dateTime) {
      return "";
    }
    if (DateTime.now().year != dateTime.year) {
      return format(dateTime, formats: [yyyy, "年"]);
    } else {
      return "";
    }
  }

  static String dateFormat(DateTime? dateTime, {List<String>? formats}) {
    if (null == dateTime) {
      return "";
    }
    if (null != formats) {
      return format(dateTime, formats: formats);
    }
    List<String> dateFormats = [mm, "月", dd, "日"];
    if (DateTime.now().year != dateTime.year) {
      dateFormats.insert(0, "年");
      dateFormats.insert(0, yyyy);
    }

    return format(dateTime, formats: dateFormats);
  }

  static String timeFormat(DateTime? dateTime, {List<String> formats = const [HH, ":", nn]}) {
    if (null == dateTime) {
      return "";
    }
    return format(dateTime, formats: formats);
  }

  /// [base] 是对比时间
  /// [isShowDay] 是是否显示日期
  static String period(DateTime? start, DateTime? end, {String joinStr = " ", bool isShowDay = true, DateTime? base}) {
    if (null == start && null == end) {
      return "";
    }
    List<String> formats = [yyyy, "年", mm, "月", dd, "日 ", HH, ":", nn];
    // start formats
    List<String> thisYearFormats = [mm, "月", dd, "日 ", HH, ":", nn];
    List<String> thisDayFormats = [HH, ":", nn];

    // end formats
    List<String> sameDayFormats = [HH, ":", nn];
    List<String> sameMonthFormats = [dd, "日 ", HH, ":", nn];
    List<String> sameYearFormats = [mm, "月", dd, "日 ", HH, ":", nn];

    DateTime now = base ?? DateTime.now();

    String formatWithNow(DateTime dateTime) {
      List<String> realFormats;
      if (dateTime.isSameYear(now)) {
        if (!isShowDay && dateTime.isSameDay(now)) {
          realFormats = thisDayFormats;
        } else {
          realFormats = thisYearFormats;
        }
      } else {
        realFormats = formats;
      }
      return format(dateTime, formats: realFormats);
    }

    List<String?> dateStringList = [];
    // format Start
    if (null != start) {
      dateStringList.add(formatWithNow(start));
    } else {
      dateStringList.add("");
    }
    // format end
    if (null != end) {
      if (null == start) {
        dateStringList.add(formatWithNow(end));
      } else {
        List<String> endFormats = [];
        if (start.isSameMinute(end)) {
          dateStringList.add(dateStringList[0]);
          return dateStringList.join(joinStr);
        }
        if (start.isSameDay(end)) {
          endFormats = sameDayFormats;
        } else if (start.isSameMonth(end)) {
          endFormats = sameMonthFormats;
        } else if (start.isSameYear(end)) {
          endFormats = sameYearFormats;
        } else {
          endFormats = formats;
        }
        dateStringList.add(format(end, formats: endFormats));
      }
    } else {
      dateStringList.add("");
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
