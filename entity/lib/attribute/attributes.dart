import 'package:hgs_entity/entity.dart';

/// 属性集合
class Attributes {
  static final List<Type> typeList = [
    Attribute,
    ListAttribute,
    NumberAttribute,
    NumberListAttribute,
    IntegerAttribute,
    IntegerListAttribute,
    FloatAttribute,
    FloatListAttribute,
    BooleanAttribute,
    BooleanListAttribute,
    StringAttribute,
    StringListAttribute,
    DateTimeAttribute,
    DateTimeListAttribute,
    CustomAttribute,
    CustomListAttribute,
    ModelAttribute,
    ModelListAttribute,
    DataModelAttribute,
    DataModelListAttribute,
    DataTreeModelAttribute,
    DataTreeModelListAttribute,
    SimpleModelAttribute,
    SimpleModelListAttribute,
  ];

  /// 名称:属性 映射
  final Map<String, Attribute> _attributeMap = {};

  /// 监听器
  final AttributesListener? listener;

  /// 模型
  final Model model;

  /// 构造方法
  Attributes({this.listener, required this.model});

  /// 通过名称获取某个属性
  Attribute? get(String? name) => _attributeMap[name];

  /// 获取所有属性
  List<Attribute> get attributeList => _attributeMap.values.toList();

  /// 以map形式获取所有属性
  Map<String, Attribute> get attributeMap => _attributeMap;

  /// 任意字段
  Attribute<T> obj<T extends Object>({
    required String name,
    String? title,
    String? comment,
    T? value,
    required T dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    Attribute<T> attr = Attribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 任意字段(值可空)
  Attribute<T> objNullable<T extends Object?>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    Attribute<T> attr = Attribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 任意字段列表
  ListAttribute<T> objList<T extends Object>({
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) {
    ListAttribute<T> attr = ListAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 数值字段
  NumberAttribute<T> number<T extends num>({
    required String name,
    String? title,
    String? comment,
    T? value,
    required T dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    NumberAttribute<T> attr = NumberAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 数值字段(值可空)
  NumberAttribute<T> numberNullable<T extends num?>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    NumberAttribute<T> attr = NumberAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 数值列表
  NumberListAttribute<T> numberList<T extends num>({
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) {
    NumberListAttribute<T> attr = NumberListAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 整型字段
  IntegerAttribute<T> integer<T extends int>({
    required String name,
    String? title,
    String? comment,
    T? value,
    required T dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    IntegerAttribute<T> attr = IntegerAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 整型字段(值可空)
  IntegerAttribute<T> integerNullable<T extends int?>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    IntegerAttribute<T> attr = IntegerAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 整型列表
  IntegerListAttribute<T> integerList<T extends int>({
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) {
    IntegerListAttribute<T> attr = IntegerListAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 浮点型字段
  FloatAttribute<T> float<T extends double>({
    required String name,
    String? title,
    String? comment,
    T? value,
    required T dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    FloatAttribute<T> attr = FloatAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 浮点型字段(值可空)
  FloatAttribute<T> floatNullable<T extends double?>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    FloatAttribute<T> attr = FloatAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 浮点型列表
  FloatListAttribute<T> floatList<T extends double>({
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) {
    FloatListAttribute<T> attr = FloatListAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 字符串字段
  StringAttribute<T> string<T extends String>({
    required String name,
    String? title,
    String? comment,
    T? value,
    required T dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    StringAttribute<T> attr = StringAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 字符串字段(值可空)
  StringAttribute<T> stringNullable<T extends String?>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    StringAttribute<T> attr = StringAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 字符串列表
  StringListAttribute<T> stringList<T extends String>({
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) {
    StringListAttribute<T> attr = StringListAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 布尔字段
  BooleanAttribute<T> boolean<T extends bool>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    BooleanAttribute<T> attr = BooleanAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 布尔字段(值可空)
  BooleanAttribute<T> booleanNullable<T extends bool?>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    BooleanAttribute<T> attr = BooleanAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 布尔列表
  BooleanListAttribute<T> booleanList<T extends bool>({
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) {
    BooleanListAttribute<T> attr = BooleanListAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 日期时间字段，不给默认值，默认值是现在
  DateTimeAttribute<T> datetime<T extends DateTime>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    DateTimeAttribute<T> attr = DateTimeAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue ?? DateTime.now() as T,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 日期时间字段(值可空)
  DateTimeAttribute<T> datetimeNullable<T extends DateTime?>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    DateTimeAttribute<T> attr = DateTimeAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 日期时间列表
  DateTimeListAttribute<T> datetimeList<T extends DateTime>({
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) {
    DateTimeListAttribute<T> attr = DateTimeListAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 自定义
  CustomAttribute<T> custom<T extends CustomValue>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    CustomAttribute<T> attr = CustomAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue ?? ConstructorCache.get(T),
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 自定义(值可空)
  CustomAttribute<T> customNullable<T extends CustomValue?>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    CustomAttribute<T> attr = CustomAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 自定义数据列表
  CustomListAttribute<T> customList<T extends CustomValue>({
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) {
    CustomListAttribute<T> attr = CustomListAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 数据模型字段
  DataModelAttribute<T> dataModel<T extends DataModel>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    DataModelAttribute<T> attr = DataModelAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue ?? ConstructorCache.get(T),
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 数据模型字段(值可空)
  DataModelAttribute<T> dataModelNullable<T extends DataModel?>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    DataModelAttribute<T> attr = DataModelAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 数据模型列表
  DataModelListAttribute<T> dataModelList<T extends DataModel>({
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) {
    DataModelListAttribute<T> attr = DataModelListAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 树形数据模型
  DataTreeModelAttribute<T> dataTreeModel<T extends DataTreeModel>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    DataTreeModelAttribute<T> attr = DataTreeModelAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue ?? ConstructorCache.get(T),
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 树形数据模型(值可空)
  DataTreeModelAttribute<T> dataTreeModelNullable<T extends DataTreeModel?>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    DataTreeModelAttribute<T> attr = DataTreeModelAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 树形数据模型列表
  DataTreeModelListAttribute<T> dataTreeModelList<T extends DataTreeModel>({
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) {
    DataTreeModelListAttribute<T> attr = DataTreeModelListAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 简单模型
  SimpleModelAttribute<T> simpleModel<T extends SimpleModel>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    SimpleModelAttribute<T> attr = SimpleModelAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue ?? ConstructorCache.get(T),
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 简单模型(值可空)
  SimpleModelAttribute<T> simpleModelNullable<T extends SimpleModel?>({
    required String name,
    String? title,
    String? comment,
    T? value,
    T? dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
  }) {
    SimpleModelAttribute<T> attr = SimpleModelAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }

  /// 简单模型列表
  SimpleModelListAttribute<T> simpleModelList<T extends SimpleModel>({
    required String name,
    String? title,
    String? comment,
    List<T>? value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
  }) {
    SimpleModelListAttribute<T> attr = SimpleModelListAttribute<T>(
      parent: this,
      name: name,
      title: title,
      comment: comment,
      value: value,
      dvalue: dvalue,
      listenerMap: listenerMap,
    );
    _attributeMap[name] = attr;
    return attr;
  }
}
