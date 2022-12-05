import 'dart:convert';

import 'package:hgs_entity/entity.dart';

class Attribute<T> extends Rx<T> {
  /// 字段默认值
  final T? dvalue;

  /// 字段名称
  final String name;

  /// 字段标题
  late String title;

  /// 字段注释
  late String? comment;

  /// 监听器 {id:listener}
  late final Map<String, AttributeListener<T>> listenerMap;

  /// 所有属性集合
  final Attributes parent;

  /// 构造方法:
  /// [parent] 创造attribute的Attributes
  /// [name] 属性的名称，相当于map中的key
  /// [title] 属性的别名
  /// [comment] 对于属性的注释
  /// [value] 属性的初始值=
  /// [dvalue] 非空属性的默认值
  /// [listenerMap] 属性set和get时候通知的监听器
  Attribute({
    required this.parent,
    required this.name,
    String? title,
    this.comment,
    T? value,
    this.dvalue,
    Map<String, AttributeListener<T>>? listenerMap,
    T Function()? fromDValue,
  })  : title = title ?? name,
        listenerMap = listenerMap ?? {},
        super(() {
          bool isNullable = T.toString().endsWith("?");
          if (!isNullable) {
            assert(dvalue != null || value != null, "$name属性类型非空，必须有值或者默认值}");
            if (null == fromDValue) {
              return value ?? json.decode(json.encode(dvalue)) as T;
            } else {
              return value ?? fromDValue();
            }
          }
          return value as T;
        }());

  /// 获取字段值
  @override
  T get value => super.value;

  /// 获取字段值类型
  Type get type => T;

  /// 获取值是否为空
  bool get isNull => value == null;

  /// 获取值拷贝
  T get cvalue {
    if (isNull) {
      return null as T;
    }
    return json.decode(json.encode(value));
  }

  /// 设置字段值
  @override
  set value(T value) {
    // 监听列表
    Map<String, AttributeListener<T>> listenerMap = this.listenerMap;
    // 旧值
    T oldValue = this.value;
    // 监听器为空，直接修改值
    if (listenerMap.isEmpty) {
      super.value = value;
      parent.listener?.onAttributeValueChange?.call(this, oldValue, this.value);
      return;
    }
    // 遍历监听器，调用beforeSetValue
    for (AttributeListener<T> listener in listenerMap.values) {
      bool Function(T value)? beforeSetValue = listener.beforeSetValue;
      // 如果不可以修改，直接返回即可
      if (beforeSetValue != null && !beforeSetValue(value)) {
        return;
      }
    }
    // 设置值
    super.value = value;
    // 遍历监听器，调用afterSetValue
    for (AttributeListener<T> listener in listenerMap.values) {
      listener.afterSetValue?.call(value);
    }
    // 调用父监听器，监听值的修改
    parent.listener?.onAttributeValueChange?.call(this, oldValue, this.value);
  }

  /// 设置不限制类型的值，容易报错，慎用
  set valueTypeless(dynamic value) {
    this.value = value as T;
  }

  /// 清空值，如果是非空类型，设置值为默认值
  Attribute<T> clear() {
    // 旧值
    T oldValue = value;
    // 重新初始化值
    value = dvalue as T;
    // 调用父监听器，监听值的修改
    parent.listener?.onAttributeValueChange?.call(this, oldValue, value);
    return this;
  }

  /// 添加监听器
  Attribute<T> addAttributeListener(String key, AttributeListener<T> listener) {
    listenerMap[key] = listener;
    return this;
  }

  /// 移除指定监听器
  Attribute<T> removeListener(String key) {
    listenerMap.remove(key);
    return this;
  }

  /// 移除所有监听器
  Attribute<T> removeAllListener() {
    listenerMap.clear();
    return this;
  }

  @override
  String toString() {
    if (value == null) return "";
    return value.toString();
  }
}
