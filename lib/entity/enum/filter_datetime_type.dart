import 'package:flutter/cupertino.dart';

@immutable
class FilterDateTimeTypeReturn {
  final DateTime start;
  final DateTime? end;

  const FilterDateTimeTypeReturn(this.start, this.end);
}

/// 过滤器可选的时间类型
class FilterDateTimeTypeEnum {
  /// 名称
  final String name;

  /// 值
  final int value;

  /// 转换为时间
  final FilterDateTimeTypeReturn Function(DateTime? date, DateTime? time, DateTime? now) toDateTime;

  const FilterDateTimeTypeEnum._(this.name, this.value, this.toDateTime);

  /// 作为map存储
  int toMap() {
    return value;
  }

  /// 从数据库转换
  static FilterDateTimeTypeEnum? fromMap(int? value) {
    return map[value];
  }

  /// 自定义值
  static const _customValue = -1;

  /// 当日值
  static const _dayValue = 0;

  /// 明日值
  static const _nextDayValue = 1;

  /// 当周值
  static const _weekValue = 2;

  /// 次周值
  static const _nextWeekValue = 3;

  /// 当月值
  static const _monthValue = 4;

  /// 次月值
  static const _nextMonthValue = 5;

  /// 当年值
  static const _yearValue = 6;

  /// 次年值
  static const _nextYearValue = 7;

  /// 此刻值
  static const _nowValue = 8;

  /// 此刻
  static final FilterDateTimeTypeEnum now = FilterDateTimeTypeEnum._("此刻", _nowValue, (date, time, now) {
    return FilterDateTimeTypeReturn(now ?? DateTime.now(), null);
  });

  /// 当日
  static final FilterDateTimeTypeEnum day = FilterDateTimeTypeEnum._("当日", _dayValue, (date, time, now) {
    DateTime thisTime = now ?? DateTime.now();

    if (null != time) {
      return FilterDateTimeTypeReturn(
        // 今天
        DateTime(thisTime.year, thisTime.month, thisTime.day, time.hour, time.minute), null,
      );
    }
    return FilterDateTimeTypeReturn(
      // 今天
      DateTime(thisTime.year, thisTime.month, thisTime.day),
      // 明天
      DateTime(thisTime.year, thisTime.month, thisTime.day + 1),
    );
  });

  /// 次日
  static final FilterDateTimeTypeEnum nextDay = FilterDateTimeTypeEnum._("次日", _nextDayValue, (date, time, now) {
    DateTime thisTime = now ?? DateTime.now();
    if (null != time) {
      return FilterDateTimeTypeReturn(
        // 今天
        DateTime(thisTime.year, thisTime.month, thisTime.day, time.hour, time.minute), null,
      );
    }
    return FilterDateTimeTypeReturn(
      // 明天
      DateTime(thisTime.year, thisTime.month, thisTime.day + 1),
      // 后天
      DateTime(thisTime.year, thisTime.month, thisTime.day + 2),
    );
  });

  /// 当周
  static final FilterDateTimeTypeEnum week = FilterDateTimeTypeEnum._("当周", _weekValue, (date, time, now) {
    DateTime thisTime = now ?? DateTime.now();
    int weekDay = thisTime.weekday;
    int monday = DateTime.monday;
    int sunday = DateTime.sunday;
    return FilterDateTimeTypeReturn(
      // 周一
      DateTime(thisTime.year, thisTime.month, thisTime.day + (monday - weekDay)),
      // 下周一
      DateTime(thisTime.year, thisTime.month, thisTime.day + (sunday - weekDay) + 1),
    );
  });

  /// 次周
  static final FilterDateTimeTypeEnum nextWeek = FilterDateTimeTypeEnum._("次周", _nextWeekValue, (date, time, now) {
    DateTime thisTime = now ?? DateTime.now();
    int weekDay = thisTime.weekday;
    int monday = DateTime.monday;
    int sunday = DateTime.sunday;
    return FilterDateTimeTypeReturn(
      // 周一
      DateTime(thisTime.year, thisTime.month, thisTime.day + (monday - weekDay) + 7),
      // 下周一
      DateTime(thisTime.year, thisTime.month, thisTime.day + (sunday - weekDay) + 8),
    );
  });

  /// 当月
  static final FilterDateTimeTypeEnum month = FilterDateTimeTypeEnum._("当月", _monthValue, (date, time, now) {
    DateTime thisTime = now ?? DateTime.now();
    return FilterDateTimeTypeReturn(
      // 周一
      DateTime(thisTime.year, thisTime.month, 1),
      // 下周一
      DateTime(thisTime.year, thisTime.month + 1, 1),
    );
  });

  /// 次月
  static final FilterDateTimeTypeEnum nextMonth = FilterDateTimeTypeEnum._("次月", _nextMonthValue, (date, time, now) {
    DateTime thisTime = now ?? DateTime.now();
    return FilterDateTimeTypeReturn(
      // 周一
      DateTime(thisTime.year, thisTime.month + 1, 1),
      // 下周一
      DateTime(thisTime.year, thisTime.month + 2, 1),
    );
  });

  /// 当年
  static final FilterDateTimeTypeEnum year = FilterDateTimeTypeEnum._("当年", _yearValue, (date, time, now) {
    DateTime thisTime = now ?? DateTime.now();
    return FilterDateTimeTypeReturn(
      // 周一
      DateTime(thisTime.year, 1, 1),
      // 下周一
      DateTime(thisTime.year + 1, 1, 1),
    );
  });

  /// 次年
  static final FilterDateTimeTypeEnum nextYear = FilterDateTimeTypeEnum._("次年", _nextYearValue, (date, time, now) {
    DateTime thisTime = now ?? DateTime.now();
    return FilterDateTimeTypeReturn(
      // 周一
      DateTime(thisTime.year + 1, 1, 1),
      // 下周一
      DateTime(thisTime.year + 2, 1, 1),
    );
  });

  /// 自定义
  static final FilterDateTimeTypeEnum custom = FilterDateTimeTypeEnum._("自定义", _customValue, (date, time, now) {
    if (null == date) {
      throw Exception("自定义日期不可为空");
    }
    if (null == time) {
      return FilterDateTimeTypeReturn(
        DateTime(date.year, date.month, date.day),
        DateTime(date.year, date.month, date.day + 1),
      );
    } else {
      return FilterDateTimeTypeReturn(DateTime(date.year, date.month, date.day, time.hour, time.minute), null);
    }
  });

  static final Map<int, FilterDateTimeTypeEnum> map = {
    _nowValue: now,
    _dayValue: day,
    _nextDayValue: nextDay,
    _weekValue: week,
    _nextWeekValue: nextWeek,
    _monthValue: month,
    _nextMonthValue: nextMonth,
    _yearValue: year,
    _nextYearValue: nextYear,
    _customValue: custom,
  };

  static final List<FilterDateTimeTypeEnum> list = [
    now,
    day,
    nextDay,
    week,
    nextWeek,
    month,
    nextMonth,
    year,
    nextYear,
    custom,
  ];
}
