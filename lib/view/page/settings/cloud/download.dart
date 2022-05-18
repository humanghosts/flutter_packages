import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/component/export.dart';

import 'cloud.dart';

/// 逻辑
class DownloadLogic extends CloudItemLogic {
  /// 数据服务
  final CloudConfigService configService = CloudConfigService.instance;

  /// 下载进度
  Rx<double> downloadProgress = (0.0).obs;

  /// 下载提示
  Future<bool?> downloadRequest(String msg) async {
    return await RouteHelper.showOneChoiceRequest(msg: msg, doneText: "确定");
  }

  /// 下载
  Future<void> download() async {
    bool can = await CloudHelper.cloud.isAvailable();
    if (!can) {
      RouteHelper.toast(msg: "iCloud不可用");
      return;
    }
    bool? canDownload = await downloadRequest("确定要下载并覆盖本地数据吗？");
    if (canDownload != true) return;
    showOverlay();
    await CloudHelper.cloud.downloadLast(
      CloudFile(AppConfig.dbConfig.dbFileName),
      onData: (progress) => downloadProgress.value = progress as double,
      onDone: () async {
        // 刷新数据库
        await configService.afterDownload();
        downloadProgress.value = 1;
        closeOverlay();
        RouteHelper.toast(msg: "下载完成");
      },
      onError: (err) {
        downloadProgress.value = 0;
        closeOverlay();
        RouteHelper.toast(msg: "下载失败，请检查网络或icloud设置");
      },
      onEmpty: () {
        downloadProgress.value = 0;
        closeOverlay();
        RouteHelper.toast(msg: "下载失败，没有备份文件");
      },
    );
  }

  @override
  List<Widget> get overlayContent {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return [
      SpinKitCircle(color: themeData.defaultTextColor),
      const Text("下载中"),
    ];
  }
}

/// 页面
class DownloadWidget extends CloudItemWidget<DownloadLogic> {
  DownloadWidget({required String key}) : super(key: key, newLogic: DownloadLogic());

  /// 构建页面容器
  @override
  Widget buildContent() {
    return buildDownloadLast();
  }

  @override
  String get tooltip => "拷贝本机iCloud容器的最新的数据文件到应用内并覆盖当前数据文件";

  /// 下载最新版本
  Widget buildDownloadLast() {
    return HgNeumorphicButton(
      padding: const EdgeInsets.all(8),
      getTooltip: () => tooltip,
      fullScreenTooltip: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [const Text("下载最新版本"), buildToolTip()]),
          HgNeumorphicButton(child: const Text("下载"), onPressed: logic.download),
        ],
      ),
      onPressed: logic.download,
    );
  }
}
