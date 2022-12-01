import 'package:hgs_entity/entity.dart';

typedef AttributeCloneHandler = void Function(Attribute attribute, Attribute newAttribute);

/// 模型
abstract class Model {
  /// 模型属性
  late final Attributes attributes;

  /// 更新标识
  final RxInt updateFlag = 0.obs;

  /// 模型状态
  States state = States.none;

  /// 修改过值的属性
  final Set<String> changedAttribute = {};

  Model() {
    AttributesListener listener = AttributesListener(
      onAttributeValueChange: onAttributeValueChange,
      onListAttributeValueAdd: onListAttributeValueAdd,
      onListAttributeValueRemove: onListAttributeValueRemove,
      onListAttributeValueSet: onListAttributeValueSet,
    );
    attributes = Attributes(listener: listener, model: this);
  }

  /// 监听模型属性更改并更改模型状态
  void onAttributeValueChange(Attribute attribute, Object? oldValue, Object? newValue) {
    changedAttribute.add(attribute.name);
    updateFlag.value++;
  }

  /// 监听模型属性更改并更改模型状态
  void onListAttributeValueAdd(Attribute attribute, int index, Object? value) {
    changedAttribute.add(attribute.name);
    updateFlag.value++;
  }

  /// 监听模型属性更改并更改模型状态
  void onListAttributeValueRemove(Attribute attribute, int index, Object? value) {
    changedAttribute.add(attribute.name);
    updateFlag.value++;
  }

  /// 监听模型属性更改并更改模型状态
  void onListAttributeValueSet(Attribute attribute, int index, Object? value) {
    changedAttribute.add(attribute.name);
    updateFlag.value++;
  }

  /// 清空模型
  Model clear();

  /// 合并模型
  Model merge(Model model);

  /// 复制模型
  /// [attributeHandler]是处理属性复制的方法
  /// [newModel]是复制的目标model，没有目标model的化会新建一个
  Model clone({Map<String, AttributeCloneHandler>? attributeHandler, Model? newModel}) {
    Model cloneModel = newModel ?? ConstructorCache.get(runtimeType);
    cloneModel.state = state;
    for (Attribute attr in attributes.attributeList) {
      String attrName = attr.name;
      Attribute newAttr = cloneModel.attributes.get(attrName)!;
      if (attributeHandler?.containsKey(attrName) ?? false) {
        AttributeCloneHandler handler = attributeHandler![attrName]!;
        handler(attr, newAttr);
        continue;
      }
      newAttr.value = attr.cvalue;
    }
    return cloneModel;
  }
}
