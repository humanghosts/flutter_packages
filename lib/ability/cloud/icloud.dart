import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icloud_storage/icloud_storage.dart';

import 'cloud.dart';
import 'cloud_file.dart';

/// iCloud存储管理类
class ICloud extends Cloud {
  late final ICloudStorage iCloudStorage;

  final String containerId;

  static const String directory = "Documents";

  ICloud(this.containerId);

  @override
  Future<void> init() async {
    iCloudStorage = await ICloudStorage.getInstance(containerId);
  }

  @override
  Future<List<CloudFile>> cloudFileList() async {
    List<String> cloudNameList = await iCloudStorage.listFiles(directory: directory);
    if (cloudNameList.isEmpty) return [];
    return cloudNameList.map((cloudName) => CloudFile.fromCloud(cloudName, isMultiVersion)).toList();
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
      filePath: getLocalPath(file.fileName),
      directory: directory,
      destinationFileName: file.getCloudFileName(isMultiVersion),
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
      fileName: last.getCloudFileName(isMultiVersion),
      directory: directory,
      destinationFilePath: getLocalPath(last.fileName),
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
      fileName: file.getCloudFileName(isMultiVersion),
      directory: directory,
      destinationFilePath: getLocalPath(file.fileName),
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
      file.getCloudFileName(isMultiVersion),
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
    if (!isMultiVersion) return;
    List<CloudFile> cloudFileList = await findByFileName(file.fileName);
    if (cloudFileList.isEmpty) return;
    int cloudLength = cloudFileList.length;
    if (cloudLength <= maxVersionNumbers) return;
    // 删除前几个
    cloudFileList.sort((a, b) => a.compareTo(b));
    List<String> outOfDateNameList = [];
    for (int i = 0; i < cloudLength - maxVersionNumbers; i++) {
      CloudFile cloudFile = cloudFileList[i];
      outOfDateNameList.add(cloudFile.getCloudFileName(isMultiVersion));
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

  StreamSubscription<List<String>>? fileListSubscription;

  @override
  Future<void> watchFile({VoidCallback? onDone, ValueChanged<List<CloudFile>>? onData, ValueChanged<Object>? onError, bool cancelOnError = true}) async {
    if (null != fileListSubscription) {
      await cancelWatch();
    }
    Stream<List<String>> fileListStream = await iCloudStorage.watchFiles(directory: directory);
    fileListSubscription = fileListStream.listen(
      (files) {
        if (null == onData) return;
        List<CloudFile> cloudFileList = [];
        if (files.isNotEmpty) {
          cloudFileList = files.map((cloudName) => CloudFile.fromCloud(cloudName, isMultiVersion)).toList();
        }
        cloudFileList.sort((a, b) => a.compareTo(b));
        onData.call(cloudFileList);
      },
      onDone: onDone,
      onError: onError,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Future<void> cancelWatch() async {
    await fileListSubscription?.cancel();
    fileListSubscription = null;
  }

  @override
  Future<bool> isAvailable() async {
    return await iCloudStorage.isAvailable();
  }
}
