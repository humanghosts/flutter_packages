import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'icloud.dart';

/// 云存储工具
class CloudHelper {
  CloudHelper._();

  /// 云服务
  static late Cloud cloud;

  /// 应用文件
  static late final Directory appDocumentDir;

  /// 最大的版本数量
  static late int maxVersionNumbers;

  /// 获取本地文件全路径
  static String getLocalPath(String fileName) => join(appDocumentDir.path, fileName);

  static Future<void> init(Clouds clouds, {int maxVersionNumbers = 10}) async {
    appDocumentDir = await getApplicationDocumentsDirectory();
    CloudHelper.maxVersionNumbers = maxVersionNumbers;
    await clouds.cloud.init();
    cloud = clouds.cloud;
  }
}

/// 云存储类型枚举
class Clouds {
  final Cloud cloud;

  const Clouds._(this.cloud);

  /// iCloud
  static Clouds iCloud(String containerId) => Clouds._(ICloud(containerId));
}

/// 云存储接口
abstract class Cloud {
  /// 初始化
  Future<void> init();

  /// 是否可用
  Future<bool> isAvailable() async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  /// 所有云端文件
  Future<List<CloudFile>> cloudFileList();

  /// 通过名称过滤云端文件
  Future<List<CloudFile>> findByFileName(String fileName);

  /// 最新的云文件的版本
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

  /// 下载文件
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

  /// 删除所有文件
  Future<void> deleteAll({
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  });

  /// 通过名称删除云端文件
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
}

/// 云文件
@immutable
class CloudFile {
  /// 文件名称
  late final String fileName;

  /// 时间戳
  late final DateTime dateTime;

  /// 多版本分隔符号
  static const String _pattern = "__";

  /// 构造初始化时间戳
  CloudFile(this.fileName) {
    dateTime = DateTime.now();
  }

  /// 从云文件初始化
  CloudFile.decode(String cloudFileName) {
    List<String> list = cloudFileName.split(_pattern);
    assert(list.length == 2);
    fileName = list[0];
    dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(list[1]));
  }

  /// 获取名称
  String encode() => "$fileName$_pattern${dateTime.millisecondsSinceEpoch}";

  /// 比较文件时间
  int compareTo(CloudFile other) {
    return dateTime.compareTo(other.dateTime);
  }
}
