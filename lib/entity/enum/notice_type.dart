/// 条件操作符
class NoticeType {
  final String name;
  final int value;

  const NoticeType._(this.name, this.value);

  int toMap() {
    return value;
  }

  static NoticeType? fromMap(int value) {
    return map[value];
  }

  static const List<NoticeType> list = [
    before,
    fixed,
  ];

  static const _beforeValue = 0;
  static const _fixedValue = 1;

  static const Map<int, NoticeType> map = {
    _beforeValue: before,
    _fixedValue: fixed,
  };
  static const NoticeType before = NoticeType._("提前提醒", _beforeValue);
  static const NoticeType fixed = NoticeType._("指定时间提醒", _fixedValue);
}
