import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'export.dart';

/// 列表类型的属性
class ListAttribute<T> extends Attribute<List<T>> {
  ListAttribute({
    required super.parent,
    required super.name,
    super.title,
    super.comment,
    super.value,
    List<T>? dvalue,
    Map<String, ListAttributeListener<T>>? listenerMap,
    List<T> Function()? fromDValue,
  }) : super(
          dvalue: dvalue ?? [],
          listenerMap: listenerMap,
          fromDValue: fromDValue ?? () => (dvalue ?? []).map((e) => json.decode(json.encode(e)) as T).toList(),
        );

  /// 属性类型,List内的泛型
  @override
  Type get type => T;

  @override
  bool get isNull => value.isEmpty;

  @override
  List<T> get cvalue {
    if (isNull) return [];
    return value.map((e) => json.decode(json.encode(e)) as T).toList();
  }

  @override
  set valueTypeless(dynamic value) {
    this.value = (value as List).map((e) => e as T).toList();
  }

  // ---- 获取的方法 ----
  /// 获取值长度
  int get length => value.length;

  T operator [](int index) => value[index];

  /// 获取值 需要检查index是否小于length
  T get(int index) => value[index];

  /// 首个元素
  T get first => value.first;

  /// 左右一个元素
  T get last => value.last;

  /// 是否包含
  bool contains(Object? value) => this.value.contains(value);

  /// 获取位置
  int indexOf(T value, [int start = 0]) => this.value.indexOf(value, start);

  /// 获取符合条件的位置
  int indexWhere(bool Function(T element) test, [int start = 0]) => value.indexWhere(test, start);

  /// 反向获取符合条件的位置
  int lastIndexWhere(bool Function(T element) test, [int? start]) => value.lastIndexWhere(test, start);

  /// 反向获取位置
  int lastIndexOf(T element, [int? start]) => value.lastIndexOf(element, start);

  // ---- 添加的方法 ----

  void operator []=(int index, T value) => set(index, value);

  /// 添加一个值
  ListAttribute<T> add(T value) {
    insert(this.value.length, value);
    return this;
  }

  /// 添加一系列值
  ListAttribute<T> addAll(List<T> valueList) {
    for (T value in valueList) {
      add(value);
    }
    return this;
  }

  /// 在指定位置设置值
  ListAttribute<T> set(int index, T value) {
    if (null == value || index >= this.value.length || index < 0) {
      dev.log("设置值位置大于等于列表长度,设置失败", name: "entity");
      return this;
    }
    Map<String, AttributeListener<List<T>>> listenerMap = this.listenerMap;
    for (AttributeListener<List<T>> listener in listenerMap.values) {
      if (listener is! ListAttributeListener<T>) continue;
      Function(int index, T value)? before = listener.beforeSetIndexValue;
      if (null != before && !before(index, value)) {
        return this;
      }
    }
    this.value.insert(index, value);
    for (AttributeListener<List<T>> listener in listenerMap.values) {
      if (listener is! ListAttributeListener<T>) continue;
      listener.afterSetIndexValue?.call(index, value);
    }
    parent.listener?.onListAttributeValueSet?.call(this, index, value);
    refresh();
    return this;
  }

  /// 设置批量
  ListAttribute<T> setAll(int index, List<T> valueList) {
    if (index > value.length || index < 0) {
      dev.log("设置值位置大于列表长度,插入失败", name: "entity");
      return this;
    }
    for (int i = 0; i < valueList.length; i++) {
      T value = valueList[i];
      int nextIndex = i + index;
      if (nextIndex >= this.value.length) {
        add(value);
      } else {
        set(nextIndex, value);
      }
    }
    return this;
  }

