import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/utils/sembast_import_export.dart';
import 'package:sembast_web/sembast_web.dart';

import '../../api/api.dart' as api;
import '../dao/kv.dart';

class SembastDatabase extends api.Database {
  /// 数据库
  Database? _database;

  /// kv数据库
  SembastKV? _kv;

  /// 数据库路径
  final String path;

  /// 完整路径
  late String _fullPath;

  /// 数据库版本
  final int _version;

  /// 上一个数据库版本
  int? _oldVersion;

  /// 版本修改回调
  final OnVersionChangedFunction? onVersionChanged;

  SembastDatabase({
    required this.path,
    bool? isLogicDelete,
    int version = 1,
    this.onVersionChanged,
  })  : _version = version,
        super(isLogicDelete: isLogicDelete);

  @override
  String get fullPath => _fullPath;

  @override
  int get version => database.version;

  @override
  int get oldVersion => _oldVersion ?? version;

  /// 获取Sembast数据库
  Database get database {
    assert(_database != null, "先打开数据库");
    return _database!;
  }

  /// 初始化数据库
  @override
  Future<void> open({api.OnDatabaseVersionChanged? onVersionChanged}) async {
    if (kIsWeb) {
      _database = await databaseFactoryWeb.openDatabase(
        path,
        version: _version,
        onVersionChanged: (Database db, int oldVersion, int newVersion) async {
          _oldVersion = oldVersion;
          if (null == onVersionChanged) return;
          if (onVersionChanged is Future) return await onVersionChanged(oldVersion, newVersion);
          return onVersionChanged(oldVersion, newVersion);
        },
      );
      log("sembast_web数据库打开成功,数据库位置$path");
      return;
    }
    // 获取app的路径 path_provider包下
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // 获取全量数据库路径
    final fullPath = join(appDocumentDir.path, path);
    _fullPath = fullPath;
    // 通过绝对路径打开数据库
    _database = await databaseFactoryIo.openDatabase(
      fullPath,
      version: _version,
      onVersionChanged: (Database db, int oldVersion, int newVersion) async {
        _oldVersion = oldVersion;
        if (null == onVersionChanged) return;
        if (onVersionChanged is Future) return await onVersionChanged(oldVersion, newVersion);
        return onVersionChanged(oldVersion, newVersion);
      },
    );
    log("sembast数据库打开成功,数据库位置$fullPath");
  }

  @override
  Future<void> openKV({api.OnDatabaseVersionChanged? onVersionChanged}) async {
    assert(_database != null, "先打开数据库");
    _kv = SembastKV();
    await _kv!.init();
  }

  @override
  api.KV get kv => _kv!;

  @override
  Future<void> close() async {
    // 关闭数据库就不需要非得数据库打开了
    await _database?.close();
  }

  @override
  Future<void> refresh() async {
    await close();
    await open();
  }

  @override
  Future<void> transaction(Future<void> Function(api.Transaction tx) action) async {
    return await database.transaction((tx) async {
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
  Future<Map> export() async {
    return await exportDatabase(database);
  }

  @override
  Future<void> import(Map data) async {
    if (kIsWeb) {
      _database = await importDatabase(data, databaseFactoryWeb, path);
    } else {
      _database = await importDatabase(data, databaseFactoryIo, fullPath);
    }
  }
}
