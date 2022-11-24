import 'package:hg_framework/ability/database/database.dart';
import 'package:hg_framework/ability/entity/entity.dart';

/// 模型类型
class ModelAttributeConvertor<F extends ModelAttribute> extends AttributeConvertor<F, Object> {
  ModelAttributeConvertor(AttributeConvertors parent) : super(parent);

  @override
  Future<Object?> to(F? value, {Transaction? tx, bool? isLogicDelete}) async {
    if (null == value) return null;
    Model? model = value.value;
    return await parent.modelConvertors.getValue(
      model,
      tx: tx,
      isLogicDelete: isLogicDelete,
    );
  }

  @override
  Future<F?> from(Object? value, {F? attribute, Transaction? tx, bool? isLogicDelete}) async {
    if (null == attribute) return attribute;
    Model? model = await parent.modelConvertors.getModelByType(
      attribute.type,
      value,
      tx: tx,
      isLogicDelete: isLogicDelete,
    );
    if (null == model) {
      attribute.clear();
    } else {
      attribute.value = model;
    }
    return attribute;
  }
}

/// 数据模型类型
class DataModelAttributeConvertor<F extends DataModelAttribute> extends ModelAttributeConvertor<F> {
  DataModelAttributeConvertor(AttributeConvertors parent) : super(parent);

  @override
  Future<Object?> to(F? value, {Transaction? tx, bool? isLogicDelete}) async {
    if (null == value) return null;
    DataModel? model = value.value;
    if (null == model) return null;
    // 逻辑删除状态下，如果isDelete为true，不保存
    if (model.isDelete.value && isLogicDelete == true) return null;
    // modelConvert需要将dataModel转换为map，所以要在这里处理dataModel在数据库的形式
    return getValue(model);
  }

  @override
  Future<F?> from(Object? value, {F? attribute, Transaction? tx, bool? isLogicDelete}) async {
    if (null == attribute) return attribute;
    // modelConvert需要将map转换为dataModel，所以要在这里处理dataModel在数据库的形式
    // 数据库查询
    DataDao<DataModel> dao = DaoCache.getByType(attribute.type) as DataDao<DataModel>;
    DataModel? model = await dao.findByID(value as String, tx: tx, isLogicDelete: isLogicDelete);
    if (null == model) {
      attribute.clear();
      return attribute;
    }
    attribute.value = model;
    return attribute;
  }

  String getValue(DataModel value) => value.id.value;
}

class DataTreeModelAttributeConvertor extends DataModelAttributeConvertor<DataTreeModelAttribute> {
  DataTreeModelAttributeConvertor(AttributeConvertors parent) : super(parent);
}

class SimpleModelAttributeConvertor extends ModelAttributeConvertor<SimpleModelAttribute> {
  SimpleModelAttributeConvertor(AttributeConvertors parent) : super(parent);
}

class ModelListAttributeConvertor<F extends ModelListAttribute> extends AttributeConvertor<F, List<Object>> {
  ModelListAttributeConvertor(AttributeConvertors parent) : super(parent);

  @override
  Future<List<Object>?> to(F? value, {Transaction? tx, bool? isLogicDelete}) async {
    if (null == value) return null;
    List<Model> modelList = value.value;
    List<Object> valueList = [];
    for (Model model in modelList) {
      Object? value = await parent.modelConvertors.getValue(
        model,
        tx: tx,
        isLogicDelete: isLogicDelete,
      );
      if (null == value) continue;
      valueList.add(value);
    }
    return valueList;
  }

  @override
  Future<F?> from(Object? value, {F? attribute, Transaction? tx, bool? isLogicDelete}) async {
    if (null == attribute) return attribute;
    attribute.clear();
    if (null == value) return attribute;
    if (value is! List) return attribute;
    for (Object? one in value) {
      Model? model = await parent.modelConvertors.getModelByType(
        attribute.type,
        one,
        tx: tx,
        isLogicDelete: isLogicDelete,
      );
      if (null == model) continue;
      attribute.add(model);
    }
    return attribute;
  }
}

class DataModelListAttributeConvertor<F extends DataModelListAttribute> extends ModelListAttributeConvertor<F> {
  DataModelListAttributeConvertor(AttributeConvertors parent) : super(parent);

  @override
  Future<List<Object>?> to(F? value, {Transaction? tx, bool? isLogicDelete}) async {
    if (null == value) return null;
    List<DataModel> modelList = value.value;
    List<String> idList = [];
    for (DataModel model in modelList) {
      if (model.isDelete.value && isLogicDelete == true) continue;
      String id = model.id.value;
      idList.add(id);
    }
    return idList;
  }

  @override
  Future<F?> from(Object? value, {F? attribute, Transaction? tx, bool? isLogicDelete}) async {
    if (null == attribute) return attribute;
    attribute.clear();
    if (value == null) return attribute;
    if (value is! List) return attribute;
    List<String> idList = value.map((e) => e.toString()).toList();
    DataDao<DataModel> dao = DaoCache.getByType(attribute.type) as DataDao<DataModel>;
    List<DataModel> modelList = await dao.findByIDList(idList, tx: tx, isLogicDelete: isLogicDelete);
    if (modelList.isEmpty) return attribute;
    attribute.value = modelList;
    return attribute;
  }
}

class DataTreeModelListAttributeConvertor extends DataModelListAttributeConvertor<DataTreeModelListAttribute> {
  DataTreeModelListAttributeConvertor(AttributeConvertors parent) : super(parent);
}

class SimpleModelListAttributeConvertor extends ModelListAttributeConvertor<SimpleModelListAttribute> {
  SimpleModelListAttributeConvertor(AttributeConvertors parent) : super(parent);
}
