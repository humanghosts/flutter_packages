/// 重复规则单位
class RepeatUnit {
  final String name;
  final int value;
  final DateTime Function(DateTime dateTime, int number) next;
  final int Function(DateTime dateTime) first;

  RepeatUnit._(this.name, this.value, this.next, this.first);

  int toMap() {
    return value;
  }

  static RepeatUnit? fromMap(int value) {
    return map[value];
  }

  static final List<RepeatUnit> list = [
    years,
    months,
    days,
    hours,
    minutes,
  ];

  static const _yearsValue = 0;
  static const _monthsValue = 1;
  static const _daysValue = 2;
  static const _hoursValue = 3;
  static const _minutesValue = 4;

  static final Map<int, RepeatUnit> map = {
    _yearsValue: years,
    _monthsValue: months,
    _daysValue: days,
    _hoursValue: hours,
    _minutesValue: minutes,
  };
  static final RepeatUnit years = RepeatUnit._(
    "年",
    _yearsValue,
    (dateTime, number) {
      return DateTime(dateTime.year + number, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute);
    },
    (dateTime) => dateTime.year,
  );

  static final RepeatUnit months = RepeatUnit._(
    "月",
    _monthsValue,
    (dateTime, number) {
      return DateTime(dateTime.year, dateTime.month + number, dateTime.day, dateTime.hour, dateTime.minute);
    },
    (dateTime) => dateTime.month,
  );

  static final RepeatUnit days = RepeatUnit._(
    "天",
    _daysValue,
    (dateTime, number) {
      return DateTime(dateTime.year, dateTime.month, dateTime.day + number, dateTime.hour, dateTime.minute);
    },
    (dateTime) => dateTime.day,
  );

  static final RepeatUnit hours = RepeatUnit._(
    "小时",
    _hoursValue,
    (dateTime, number) {
      return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour + number, dateTime.minute);
    },
    (dateTime) => dateTime.hour,
  );

  static final RepeatUnit minutes = RepeatUnit._(
    "分钟",
    _minutesValue,
    (dateTime, number) {
      return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute + number);
    },
    (dateTime) => dateTime.minute,
  );
}
