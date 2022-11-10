/// 排序条件
class Sort {
  /// 排序字段
  String field;

  /// 排序操作符
  SortOp op;

  Sort({required this.field, this.op = SortOp.asc});

  Sort clone() => Sort(field: field, op: op);

  @override
  String toString() {
    return "$field:${op.title}";
  }
}

/// 排序操作符
class SortOp {
  final String title;
  final String symbol;

  const SortOp._(this.title, this.symbol);

  static const _ascSymbol = "asc";
  static const _descSymbol = "desc";

  static const SortOp asc = SortOp._("升序", _ascSymbol);
  static const SortOp desc = SortOp._("降序", _descSymbol);

  static const List<SortOp> list = [asc, desc];

  static const Map<String, SortOp> map = {
    _ascSymbol: asc,
    _descSymbol: desc,
  };
}
