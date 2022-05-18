import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/component/export.dart';
import 'package:hg_logger/view/page/home_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 逻辑
class DownloadVersionLogic extends CloudItemLogic {
  /// 数据服务
  final CloudConfigService configService = CloudConfigService.instance;

  /// 刷新控制器
  RefreshController refreshController = RefreshController();

  /// 所有版本列表
  List<CloudFile> versionList = [];

  /// 版本列表更新标识
  Rx<int> versionListUpdateFlag = 0.obs;

  /// 下载版本列表
  Map<int, double?> downloadVersionMap = {};

  /// 下载列表更新标识
  Rx<int> downloadVersionMapUpdateFlag = 0.obs;

  Rx<bool> isFinding = false.obs;

  /// 打开调用
  @override
  void onOpen() async {
    super.onOpen();
    versionListUpdateFlag.value = 0;
    isFinding.value = false;
    refreshController = RefreshController();
  }

  /// 展开/收缩
  void onExpand(bool isExpand) {
    if (isExpand && versionList.isEmpty) findAllVersion();
  }

  /// 查询所有版本文件
  Future<void> findAllVersion() async {
    bool can = await CloudHelper.cloud.isAvailable();
    if (!can) {
      refreshController.refreshCompleted();
      RouteHelper.toast(msg: "iCloud不可用");
      return;
    }
    isFinding.value = true;
    versionList.clear();
    versionList = await CloudHelper.cloud.findByFileName(AppConfig.dbConfig.dbFileName);
    refreshController.refreshCompleted();
    isFinding.value = false;
    versionListUpdateFlag.value++;
  }

  /// 下载提示
  Future<bool?> downloadRequest(String msg) async {
    return await RouteHelper.showOneChoiceRequest(msg: msg, doneText: "确定");
  }

  /// 下载指定版本
  Future<void> downloadVersion(CloudFile cloudFile) async {
    bool can = await CloudHelper.cloud.isAvailable();
    if (!can) {
      RouteHelper.toast(msg: "iCloud不可用");
      return;
    }
    bool? canDownload = await downloadRequest("确定要下载此版本并覆盖本地数据吗？");
    if (canDownload != true) return;
    showOverlay();
    int key = cloudFile.dateTime.millisecondsSinceEpoch;
    await CloudHelper.cloud.download(
      cloudFile,
      onData: (progress) {
        downloadVersionMap[key] = progress as double;
        downloadVersionMapUpdateFlag.value++;
      },
      onDone: () async {
        await configService.afterDownload();
        downloadVersionMap[key] = 1;
        downloadVersionMapUpdateFlag.value++;
        closeOverlay();
        RouteHelper.toast(msg: "下载完成");
      },
      onError: (err) {
        downloadVersionMap[key] = 0;
        downloadVersionMapUpdateFlag.value++;
        closeOverlay();
        RouteHelper.toast(msg: "指定版本下载失败，请检查网络或icloud设置");
      },
    );
  }

  /// 删除指定版本
  Future<void> deleteVersion(CloudFile cloudFile) async {
    bool can = await CloudHelper.cloud.isAvailable();
    if (!can) {
      RouteHelper.toast(msg: "iCloud不可用");
      return;
    }
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    RouteHelper.overlayBuilder((loader, background) {
      CloudHelper.cloud.delete(
        cloudFile,
        onDone: () {
          loader?.remove();
          background.remove();
          RouteHelper.toast(msg: "删除成功");
          findAllVersion();
        },
        onError: (value) {
          loader?.remove();
          background.remove();
          RouteHelper.toast(msg: "删除成功");
          findAllVersion();
        },
      );
      return Scaffold(
        backgroundColor: themeData.baseColor.withOpacity(0.5),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitCircle(color: themeData.defaultTextColor),
            const Text("删除中"),
          ],
        ),
      );
    });
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
class DownloadVersionWidget extends CloudItemWidget<DownloadVersionLogic> {
  DownloadVersionWidget({required String key}) : super(key: key, newLogic: DownloadVersionLogic());

  /// 构建页面容器
  @override
  Widget buildContent() {
    return buildVersions();
  }

  @override
  String get tooltip => "此处显示的数据备份版本列表为本机上iCloud容器内的版本列表。\n"
      "数据备份操作是将文件拷贝到本机的iCloud容器内，由苹果决定何时上传到云端。\n"
      "删除应用不会删除已经拷贝至iCloud容器内的数据，需要在此处手动删除。";

  /// 查看所有版本
  Widget buildVersions() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;

    return HgNeumorphicExpandedButton(
      key: "cloud_versions",
      args: HgNeumorphicExpandedButtonArgs(
        getTooltip: () => tooltip,
        fullScreenTooltip: true,
        left: Row(children: [const Text("查看所有版本"), buildToolTip()]),
        child: Container(
          height: Get.height * 0.5,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
          child: Obx(() {
            int versionListUpdateFlag = logic.versionListUpdateFlag.value;
            debugPrint("同步版本列表更新次数:$versionListUpdateFlag");
            bool isFinding = logic.isFinding.value;
            Widget child;
            if (isFinding) {
              child = Center(
                child: Text("正在查询", style: TextStyle(color: themeData.disabledColor)),
              );
            } else {
              List<CloudFile> versionList = logic.versionList;
              if (versionList.isEmpty) {
                child = Center(
                  child: Text("未查询到备份信息", style: TextStyle(color: themeData.disabledColor)),
                );
              } else {
                child = ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) {
                    int realIndex = logic.versionList.length - 1 - index;
                    CloudFile cloudFile = logic.versionList[realIndex];
                    return buildOneVersion(index + 1, cloudFile);
                  },
                  itemCount: logic.versionList.length,
                );
              }
            }
            return SmartRefresher(
              controller: logic.refreshController,
              header: WaterDropHeader(
                refresh: SpinKitCircle(color: themeData.disabledColor),
                waterDropColor: themeData.disabledColor,
                complete: HgNeumorphicIcon(Icons.done, color: themeData.disabledColor),
              ),
              onRefresh: logic.findAllVersion,
              child: child,
            );
          }),
        ),
        onExpanded: logic.onExpand,
        rowPadding: const EdgeInsets.all(8),
        containerPadding: EdgeInsets.zero,
      ),
    );
  }

  /// 构建单个版本
  Widget buildOneVersion(int index, CloudFile cloudFile) {
    DateTime dateTime = cloudFile.dateTime;
    return SlideInLeft(
      child: HgNeumorphicButton(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: EdgeInsets.zero,
        child: Removeable(
          key: cloudFile.hashCode.toString(),
          text: "确定删除这个版本的备份吗？",
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$index. ${DateTimeUtil.format(dateTime)}"),
                HgNeumorphicButton(
                  padding: const EdgeInsets.all(8),
                  child: const Text("下载"),
                  onPressed: () => logic.downloadVersion(cloudFile),
                ),
              ],
            ),
          ),
          onRemove: () {
            logic.deleteVersion(cloudFile);
          },
          isShowHint: () => true,
        ),
        onPressed: () => logic.downloadVersion(cloudFile),
      ),
    );
  }
}
