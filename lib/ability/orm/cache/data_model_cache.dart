import 'package:flutter/cupertino.dart';
import 'package:hg_framework/ability/entity/entity.dart';

/// 数据模型的缓存节点，不可修改
/// 包括缓存类型和缓存值
@immutable
class DataModelCacheNode<T> {
  /// 数据模型缓存类型
  final DataModelCacheType cacheType;

  /// 缓存值
  final T model;

  const DataModelCacheNode(this.cacheType, this.model);
}

/// 数据模型缓存类型的枚举
enum DataModelCacheType {
  /// 完成状态
  done,

  /// 未完成状态
  undone,
}

/// 完成的数据填充的DataModel
class DataModelCache {
  DataModelCache._();

  /// 完成状态的缓存池
  static final Map<String, DataModel> _doneCache = {};

  /// 未完成状态的缓存池
  static final Map<String, DataModel> _undoneCache = {};

  /// 添加缓存
  static void put<T extends DataModel>(T model, [DataModelCacheType cacheType = DataModelCacheType.done]) {
    String id = model.id.value;
    switch (cacheType) {
      case DataModelCacheType.done:
        _doneCache[id] = model;
        break;
      case DataModelCacheType.undone:
        _undoneCache[id] = model;
        break;
    }
  }

  /// 获取缓存
  static DataModelCacheNode<T>? get<T extends DataModel>(String id) {
    if (_doneCache.containsKey(id)) {
      return DataModelCacheNode(DataModelCacheType.done, _doneCache[id] as T);
    }
    if (_undoneCache.containsKey(id)) {
      return DataModelCacheNode(DataModelCacheType.undone, _undoneCache[id] as T);
    }
    return null;
  }

  /// 清空缓存
  static void clear() {
    _doneCache.clear();
    _undoneCache.clear();
  }

  /// 移除缓存，会移除所有缓存池中的缓存
  static void remove(String id) {
    _doneCache.remove(id);
    _undoneCache.remove(id);
  }

  /// 缓存状态提升
  static void levelUp(String id) {
    // 从高到低升级
    _doneLevelUp(id);
    _undoneLevelUp(id);
  }

  /// 未完成状态提升
  static void _undoneLevelUp(String id) {
    if (!_undoneCache.containsKey(id)) {
      return;
    }
    DataModel model = _undoneCache[id]!;
    _undoneCache.remove(id);
    _doneCache[id] = model;
  }

  /// 完成状态提升
  static void _doneLevelUp(String id) {}
}
