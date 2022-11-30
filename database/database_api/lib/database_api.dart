import 'dart:async';
import 'dart:developer';

import 'package:entity/entity.dart';
import 'package:hg_framework/hg_framework.dart';

import 'api/api.dart';
import 'cache/cache.dart';

export 'api/api.dart';
export 'cache/cache.dart';
export 'service.dart';

/// 数据库助手
class DatabaseHelper with AppInitPlugin, AppRebuildPlugin {
  DatabaseHelper._({Database? database, this.daoRegister}) : _database = database;

  factory DatabaseHelper({Database? database, DaoRegister? daoRegister}) =>
      SingletonCache.putIfAbsent(DatabaseHelper._(database: database, daoRegister: daoRegister));

  /// 数据库
  Database? _database;

  /// 数据库访问类提供方法
  final DaoRegister? daoRegister;

  /// 对外获取数据库的方法
  Database get database {
    assert(_database != null, "先打开数据库");
    return _database!;
  }

  @override
  FutureOr<bool> init(AppConfig config) async {
    if (_database == null) {
      log("数据库未提供，数据库助手未初始化");
      return false;
    }
    // 注册api下的构造器
    _ormEntitiesMap.forEach(ConstructorCache.put);
    // 打开数据库
    await database.open();
    // 打开KV数据库
    await database.openKV();
    // 注册Dao
    daoRegister?.daoMap.forEach(DaoCache.put);
    // 数据库版本变更回调
    int oldVersion = database.oldVersion;
    int newVersion = database.version;
    if (oldVersion != newVersion) await database.onDatabaseVersionChanged(oldVersion, newVersion);
    return true;
  }

  /// 刷新数据库
  @override
  Future<bool> rebuild(AppConfig config) async {
    // 刷新数据库
    await database.refresh();
    // 清空缓存
    DataModelCache.clear();
    // 数据库版本变更回调
    int oldVersion = database.oldVersion;
    int newVersion = database.version;
    if (oldVersion != newVersion) await database.onDatabaseVersionChanged(oldVersion, newVersion);
    return true;
  }

  /// 获取键值对数据库
  KV get kv => database.kv;

  /// 开启一个事务
  Future<void> transaction(Future<void> Function(Transaction tx) action) async {
    return await database.transaction((tx) async {
      await action(tx);
    });
  }

  /// 有事务使用事务，没有事务新开一个事务
  Future<void> withTransaction(Transaction? tx, Future<void> Function(Transaction tx) action) async {
    if (null == tx) {
      await transaction(action);
    } else {
      await action(tx);
    }
  }
}

/// Dao注册器
abstract class DaoRegister {
  Map<Type, Dao> get daoMap;
}

Map<Type, Object Function([Map<String, dynamic>? args])> get _ormEntitiesMap {
  return {
    SingleFilterValue: ([Map<String, dynamic>? args]) => SingleFilterValue(),
    GroupFilterValue: ([Map<String, dynamic>? args]) => GroupFilterValue(),
    SortValue: ([Map<String, dynamic>? args]) => SortValue(),
  };
}
