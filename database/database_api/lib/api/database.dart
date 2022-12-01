import 'dart:async';

import 'package:hgs_database_api/database_api.dart';

/// 数据库处理类
abstract class Database {
  /// 是否逻辑删除
  final bool isLogicDelete;

  /// 版本回调
  final Future<void> Function(int oldVersion, int newVersion)? onVersionChanged;

  Database({bool? isLogicDelete, this.onVersionChanged}) : isLogicDelete = isLogicDelete ?? true;

  /// 数据库完整路径
  String get fullPath;

  /// 数据库版本
  int get version;

  /// 上一个数据库版本
  int get oldVersion;

  /// 获取kv数据库
  KV get kv;

  /// db专属，打开数据库
  Future<void> open();

  /// 打开kv数据库
  Future<void> openKV();

  /// 关闭数据库
  Future<void> close();

  /// 刷新数据库
  Future<void> refresh();

  /// 新建一个事务
  Future<void> transaction(Future<void> Function(Transaction tx) action);

  /// 有事务使用当前事务，没有事务新建一个事务
  Future<void> withTransaction(Transaction? tx, Future<void> Function(Transaction tx) action);

  /// 导出数据
  Future<Map> export();

  /// 导入数据
  Future<void> import(Map data);

  /// 版本变更调用
  Future<void> onDatabaseVersionChanged(int oldVersion, int newVersion) async {
    await onVersionChanged?.call(oldVersion, newVersion);
  }
}
