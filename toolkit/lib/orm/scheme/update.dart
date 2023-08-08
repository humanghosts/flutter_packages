part of '../orm.dart';

/// 更新方案
base class UpdateScheme extends _ConditionScheme<UpdateScheme> {
  List<UpdateField>? _fields;

  /// 添加更新字段
  UpdateScheme update(UpdateField field) => updates([field]);

  /// 添加多个更新字段
  UpdateScheme updates(List<UpdateField> fields) {
    _fields ??= [];
    _fields!.addAll(fields);
    return this;
  }

  @override
  String get sql => _getSql(false);

  @override
  String get preparedSql => _getSql(true);

  String _getSql(bool prepared) => StringBuffer().writeEndSpace(_getUpdateSql()).writeEndSpace(_getFromSql()).writeEndSpace(_getWhereSql(prepared)).toString();

  /// 构架字段语句
  String _getUpdateSql() {
    StringBuffer sb = StringBuffer();
    sb.writeEndSpace('update');
    sb.write(_fields?.sqlJoin(', '));
    return sb.toString();
  }
}

/// 更新字段
class UpdateField implements _Sqlable {
  final String field;
  final dynamic value;

  const UpdateField(this.field, this.value);

  @override
  String get sql => 'set $field  = $value';
}
