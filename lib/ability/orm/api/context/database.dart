import 'dart:async';

import 'package:hg_framework/ability/orm/orm.dart';

typedef OnDatabaseVersionChanged = FutureOr<dynamic> Function(int oldVersion, int newVersion);

/// 数据库处理类
abstract class Database {
  /// 是否逻辑删除
  late final bool isLogicDelete;

  Database({bool? isLogicDelete}) {
    this.isLogicDelete = isLogicDelete ?? true;
  }

  /// 数据库完整路径
  String get fullPath;

  /// 数据库版本
  int get version;

  /// 上一个数据库版本
  int get oldVersion;

  /// db专属，打开数据库
  Future<void> open();

  /// 打开kv数据库
  Future<void> openKV();

  /// 获取kv数据库
  KV get kv;

  /// 关闭数据库
  Future<void> close();

  /// 刷新数据库
  Future<void> refresh();

  /// 新建一个事务
  Future<void> transaction(Future<void> Function(Transaction tx) action);

  /// 有事务使用当前事务，没有事务新建一个事务
  Future<void> withTransaction(Transaction? tx, Future<void> Function(Transaction tx) action);

  /// 导出
  Future<Map> export();

  /// 导入
  Future<void> import(Map data);
}
