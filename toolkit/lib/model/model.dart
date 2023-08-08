import 'package:ohohoo_toolkit/utils/utils.dart';

/// 模型
abstract class Model<E> {
  /// 主键
  late final Attribute<String?> id;

  /// 模型属性
  late final Attributes attributes;

  Model({String? id}) {
    instanceUtil.creator(runtimeType, create);
    attributes = Attributes(this);
    this.id = attributes.string(name: 'id', value: id);
  }

  /// 构建
  Model create();

  /// 设置值
  void set(String key, dynamic value) => attributes.get(key)?.value = value;

  /// 获取值
  T? get<T>(String key) => attributes.get(key)?.value as T?;

  /// 模型转换为实体
  E to();

  /// 实体转换为模型
  void from(E entity);
}

/// 属性
sealed class Attribute<T> {
  /// 属性的值
  T value;

  /// 属性名称
  String name;

  /// 值
  Attributes attributes;

  Attribute(
    this.attributes, {
    required this.value,
    required this.name,
  }) {
    attributes._map[name] = this;
  }

  Type get type => T;
}

/// 列表类型
sealed class ListAttribute<T> extends Attribute<List<T>> {
  ListAttribute(super.attributes, {required super.name, required super.value});
}

/// 布尔类型的值
class BooleanAttribute<T extends bool?> extends Attribute<T> {
  BooleanAttribute(super.attributes, {required super.value, required super.name});
}

class BooleanListAttribute<T extends bool> extends ListAttribute<T> {
  BooleanListAttribute(super.attributes, {required super.name, required super.value});
}

/// 时间类型
class DateTimeAttribute<T extends DateTime?> extends Attribute<T> {
  DateTimeAttribute(super.attributes, {required super.value, required super.name});
}

class DateTimeListAttribute<T extends DateTime> extends ListAttribute<T> {
  DateTimeListAttribute(super.attributes, {required super.name, required super.value});
}

/// 数字类型属性
sealed class NumberAttribute<T extends num?> extends Attribute<T> {
  NumberAttribute(super.attributes, {required super.value, required super.name});
}

sealed class NumberListAttribute<T extends num> extends ListAttribute<T> {
  NumberListAttribute(super.attributes, {required super.name, required super.value});
}

/// 整型
class IntegerAttribute<T extends int?> extends NumberAttribute<T> {
  IntegerAttribute(super.attributes, {required super.value, required super.name});
}

class IntegerListAttribute<T extends int> extends NumberListAttribute<T> {
  IntegerListAttribute(super.attributes, {required super.name, required super.value});
}

/// 浮点型
class FloatAttribute<T extends double?> extends NumberAttribute<T> {
  FloatAttribute(super.attributes, {required super.value, required super.name});
}

class FloatListAttribute<T extends double> extends NumberListAttribute<T> {
  FloatListAttribute(super.attributes, {required super.name, required super.value});
}

/// 字符串类型属性
class StringAttribute<T extends String?> extends Attribute<T> {
  StringAttribute(super.attributes, {required super.value, required super.name});
}

class StringListAttribute<T extends String> extends ListAttribute<T> {
  StringListAttribute(super.attributes, {required super.name, required super.value});
}

/// 模型
class ModelAttribute<T extends Model?> extends Attribute<T> {
  ModelAttribute(super.attributes, {required super.value, required super.name});
}

class ModelListAttribute<T extends Model> extends ListAttribute<T> {
  ModelListAttribute(super.attributes, {required super.name, required super.value});
}

/// 属性集合
class Attributes {
  /// 名称:属性 映射
  final Map<String, Attribute> _map = {};

  /// 模型
  final Model _model;

  /// 构造方法
  Attributes(Model model) : _model = model;

  /// 获取模型
  Model get parent => _model;

  /// 通过名称获取某个属性
  Attribute? get(String? name) => _map[name];

  /// 获取所有属性
  List<Attribute> get list => List.unmodifiable(_map.values);

  /// 以map形式获取所有属性
  Map<String, Attribute> get map => Map.unmodifiable(_map);

  /// 整型字段
  IntegerAttribute<T> integer<T extends int?>({required T value, required String name}) {
    IntegerAttribute<T> attribute = IntegerAttribute<T>(this, value: value, name: name);
    _map[name] = attribute;
    return attribute;
  }

  /// 整型列表
  IntegerListAttribute<T> integerList<T extends int>({required List<T> value, required String name}) {
    IntegerListAttribute<T> attribute = IntegerListAttribute<T>(this, value: value, name: name);
    _map[name] = attribute;
    return attribute;
  }

  /// 浮点型字段
  FloatAttribute<T> float<T extends double?>({required T value, required String name}) {
    FloatAttribute<T> attribute = FloatAttribute<T>(this, value: value, name: name);
    _map[name] = attribute;
    return attribute;
  }

  /// 浮点型列表
  FloatListAttribute<T> floatList<T extends double>({required List<T> value, required String name}) {
    FloatListAttribute<T> attribute = FloatListAttribute<T>(this, value: value, name: name);
    _map[name] = attribute;
    return attribute;
  }

  /// 字符串字段
  StringAttribute<T> string<T extends String?>({required T value, required String name}) {
    StringAttribute<T> attribute = StringAttribute<T>(this, value: value, name: name);
    _map[name] = attribute;
    return attribute;
  }

  /// 字符串列表
  StringListAttribute<T> stringList<T extends String>({required List<T> value, required String name}) {
    StringListAttribute<T> attribute = StringListAttribute<T>(this, value: value, name: name);
    _map[name] = attribute;
    return attribute;
  }

  /// 布尔字段
  BooleanAttribute<T> boolean<T extends bool?>({required T value, required String name}) {
    BooleanAttribute<T> attribute = BooleanAttribute<T>(this, value: value, name: name);
    _map[name] = attribute;
    return attribute;
  }

  /// 布尔列表
  BooleanListAttribute<T> booleanList<T extends bool>({required List<T> value, required String name}) {
    BooleanListAttribute<T> attribute = BooleanListAttribute<T>(this, value: value, name: name);
    _map[name] = attribute;
    return attribute;
  }

  /// 日期时间字段
  DateTimeAttribute<T> datetime<T extends DateTime?>({required T value, required String name}) {
    DateTimeAttribute<T> attribute = DateTimeAttribute<T>(this, value: value, name: name);
    _map[name] = attribute;
    return attribute;
  }

  /// 日期时间列表
  DateTimeListAttribute<T> datetimeList<T extends DateTime>({required List<T> value, required String name}) {
    DateTimeListAttribute<T> attribute = DateTimeListAttribute<T>(this, value: value, name: name);
    _map[name] = attribute;
    return attribute;
  }

  /// 模型字段
  ModelAttribute<T> model<T extends Model?>({required T value, required String name}) {
    ModelAttribute<T> attribute = ModelAttribute<T>(this, value: value, name: name);
    _map[name] = attribute;
    return attribute;
  }

  /// 日期时间列表
  ModelListAttribute<T> modelList<T extends Model>({required List<T> value, required String name}) {
    ModelListAttribute<T> attribute = ModelListAttribute<T>(this, value: value, name: name);
    _map[name] = attribute;
    return attribute;
  }
}
