part of 'entity.dart';

enum AttributeType {
  int,
  double,
  datetime,
  string,
  list,
  map,
  set,
  model,
  object,
}

/// 属性
class Attribute<T> {
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

  AttributeType get attributeType {
    var t = <T>[];
    if (t is List<int?>) return AttributeType.int;
    if (t is List<double?>) return AttributeType.double;
    if (t is List<String?>) return AttributeType.string;
    if (t is List<DateTime?>) return AttributeType.datetime;
    if (t is List<Model?>) return AttributeType.model;
    if (t is List<List?>) return AttributeType.list;
    if (t is List<Set?>) return AttributeType.set;
    if (t is List<Map?>) return AttributeType.double;
    return AttributeType.object;
  }
}

sealed class ListAttribute<T> extends Attribute<List<T>> {
  ListAttribute(
    super.attributes, {
    required super.name,
    required super.value,
  });
}

/// 属性集合
class Attributes {
  /// 名称:属性 映射
  final Map<String, Attribute> _map = {};

  /// 模型
  final Model model;

  /// 构造方法
  Attributes(this.model);

  /// 通过名称获取某个属性
  Attribute? get(String? name) => _map[name];

  /// 获取所有属性
  List<Attribute> get list => List.unmodifiable(_map.values);

  /// 以map形式获取所有属性
  Map<String, Attribute> get map => Map.unmodifiable(_map);

  /// 任意字段
  Attribute<T> add<T>(String name, T value) => Attribute<T>(this, name: name, value: value);
}
