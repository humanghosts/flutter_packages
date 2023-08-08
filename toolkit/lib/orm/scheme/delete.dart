part of '../orm.dart';

/// 删除方案
base class DeleteScheme extends _ConditionScheme<DeleteScheme> {
  @override
  String get sql => _getSql(false);

  @override
  String get preparedSql => _getSql(true);

  String _getSql(bool prepared) => StringBuffer().writeEndSpace('delete').writeEndSpace(_getFromSql()).writeEndSpace(_getWhereSql(prepared)).toString();
}
