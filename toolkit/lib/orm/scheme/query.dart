part of '../orm.dart';

/// 查询方案
base class QueryScheme extends _ConditionScheme<QueryScheme> {
  /// 查询字段
  List<QueryField>? _fields;

  /// 查询排序
  List<QueryOrder>? _orderBys;

  /// 查询全部
  QueryScheme selectAll() => select('*'.field);

  /// 添加查询字段
  QueryScheme select(QueryField field) => selects([field]);

  /// 添加多个查询字段
  QueryScheme selects(List<QueryField> fields) {
    _fields ??= [];
    _fields!.addAll(fields);
    return this;
  }

  /// 添加排序
  QueryScheme orderBy(QueryOrder orderBy) => orderBys([orderBy]);

  /// 添加排序
  QueryScheme orderBys(List<QueryOrder> orderBys) {
    _orderBys ??= [];
    _orderBys!.addAll(orderBys);
    return this;
  }

  @override
  String get sql => _getSql(false);

  @override
  String get preparedSql => _getSql(true);

  String _getSql(bool prepared) => StringBuffer()
      .writeEndSpace(_getSelectSql())
      .writeEndSpace(_getFromSql())
      .writeEndSpace(_getWhereSql(prepared))
      .writeEndSpace(_getOrderBySql())
      .toString();

  /// 构架字段语句
  String _getSelectSql() => StringBuffer().writeEndSpace('select').writeNonNull(_fields?.sqlJoin(', ')).toString();

  /// 构建排序语句
  String _getOrderBySql() {
    if (null == _orderBys || _orderBys!.isEmpty) return '';
    return StringBuffer().writeEndSpace('order by').writeNonNull(_orderBys!.sqlJoin(', ')).toString();
  }
}

/// 查询字段
class QueryField implements _Sqlable {
  String field;
  String? alias;

  QueryField(this.field, [this.alias]);

  @override
  String get sql => '$field ${null != alias ? 'as $alias' : ''}';
}

/// 排序方式
sealed class QueryOrder implements _Sqlable {
  final String field;

  const QueryOrder(this.field);
}

class QueryOrderDesc extends QueryOrder {
  const QueryOrderDesc(super.field);

  @override
  String get sql => '$field desc';
}

class QueryOrderAsc extends QueryOrder {
  const QueryOrderAsc(super.field);

  @override
  String get sql => '$field asc';
}
