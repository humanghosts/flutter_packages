part of '../orm.dart';

typedef OnWhere = void Function(ConditionGroup group);

/// 来源
class From with _Sqlable {
  final String from;
  final String? alias;

  From(this.from, [this.alias]);

  @override
  String get sql => '$from ${null != alias ? 'as $alias' : ''}';
}

/// 查询条件 sealed
sealed class Condition with _Sqlable, _PrepareSqlable {}

/// 条件组
sealed class ConditionGroup extends Condition {
  final List<Condition> _conditions;

  ConditionGroup([List<Condition>? conditions]) : _conditions = conditions ?? [];

  ConditionGroup append(Condition condition) {
    _conditions.add(condition);
    return this;
  }

  @override
  String get sql => _getSql(false);

  @override
  String get preparedSql => _getSql(true);

  /// 构造SQL
  /// [prepared]是否预编译
  String _getSql(bool prepared) {
    if (_conditions.isEmpty) return '';
    String op = switch (this) {
      ConditionGroupAnd() => 'and',
      ConditionGroupOr() => 'or',
    };
    int count = 0;
    StringBuffer sb = StringBuffer();
    for (Condition condition in _conditions) {
      if (count != 0) sb.write(' $op ');
      if (!prepared) {
        sb.write(condition.sql);
        continue;
      }
      sb.write(condition.preparedSql);
      _parameters.addAll(condition.parameters);
    }
    return sb.toString();
  }
}

/// 与
class ConditionGroupAnd extends ConditionGroup {
  ConditionGroupAnd([super.conditions]);
}

/// 或
class ConditionGroupOr extends ConditionGroup {
  ConditionGroupOr([super.conditions]);
}

/// 查询条件项
sealed class ConditionItem extends Condition {}

/// 一元操作符
sealed class ConditionItemUnary extends ConditionItem {
  final String field;

  ConditionItemUnary(this.field);
}

/// 二元操作符
sealed class ConditionItemBinary extends ConditionItem {
  final String field;
  final dynamic value;

  ConditionItemBinary(this.field, this.value);
}

/// 三元操作符
sealed class ConditionItemTernary extends ConditionItem {
  final String field;
  final dynamic value1;
  final dynamic value2;

  ConditionItemTernary(this.field, this.value1, this.value2);
}

/// 为空
class ConditionItemIsNull extends ConditionItemUnary {
  ConditionItemIsNull(super.field);

  @override
  String get sql => '$field is null';

  @override
  String get preparedSql => sql;
}

/// 非空
class ConditionItemNotNull extends ConditionItemUnary {
  ConditionItemNotNull(super.field);

  @override
  String get sql => '$field is not null';

  @override
  String get preparedSql => sql;
}

/// 相等
class ConditionItemEquals extends ConditionItemBinary {
  ConditionItemEquals(super.field, super.value);

  @override
  String get sql => '$field = $value';

  @override
  String get preparedSql {
    _parameters.add(value);
    return '$field = ?';
  }
}

/// 不等
class ConditionItemNotEquals extends ConditionItemBinary {
  ConditionItemNotEquals(super.field, super.value);

  @override
  String get sql => '$field != $value';

  @override
  String get preparedSql {
    _parameters.add(value);
    return '$field != ?';
  }
}

/// 区间
class ConditionItemBetween extends ConditionItemTernary {
  ConditionItemBetween(super.field, super.value1, super.value2);

  @override
  String get sql => '$field between $value1 and $value2';

  @override
  String get preparedSql {
    _parameters.add(value1);
    _parameters.add(value2);
    return '$field between ? and ?';
  }
}

/// 区间
class ConditionItemIn extends ConditionItemBinary {
  ConditionItemIn(String field, List<dynamic> value) : super(field, value);

  @override
  List<dynamic> get value => super.value;

  @override
  String get sql => '$field in (${value.join(",")})';

  @override
  String get preparedSql {
    _parameters.addAll(value);
    return '$field (${value.map((e) => "?").join(",")})';
  }
}
