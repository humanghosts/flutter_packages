import 'transaction.dart';

/// 键值对存储
abstract class KV {
  /// 新建一个事务
  Future<void> transaction(Future<void> Function(Transaction tx) action);

  /// 有事务使用当前事务，没有事务新建一个事务
  Future<void> withTransaction(Transaction? tx, Future<void> Function(Transaction tx) action);

  /// 初始化
  Future<void> init({Transaction? tx});

  /// 快存
  void put<T>(String key, T value);

  /// 快读
  T? get<T>(String key);

  /// 快删
  void remove<T>(String key);

  /// 存并持久化
  Future<void> putSave<T>(String key, T value, {Transaction? tx});

  /// 从持久化读
  Future<T?> getSave<T>(String key, {Transaction? tx});

  /// 从持久化删
  Future<void> removeSave<T>(String key, {Transaction? tx});

  /// 保存
  Future<void> save({Transaction? tx});
}
