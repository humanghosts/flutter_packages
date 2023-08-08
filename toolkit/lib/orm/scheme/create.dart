part of '../orm.dart';

/// 创建方案
base class CreateScheme extends _ConditionlessScheme<CreateScheme> {
  /// 是否临时表
  bool _isTemporary = false;

  /// 是否存在判断
  bool _ifNotExists = true;

  /// 表名
  String? _table;

  /// 列
  final List<Column> _columns = [];

  CreateScheme(String table) : _table = table;

  /// 表名
  CreateScheme table(String table) {
    _table = table;
    return this;
  }

  /// 是否是临时表
  CreateScheme temporary(bool isTemporary) {
    _isTemporary = isTemporary;
    return this;
  }

  /// 是否存在性判断
  CreateScheme ifNotExists(bool ifNotExists) {
    _ifNotExists = ifNotExists;
    return this;
  }

  /// 添加列
  CreateScheme column(Column column) {
    _columns.add(column);
    return this;
  }

  /// 添加多列
  CreateScheme columns(List<Column> columns) {
    _columns.addAll(columns);
    return this;
  }

  @override
  String get sql => StringBuffer()
      .writeEndSpace('create')
      .writeEndSpace(_isTemporary ? 'temporary' : null)
      .writeEndSpace('table')
      .writeEndSpace(_ifNotExists ? 'if not exists' : null)
      .writeEndSpace(_table)
      .writeEndSpace('(')
      .writeEndSpace(_columns.sqlJoin(", "))
      .writeEndSpace(')')
      .toString();
}

/// 表格列
class Column implements _Sqlable {
  /// 是否是主键
  bool isPrimary;

  /// 是否是唯一
  bool isUnique;

  /// 是否可空
  bool isNullable;

  /// 默认值
  String? defaultValue;

  /// 是否自增
  bool isAutoIncrement;

  /// 注释
  String? comment;

  /// 列类型
  ColumnType type;

  /// 列名
  String name;

  Column({
    required this.name,
    required this.type,
    this.isPrimary = false,
    this.isUnique = false,
    this.isNullable = true,
    this.defaultValue,
    this.isAutoIncrement = false,
    this.comment,
  });

  Column.id({
    this.comment,
  })  : name = 'id',
        type = ColumnType.INTEGER,
        isPrimary = true,
        isNullable = false,
        isUnique = true,
        isAutoIncrement = true;

  @override
  String get sql => StringBuffer()
      .writeEndSpace(name)
      .writeEndSpace(type.name)
      .writeEndSpace(isNullable ? 'null' : 'not null')
      .writeEndSpace(isPrimary ? 'primary key' : null)
      .writeEndSpace(isUnique && !isPrimary ? 'unique' : null)
      .writeEndSpace(defaultValue != null ? 'default$defaultValue' : null)
      .toString();
}

enum ColumnType {
  // 大数据
  INTEGER,
  // 空类型
  NULL,
  // 浮点
  REAL,
  // 字符串
  TEXT,
  // 大数据
  BLOB,
}
