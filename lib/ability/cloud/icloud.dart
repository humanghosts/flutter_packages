import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:icloud_storage/icloud_storage.dart';

import 'cloud.dart';

/// iCloud存储管理类
class ICloud extends Cloud {
  /// 插件
  late final ICloudStorage iCloudStorage;

  /// 存储荣立
  final String containerId;

  /// 存储目录
  static const String directory = "Documents";

  /// 实例缓存
  static final Map<String, ICloud> factoryMap = {};

  /// 构造
  ICloud._(this.containerId);

  /// 工厂构造
  factory ICloud(String containerId) {
    return factoryMap.putIfAbsent(containerId, () => ICloud._(containerId));
  }

  @override
  Future<void> init() async {
    iCloudStorage = await ICloudStorage.getInstance(containerId);
  }

  @override
  Future<List<CloudFile>> cloudFileList() async {
    List<String> cloudNameList = await iCloudStorage.listFiles(directory: directory);
    if (cloudNameList.isEmpty) return [];
    return cloudNameList.map(CloudFile.decode).toList();
  }

  @override
  Future<List<CloudFile>> findByFileName(String fileName) async {
    List<CloudFile> all = await cloudFileList();
    if (all.isEmpty) return [];
    List<CloudFile> take = all.where((one) => one.fileName == fileName).toList();
    take.sort((a, b) => a.compareTo(b));
    return take;
  }

  @override
  Future<CloudFile?> lastVersion(String fileName) async {
    List<CloudFile> fileList = await findByFileName(fileName);
    if (fileList.isEmpty) return null;
    return fileList.last;
  }

  /// 备份文件
  @override
  Future<void> upload(
    CloudFile file, {
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  }) async {
    await iCloudStorage.startUpload(
      filePath: CloudHelper.getLocalPath(file.fileName),
      directory: directory,
      destinationFileName: file.encode(),
      onProgress: (stream) => stream.listen(
        onData,
        onDone: () async {
          await deleteOutOfDate(file);
          onDone?.call();
        },
        onError: onError,
        cancelOnError: cancelOnError,
      ),
    );
  }

  /// 下载文件
  @override
  Future<void> downloadLast(
    CloudFile file, {
    VoidCallback? onEmpty,
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  }) async {
    CloudFile? last = await lastVersion(file.fileName);
    if (null == last) {
      onEmpty?.call();
      return;
    }
    await iCloudStorage.startDownload(
      fileName: last.encode(),
      directory: directory,
      destinationFilePath: CloudHelper.getLocalPath(last.fileName),
      onProgress: (stream) => stream.listen(onData, onDone: onDone, onError: onError, cancelOnError: cancelOnError),
    );
  }

  /// 下载文件
  @override
  Future<void> download(
    CloudFile file, {
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  }) async {
    await iCloudStorage.startDownload(
      fileName: file.encode(),
      directory: directory,
      destinationFilePath: CloudHelper.getLocalPath(file.fileName),
      onProgress: (stream) => stream.listen(onData, onDone: onDone, onError: onError, cancelOnError: cancelOnError),
    );
  }

  /// 删除cloud文件
  @override
  Future<void> delete(
    CloudFile file, {
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  }) async {
    await deleteByName(
      file.encode(),
      onDone: onDone,
      onError: onError,
      onData: onData,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Future<void> deleteOutOfDate(
    CloudFile file, {
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  }) async {
    List<CloudFile> cloudFileList = await findByFileName(file.fileName);
    if (cloudFileList.isEmpty) return;
    int cloudLength = cloudFileList.length;
    if (cloudLength <= CloudHelper.maxVersionNumbers) return;
    // 删除前几个
    cloudFileList.sort((a, b) => a.compareTo(b));
    List<String> outOfDateNameList = [];
    for (int i = 0; i < cloudLength - CloudHelper.maxVersionNumbers; i++) {
      CloudFile cloudFile = cloudFileList[i];
      outOfDateNameList.add(cloudFile.encode());
    }
    await iCloudStorage.deleteList(
      fileNameList: outOfDateNameList,
      onProgress: (stream) => stream.listen(onData, onDone: onDone, onError: onError, cancelOnError: cancelOnError),
      directory: directory,
    );
  }

  @override
  Future<void> deleteByName(
    String fileName, {
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  }) async {
    await iCloudStorage.delete(
      fileName: fileName,
      directory: directory,
      onProgress: (stream) => stream.listen(onData, onDone: onDone, onError: onError, cancelOnError: cancelOnError),
    );
  }

  @override
  Future<void> deleteAll({
    VoidCallback? onDone,
    ValueChanged<Object>? onData,
    ValueChanged<Object>? onError,
    bool cancelOnError = true,
  }) async {
    List<String> cloudNameList = await iCloudStorage.listFiles();
    await iCloudStorage.deleteList(
      fileNameList: cloudNameList,
      directory: directory,
      onProgress: (stream) => stream.listen(onData, onDone: onDone, onError: onError, cancelOnError: cancelOnError),
    );
  }

  @override
  Future<bool> isAvailable() async {
    bool hasNetwork = await super.isAvailable();
    if (!hasNetwork) return false;
    return await iCloudStorage.isAvailable();
  }
}
