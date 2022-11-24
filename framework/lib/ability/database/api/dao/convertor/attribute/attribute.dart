import 'package:hg_framework/ability/database/database.dart';
import 'package:hg_framework/ability/entity/entity.dart';

/// 属性转换器
class AttributeConvertors {
  /// 模型转换器
  late final ModelConvertors modelConvertors;

  /// 属性转换器
  late final AttributeConvertor attr;
  late final NumberAttributeConvertor number;
  late final NumberListAttributeConvertor numberList;
  late final IntegerAttributeConvertor integer;
  late final IntegerListAttributeConvertor integerList;
  late final FloatAttributeConvertor float;
  late final FloatListAttributeConvertor floatList;
  late final StringAttributeConvertor string;
  late final StringListAttributeConvertor stringList;
  late final BooleanAttributeConvertor boolean;
  late final BooleanListAttributeConvertor booleanList;
  late final DateTimeAttributeConvertor datetime;
  late final DateTimeListAttributeConvertor datetimeList;
  late final CustomAttributeConvertor custom;
  late final CustomListAttributeConvertor customList;
  late final ModelAttributeConvertor model;
  late final ModelListAttributeConvertor modelList;
  late final DataModelAttributeConvertor dataModel;
  late final DataModelListAttributeConvertor dataModelList;
  late final DataTreeModelAttributeConvertor dataTreeModel;
  late final DataTreeModelListAttributeConvertor dataTreeModelList;
  late final SimpleModelAttributeConvertor simpleModel;
  late final SimpleModelListAttributeConvertor simpleModelList;

  AttributeConvertors._() {
    attr = AttributeConvertor(this);
    number = NumberAttributeConvertor(this);
    numberList = NumberListAttributeConvertor(this);
    integer = IntegerAttributeConvertor(this);
    integerList = IntegerListAttributeConvertor(this);
    float = FloatAttributeConvertor(this);
    floatList = FloatListAttributeConvertor(this);
    string = StringAttributeConvertor(this);
    stringList = StringListAttributeConvertor(this);
    boolean = BooleanAttributeConvertor(this);
    booleanList = BooleanListAttributeConvertor(this);
    datetime = DateTimeAttributeConvertor(this);
    datetimeList = DateTimeListAttributeConvertor(this);
    custom = CustomAttributeConvertor(this);
    customList = CustomListAttributeConvertor(this);
    model = ModelAttributeConvertor(this);
    modelList = ModelListAttributeConvertor(this);
    dataModel = DataModelAttributeConvertor(this);
    dataModelList = DataModelListAttributeConvertor(this);
    dataTreeModel = DataTreeModelAttributeConvertor(this);
    dataTreeModelList = DataTreeModelListAttributeConvertor(this);
    simpleModel = SimpleModelAttributeConvertor(this);
    simpleModelList = SimpleModelListAttributeConvertor(this);
  }

  /// 单例
  static AttributeConvertors? _instance;

  /// 获取实例
  static AttributeConvertors get instance {
    _instance ??= AttributeConvertors._();
    return _instance!;
  }

