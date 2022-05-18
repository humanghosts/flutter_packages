import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'cloud_file.dart';
import 'cloud_type.dart';

/// 云存储接口
abstract class Cloud {
  late final Directory appDocumentDir;

  /// 是否开启多版本
  late final bool isMultiVersion;

  /// 最大的版本数量
  late final int maxVersionNumbers;

  /// 获取本地文件全路径
  String getLocalPath(String fileName) => join(appDocumentDir.path, fileName);

  /// 初始化
  Future<void> start({bool isMultiVersion = true, int maxVersionNumbers = 10}) async {
    appDocumentDir = await getApplicationDocumentsDirectory();
    this.isMultiVersion = isMultiVersion;
    this.maxVersionNumbers = maxVersionNumbers;
    await init();
  }

  /// 初始化
  Future<void> init();

  /// 是否可用
  Future<bool> isAvailable();

  /// 所有云端文件
  Future<List<CloudFile>> cloudFileList();

  /// 通过名称过滤云端文件
  Future<List<CloudFile>> findByFileName(String fileName);

  /// 最新的云文件
  Future<CloudFile?> lastVersion(String fileName);

  /// 备份
  Future<void> upload(
    CloudFile file, {
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  });

  /// 下载最新
  Future<void> downloadLast(
    CloudFile file, {
    VoidCallback? onEmpty,
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  });

  Future<void> download(
    CloudFile file, {
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  });

  /// 删除云端文件
  Future<void> delete(
    CloudFile file, {
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  });

  Future<void> deleteAll({
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  });

  /// 删除云端文件
  Future<void> deleteByName(
    String fileName, {
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  });

  /// 删除过时文件
  Future<void> deleteOutOfDate(
    CloudFile file, {
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  });

  /// 监听文件
  Future<void> watchFile({VoidCallback? onDone, ValueChanged<List<CloudFile>>? onData, ValueChanged<Object>? onError, bool cancelOnError = true});

  /// 取消监听
  Future<void> cancelWatch();
}

/// 云存储工具
class CloudHelper {
  CloudHelper._();

  static Cloud? _cloud;

  static Cloud get cloud {
    if (null == _cloud) throw Exception("init first");
    return _cloud!;
  }

  static Future<void> init(CloudType cloudType) async {
    await cloudType.cloud.start();
    _cloud = cloudType.cloud;
  }
}