  /// 在指定位置插入值
  ListAttribute<T> insert(int index, T value) {
    if (index > this.value.length || index < 0) {
      dev.log("插入值位置大于列表长度,插入失败", name: "entity");
      return this;
    }
    Map<String, AttributeListener<List<T>>> listenerMap = this.listenerMap;
    for (AttributeListener<List<T>> listener in listenerMap.values) {
      if (listener is! ListAttributeListener<T>) continue;
      Function(int index, T value)? before = listener.beforeAddValue;
      if (null != before && !before(index, value)) {
        return this;
      }
    }
    this.value.insert(index, value);
    for (AttributeListener<List<T>> listener in listenerMap.values) {
      if (listener is! ListAttributeListener<T>) continue;
      listener.afterAddValue?.call(index, value);
    }
    parent.listener?.onListAttributeValueAdd?.call(this, index, value);
    refresh();
    return this;
  }

  /// 插入全部
  ListAttribute<T> insertAll(int index, List<T> valueList) {
    if (index > value.length || index < 0) {
      dev.log("插入值位置大于列表长度,插入失败", name: "entity");
      return this;
    }
    for (int i = valueList.length - 1; i < 0; i--) {
      T value = valueList[i];
      insert(index, value);
    }
    return this;
  }

// ---- 删除的方法 ----

  /// 删除一个值
  ListAttribute<T> remove(T value) {
    if (this.value.isEmpty) {
      dev.log("列表为空,删除失败", name: "entity");
      return this;
    }
    int index = this.value.indexOf(value);
    Map<String, AttributeListener<List<T>>> listenerMap = this.listenerMap;
    // 只要有一个不允许设置值，返回
    for (AttributeListener<List<T>> listener in listenerMap.values) {
      if (listener is! ListAttributeListener<T>) continue;
      ListAttributeListenerBeforeChanged<T>? before = listener.beforeRemoveValue;
      if (null != before && !before(index, value)) {
        return this;
      }
    }
    // 移除值
    this.value.remove(value);
    for (AttributeListener<List<T>> listener in listenerMap.values) {
      if (listener is! ListAttributeListener<T>) continue;
      listener.afterRemoveValue?.call(index, value);
    }
    parent.listener?.onListAttributeValueRemove?.call(this, index, value);
    refresh();
    return this;
  }

  /// 删除指定位置的值
  ListAttribute removeAt(int index) {
    if (index >= this.value.length) {
      dev.log("删除位置大于等于列表长度,删除失败", name: "entity");
      return this;
    }
    T value = this.value[index];
    remove(value);
    return this;
  }

  /// 删除最后一个元素
  T removeLast() {
    int index = this.value.length - 1;
    T value = this.value[index];
    remove(value);
    return value;
  }

  /// 删除符合条件的元素 返回符合条件的元素
  List<T> removeWhere(bool Function(T element) test) {
    List<T> matchesList = [];
    for (T value in this.value) {
      bool match = test(value);
      if (match) matchesList.add(value);
    }
    if (matchesList.isNotEmpty) removeAll(matchesList);
    return matchesList;
  }

  /// 删除不符合条件的元素 返回不符合条件的元素
  List<T> retainWhere(bool Function(T element) test) {
    List<T> notMatchesList = [];
    for (T value in this.value) {
      bool match = test(value);
      if (!match) notMatchesList.add(value);
    }
    if (notMatchesList.isNotEmpty) removeAll(notMatchesList);
    return notMatchesList;
  }

  /// 删除所有值
  ListAttribute removeAll(List<T> valueList) {
    for (T value in valueList) {
      remove(value);
    }
    return this;
  }

  @override
  ListAttribute<T> clear() {
    List<T> allValue = [...value];
    removeAll(allValue);
    return this;
  }

  // ---- 其他方法 ----

  /// 反转
  Iterable<T> get reversed => value.reversed;

  /// 排序
  void sort([int Function(T a, T b)? compare]) {
    value.sort(compare);
    refresh();
  }

  /// 随机打乱列表元素
  void shuffle([Random? random]) {
    value.shuffle(random);
    refresh();
  }

  @override
  String toString() {
    if (value.isEmpty) return "";
    return value.map((e) => e.toString()).join(",");
  }
}