  /// 供其它类使用的方法
  Future<Object?> getValue(
    Attribute? attribute, {
    Transaction? tx,
    bool? isLogicDelete,
  }) async {
    // 属性为空
    if (attribute == null || attribute.isNull) return null;
    // 数值类型
    if (attribute is NumberAttribute) {
      // 整型类型
      if (attribute is IntegerAttribute) {
        return await integer.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      // 浮点类型
      if (attribute is FloatAttribute) {
        return await float.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      return await number.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 字符串类型
    if (attribute is StringAttribute) {
      return await string.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 布尔类型
    if (attribute is BooleanAttribute) {
      return await boolean.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 时间类型
    if (attribute is DateTimeAttribute) {
      return await datetime.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 自定义值类型
    if (attribute is CustomAttribute) {
      return await custom.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 模型类型
    if (attribute is ModelAttribute) {
      // 数据模型
      if (attribute is DataModelAttribute) {
        // 树形数据模型
        if (attribute is DataTreeModelAttribute) {
          return await dataTreeModel.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
        }
        return await dataModel.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      // 简单模型
      if (attribute is SimpleModelAttribute) {
        return await simpleModel.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      return await model.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 数值列表
    if (attribute is NumberListAttribute) {
      if (attribute is IntegerListAttribute) {
        return await integerList.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      if (attribute is FloatListAttribute) {
        return await floatList.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      return await numberList.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 字符串列表
    if (attribute is StringListAttribute) {
      return await stringList.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 布尔列表
    if (attribute is BooleanListAttribute) {
      return await booleanList.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 时间列表
    if (attribute is DateTimeListAttribute) {
      return await datetimeList.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 自定义值列表
    if (attribute is CustomListAttribute) {
      return await customList.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 模型列表
    if (attribute is ModelListAttribute) {
      if (attribute is DataModelListAttribute) {
        if (attribute is DataTreeModelListAttribute) {
          return await dataTreeModelList.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
        }
        return await dataModelList.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      if (attribute is SimpleModelListAttribute) {
        return await simpleModelList.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      return await modelList.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    return await attr.to(attribute, tx: tx, isLogicDelete: isLogicDelete);
  }

  /// 供其它类使用的方法
  Future<Attribute?> getAttribute(
    Object? value, {
    required Attribute? attribute,
    Transaction? tx,
    bool? isLogicDelete,
  }) async {
    if (null == attribute) return null;
    attribute.clear();
    if (null == value) return attribute;
    // 数值类型
    if (attribute is NumberAttribute) {
      // 整型类型
      if (attribute is IntegerAttribute) {
        return await integer.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      // 浮点类型
      if (attribute is FloatAttribute) {
        return await float.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      return await number.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 字符串类型
    if (attribute is StringAttribute) {
      return await string.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 布尔类型
    if (attribute is BooleanAttribute) {
      return await boolean.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 时间类型
    if (attribute is DateTimeAttribute) {
      return await datetime.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 自定义值类型
    if (attribute is CustomAttribute) {
      return await custom.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 模型类型
    if (attribute is ModelAttribute) {
      // 数据模型
      if (attribute is DataModelAttribute) {
        // 树形数据模型
        if (attribute is DataTreeModelAttribute) {
          return await dataTreeModel.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
        }
        return await dataModel.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      // 简单模型
      if (attribute is SimpleModelAttribute) {
        return await simpleModel.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      return await model.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 数值列表
    if (attribute is NumberListAttribute) {
      if (attribute is IntegerListAttribute) {
        return await integerList.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      if (attribute is FloatListAttribute) {
        return await floatList.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      return await numberList.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 字符串列表
    if (attribute is StringListAttribute) {
      return await stringList.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 布尔列表
    if (attribute is BooleanListAttribute) {
      return await booleanList.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 时间列表
    if (attribute is DateTimeListAttribute) {
      return await datetimeList.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 自定义值列表
    if (attribute is CustomListAttribute) {
      return await customList.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    // 模型列表
    if (attribute is ModelListAttribute) {
      if (attribute is DataModelListAttribute) {
        if (attribute is DataTreeModelListAttribute) {
          return await dataTreeModelList.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
        }
        return await dataModelList.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      if (attribute is SimpleModelListAttribute) {
        return await simpleModelList.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
      }
      return await modelList.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
    }
    return await attr.from(value, attribute: attribute, tx: tx, isLogicDelete: isLogicDelete);
  }
}

/// 属性转换器
class AttributeConvertor<F extends Attribute, T extends Object> extends Convertor<F, T> {
  AttributeConvertors parent;

  AttributeConvertor(this.parent);

  @override
  Future<T?> to(F? value, {Transaction? tx, bool? isLogicDelete}) async {
    if (null == value) return null;
    return value.value;
  }

  @override
  Future<F?> from(Object? value, {F? attribute, Transaction? tx, bool? isLogicDelete}) async {
    if (null == attribute) return attribute;
    attribute.value = value;
    return attribute;
  }
}
