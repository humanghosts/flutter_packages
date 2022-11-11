import 'dart:async';

import 'package:hg_framework/hg_framework.dart';

import '../entity/entity.dart';

/// 数据库助手
class DatabaseHelper with AppPlugin {
  DatabaseHelper._({required this.databaseConfig});

  factory DatabaseHelper({required DatabaseConfig databaseConfig}) => SingletonCache.putIfAbsent(DatabaseHelper._(databaseConfig: databaseConfig));

  /// 由于构造需要数据库配置，这里提供一个static的获取实例的方法
  /// 但不能在初始化之前调用
  static DatabaseHelper get instance => SingletonCache.getNonNull();

  /// 数据库
  Database? _database;

  /// 数据库配置
  DatabaseConfig databaseConfig;

  /// 对外获取数据库的方法
  Database get database {
    assert(_database != null, "先打开数据库");
    return _database!;
  }

  @override
  FutureOr<void> init(AppConfig config) async {
    _database = databaseConfig.database;
    // TODO 注册构造器
    // 注册orm下的构造器
    ormEntitiesMap.forEach((key, value) => ConstructorCache.put(key, value));
    await databaseConfig.database.open();
    await databaseConfig.database.openKV();
    // TODO 注册Dao
  }

  /// 刷新数据库
  Future<void> refresh() async {
    // 刷新数据库
    await database.refresh();
    // 清空缓存
    DataModelCache.clear();
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
