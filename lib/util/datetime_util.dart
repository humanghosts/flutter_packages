class DateTimeUtil {
  DateTimeUtil._();

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
