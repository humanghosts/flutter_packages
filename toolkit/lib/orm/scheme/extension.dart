part of '../orm.dart';

extension SqlStringBufferEx on StringBuffer {
  StringBuffer writeEndSpace(dynamic value) {
    if (null == value) return this;
    return writeNonNull(value).writeNonNull(" ");
  }

  StringBuffer writeNonNull(dynamic value) {
    if (null == value) return this;
    write(value);
    return this;
  }
}

extension _SqlListEx<E extends _Sqlable> on List<E> {
  /// copy from [join]
  String sqlJoin([String separator = " "]) {
    Iterator<E> iterator = this.iterator;
    if (!iterator.moveNext()) return "";
    var first = iterator.current.sql;
    if (!iterator.moveNext()) return first;
    var buffer = StringBuffer(first);
    if (separator.isEmpty) {
      do {
        buffer.write(iterator.current.sql);
      } while (iterator.moveNext());
    } else {
      do {
        buffer
          ..write(separator)
          ..write(iterator.current.sql);
      } while (iterator.moveNext());
    }
    return buffer.toString();
  }
}

extension CreateStringEx on String {
  CreateScheme get createScheme => CreateScheme(this);

  Column get column => Column(name: this, type: ColumnType.NULL);
}

extension QueryStringEx on String {
  UpdateField update(dynamic value) => UpdateField(this, value);

  QueryField get field => QueryField(this);

  From get from => From(this);

  QueryOrder get orderBy => desc;

  QueryOrder get asc => QueryOrderAsc(this);

  QueryOrder get desc => QueryOrderDesc(this);

  Condition isNull() => ConditionItemIsNull(this);

  Condition notNull() => ConditionItemNotNull(this);

  Condition equals(dynamic value) => ConditionItemEquals(this, value);

  Condition notEquals(dynamic value) => ConditionItemNotEquals(this, value);
}

extension CreateAttributeEx on Attribute {
  Column get column => name.column..type = columnType;

  ColumnType get columnType {
    return switch (this) {
      BooleanAttribute<bool?>() => ColumnType.INTEGER,
      DateTimeAttribute<DateTime?>() => ColumnType.INTEGER,
      StringAttribute<String?>() => ColumnType.TEXT,
      ModelAttribute<Model?>() => ColumnType.TEXT,
      BooleanListAttribute<bool>() => ColumnType.TEXT,
      DateTimeListAttribute<DateTime>() => ColumnType.TEXT,
      StringListAttribute<String>() => ColumnType.TEXT,
      ModelListAttribute<Model>() => ColumnType.TEXT,
      IntegerAttribute<int?>() => ColumnType.INTEGER,
      FloatAttribute<double?>() => ColumnType.REAL,
      IntegerListAttribute<int>() => ColumnType.TEXT,
      FloatListAttribute<double>() => ColumnType.TEXT,
    };
  }
}

extension QueryAttributeEx on Attribute {
  UpdateField update(dynamic value) => name.update(value);

  QueryField get field => name.field;

  QueryOrder get orderBy => desc;

  QueryOrder get asc => name.asc;

  QueryOrder get desc => name.desc;

  Condition isNull() => name.isNull();

  Condition notNull() => name.notNull();

  Condition equals(dynamic value) => name.equals(value);

  Condition notEquals(dynamic value) => name.notEquals(value);
}
