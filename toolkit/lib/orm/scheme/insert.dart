part of '../orm.dart';

/// 插入方案
base class InsertScheme extends _ConditionlessScheme<InsertScheme> with _PrepareSqlable {
  /// 插入的字段
  final List<String> _fields = [];

  /// 填充插入的查询方案
  QueryScheme? _queryScheme;

  /// 要插入的表
  String? _table;

  /// 要插入的值
  final List<dynamic> _values = [];

  /// 选择要插入的表
  InsertScheme into(String table) {
    _table = table;
    return this;
  }

  /// 选择要插入的列
  InsertScheme column(String column) {
    _fields.add(column);
    return this;
  }

  /// 选择要插入的列
  InsertScheme columns(List<String> columns) {
    _fields.addAll(columns);
    return this;
  }

  /// 选择数据来源
  InsertScheme from(QueryScheme scheme) {
    _queryScheme = scheme;
    return this;
  }

  /// 指定数据
  InsertScheme values(List<dynamic> values) {
    _values.addAll(values);
    return this;
  }

  @override
  String get sql => _getSql(false);

  @override
  String get preparedSql => _getSql(true);

  /// 获取SQL
  String _getSql(bool prepared) {
    StringBuffer sb = StringBuffer();
    sb.writeEndSpace('insert into').writeEndSpace(_table);
    if (_fields.isNotEmpty) sb.writeEndSpace('(').writeEndSpace(_fields.join(',')).writeEndSpace(')');
    if (_values.isNotEmpty) sb.writeEndSpace('values').writeEndSpace('(').writeEndSpace(_values.join(',')).writeEndSpace(')');
    if (null != _queryScheme) sb.writeEndSpace(prepared ? _queryScheme?.preparedSql : _queryScheme?.sql);
    return sb.toString();
  }
}
