import 'package:hgs_database_sembast/database_sembast.dart';
import 'package:hgs_database_api/database_api.dart' as api;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast.dart' as sembast;

/// 键值对存储
class SembastKV extends api.KV {
  /// 存储库名称
  static const String storeName = "key_value";

  /// map的id
  static const String _key = "main";

  /// 临时存储
  static final Map<String, Object?> _cache = {};

  /// 存储库
  late StoreRef<String, Map<String, Object?>> store;

  /// 获取数据库实例
  sembast.Database get dataBase => (DatabaseHelper().database as SembastDatabase).database;

  /// 构造
  SembastKV() {
    store = stringMapStoreFactory.store(storeName);
  }

  @override
  Future<void> transaction(Future<void> Function(api.Transaction tx) action) async {
    return await dataBase.transaction((tx) async {
      await action(api.Transaction(tx));
    });
  }

  @override
  Future<void> withTransaction(api.Transaction? tx, Future<void> Function(api.Transaction tx) action) async {
    if (null == tx) {
      await transaction(action);
    } else {
      await action(tx);
    }
  }

  @override
  Future<void> init({api.Transaction? tx}) async {
    await refreshCache(tx: tx);
  }

  /// 刷新临时存储
  Future<void> refreshCache({api.Transaction? tx}) async {
    // 把值从数据库读到缓存中
    _cache.clear();
    Map<String, Object?>? value = await _find(tx: tx);
    if (null == value) return;
    _cache.addAll(value);
  }

  /// 查询
  Future<Map<String, Object?>?> _find({api.Transaction? tx}) async {
    // 查询数据
    RecordSnapshot<String, Map<String, Object?>>? record = await store.findFirst(
      api.Transaction.getOr(tx, dataBase),
      finder: Finder(filter: sembast.Filter.byKey(_key)),
    );
    // 没有数据不处理
    if (record == null) return null;
    // 找错了 也不处理
    if (record.key != _key) return null;
    return record.value;
  }

  @override
  void put<T>(String key, T value) {
    _cache[key] = value;
  }

  @override
  Future<void> putSave<T>(String key, T value, {api.Transaction? tx}) async {
    _cache[key] = value;
    await save(tx: tx);
  }

  @override
  T? get<T>(String key) {
    return _cache[key] as T?;
  }

  @override
  Future<T?> getSave<T>(String key, {api.Transaction? tx}) async {
    Map<String, Object?>? value = await _find(tx: tx);
    if (null == value) return null;
    return value[key] as T?;
  }

  @override
  void remove<T>(String key) {
    _cache.remove(key);
  }

  @override
  Future<void> removeSave<T>(String key, {api.Transaction? tx}) async {
    _cache.remove(key);
    await save(tx: tx);
  }

  @override
  Future<void> save({api.Transaction? tx}) async {
    await store.record(_key).put(api.Transaction.getOr(tx, dataBase), _cache);
  }
}
