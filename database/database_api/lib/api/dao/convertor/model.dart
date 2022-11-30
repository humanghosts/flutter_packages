import 'package:database_api/database_api.dart';
import 'package:entity/entity.dart';

/// 模型转换器
class ModelConvertors {
  /// 属性转换器
  late final AttributeConvertors attributeConvertors;
  late final ModelConvertor mod;
  late final DataModelConvertor dataModel;
  late final DataTreeModelConvertor dataTreeModel;
  late final SimpleModelConvertor simpleModel;

  ModelConvertors._() {
    mod = ModelConvertor(this);
    dataModel = DataModelConvertor(this);
    dataTreeModel = DataTreeModelConvertor(this);
    simpleModel = SimpleModelConvertor(this);
  }

  static ModelConvertors? _instance;

  static ModelConvertors get instance {
    _instance ??= ModelConvertors._();
    return _instance!;
  }

  Future<Map<String, Object?>?> getValue(
    Model? value, {
    Transaction? tx,
    bool? isLogicDelete,
  }) async {
    if (null == value) return null;
    if (value is DataModel?) {
      if (value is DataTreeModel?) {
        return await dataTreeModel.to(value, tx: tx, isLogicDelete: isLogicDelete);
      }
      return await dataModel.to(value, tx: tx, isLogicDelete: isLogicDelete);
    }
    if (value is SimpleModel?) {
      return await simpleModel.to(value, tx: tx, isLogicDelete: isLogicDelete);
    }
    return await mod.to(value, tx: tx, isLogicDelete: isLogicDelete);
  }

  Future<Model?> getModelByType(
    Type? modelType,
    Object? value, {
    Transaction? tx,
    bool? isLogicDelete,
  }) async {
    if (null == modelType) return null;
    return await getModelByModel(
      ConstructorCache.get(modelType),
      value,
      tx: tx,
      isLogicDelete: isLogicDelete,
    );
  }

  Future<Model?> getModelByModel(
    Model? model,
    Object? value, {
    Transaction? tx,
    bool? isLogicDelete,
  }) async {
    if (null == model) return null;
    if (null == value) return null;
    if (value is! Map) return null;
    Map<String, Object?> mapValue = value as Map<String, Object?>;
    if (model is DataModel?) {
      if (model is DataTreeModel?) {
        return await dataTreeModel.from(
          mapValue,
          modelType: model.runtimeType,
          model: model as DataTreeModel,
          tx: tx,
          isLogicDelete: isLogicDelete,
        );
      }
      return await dataModel.from(
        mapValue,
        modelType: model.runtimeType,
        model: model as DataModel,
        tx: tx,
        isLogicDelete: isLogicDelete,
      );
    }
    if (model is SimpleModel?) {
      return await simpleModel.from(
        mapValue,
        modelType: model.runtimeType,
        model: model as SimpleModel,
        tx: tx,
        isLogicDelete: isLogicDelete,
      );
    }
    return await mod.from(
      mapValue,
      modelType: model.runtimeType,
      model: model,
      tx: tx,
      isLogicDelete: isLogicDelete,
    );
  }
}

class ModelConvertor<F extends Model> extends Convertor<F, Map<String, Object?>> {
  ModelConvertors parent;

  ModelConvertor(this.parent);

  @override
  Future<Map<String, Object?>?> to(Model? value, {Transaction? tx, bool? isLogicDelete}) async {
    if (null == value) return null;
    Map<String, Object> map = <String, Object>{};
    for (Attribute attribute in value.attributes.attributeList) {
      Object? value = await parent.attributeConvertors.getValue(
        attribute,
        tx: tx,
        isLogicDelete: isLogicDelete,
      );
      if (null == value) continue;
      map[attribute.name] = value;
    }
    return map;
  }

  @override
  Future<F?> from(
    Map<String, Object?>? value, {
    Type? modelType,
    F? model,
    Transaction? tx,
    bool? isLogicDelete,
  }) async {
    if (null == value) return null;
    if (null == modelType && null == model) return null;
    F realModel;
    if (null == model) {
      realModel = ConstructorCache.get(modelType!);
    } else {
      realModel = model;
    }
    for (Attribute attribute in realModel.attributes.attributeList) {
      String attributeName = attribute.name;
      Object? attributeValue = value[attributeName];
      await parent.attributeConvertors.getAttribute(
        attributeValue,
        attribute: attribute,
        tx: tx,
        isLogicDelete: isLogicDelete,
      );
    }
    return realModel;
  }
}

class DataModelConvertor<F extends DataModel> extends ModelConvertor<F> {
  DataModelConvertor(ModelConvertors parent) : super(parent);
}

class DataTreeModelConvertor extends DataModelConvertor<DataTreeModel> {
  DataTreeModelConvertor(ModelConvertors parent) : super(parent);
}

class SimpleModelConvertor extends ModelConvertor<SimpleModel> {
  SimpleModelConvertor(ModelConvertors parent) : super(parent);
}
