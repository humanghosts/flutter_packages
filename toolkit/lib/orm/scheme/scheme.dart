part of '../orm.dart';

/// 支持SQL的接口
mixin class _Sqlable {
  String get sql => throw UnimplementedError();
}

/// 支持预编译SQL的接口
mixin class _PrepareSqlable {
  /// 参数
  final List<dynamic> _parameters = [];

  List<dynamic> get parameters => List.unmodifiable(_parameters);

  String get preparedSql => throw UnimplementedError();
}

/// 方案
sealed class _Scheme with _Sqlable {}

/// 带条件的方案
abstract base class _ConditionScheme<T extends _Scheme> extends _Scheme with _PrepareSqlable {
  /// 查询来源
  List<From>? _froms;

  /// 查询条件
  ConditionGroup? _conditions;

  /// 添加查询来源
  T from(From from) => froms([from]);

  /// 添加多个查询来源
  T froms(List<From> froms) {
    _froms ??= [];
    _froms!.addAll(froms);
    return this as T;
  }

  /// 添加与查询条件
  T where(OnWhere onWhere) => whereAnd(onWhere);

  /// 添加与查询条件
  T whereAnd(OnWhere onWhere) {
    _conditions ??= ConditionGroupAnd();
    onWhere(_conditions!);
    return this as T;
  }

  /// 添加或查询条件
  T whereOr(OnWhere onWhere) {
    _conditions ??= ConditionGroupOr();
    onWhere(_conditions!);
    return this as T;
  }

  /// 构建来源SQL
  String _getFromSql() => StringBuffer().writeEndSpace('from').writeNonNull(_froms?.sqlJoin(", ")).toString();

  /// 构建条件SQL
  String _getWhereSql(bool prepared) {
    if (null == _conditions) return '';
    StringBuffer sb = StringBuffer();
    sb.writeEndSpace('where');
    sb.writeNonNull(prepared ? _conditions?.preparedSql : _conditions?.sql);
    if (prepared) _parameters.addAll(_conditions!.parameters);
    return sb.toString();
  }
}

/// 不带条件的方案
abstract base class _ConditionlessScheme<T extends _Scheme> extends _Scheme {}
