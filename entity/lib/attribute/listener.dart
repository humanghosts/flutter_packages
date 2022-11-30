import 'package:entity/entity.dart';

/// 属性监听器
class AttributeListener<T> {
  bool Function(T value)? beforeSetValue;
  void Function(T value)? afterSetValue;

  AttributeListener({this.beforeSetValue, this.afterSetValue});
}

typedef ListAttributeListenerBeforeChanged<T> = bool Function(int index, T value);
typedef ListAttributeListenerAfterChanged<T> = void Function(int index, T value);

/// 列表属性监听器
class ListAttributeListener<T> extends AttributeListener<List<T>> {
  /// 添加元素
  ListAttributeListenerBeforeChanged<T>? beforeAddValue;
  ListAttributeListenerAfterChanged<T>? afterAddValue;

  /// 删除元素
  ListAttributeListenerBeforeChanged<T>? beforeRemoveValue;
  ListAttributeListenerAfterChanged<T>? afterRemoveValue;

  /// 设置指定位置元素
  ListAttributeListenerBeforeChanged<T>? beforeSetIndexValue;
  ListAttributeListenerAfterChanged<T>? afterSetIndexValue;

  ListAttributeListener({
    bool Function(List<T> value)? beforeSetValue,
    void Function(List<T> value)? afterSetValue,
    this.beforeAddValue,
    this.afterAddValue,
    this.beforeRemoveValue,
    this.afterRemoveValue,
    this.beforeSetIndexValue,
    this.afterSetIndexValue,
  }) : super(beforeSetValue: beforeSetValue, afterSetValue: afterSetValue);
}

/// 属性集合监听器
class AttributesListener {
  void Function(Attribute attribute, Object? oldValue, Object? newValue)? onAttributeValueChange;
  void Function(Attribute attribute, int index, Object? value)? onListAttributeValueAdd;
  void Function(Attribute attribute, int index, Object? value)? onListAttributeValueSet;
  void Function(Attribute attribute, int index, Object? value)? onListAttributeValueRemove;

  AttributesListener({
    this.onAttributeValueChange,
    this.onListAttributeValueAdd,
    this.onListAttributeValueRemove,
    this.onListAttributeValueSet,
  });
}
