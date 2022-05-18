import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/component/export.dart';

import '../settings.dart';
import 'auto_upload.dart';
import 'download.dart';
import 'download_version.dart';
import 'upload.dart';

/// 逻辑
class CloudSettingsLogic extends SettingsItemLogic {}

/// 页面
class CloudSettingsPage extends SettingsItem<CloudSettingsLogic> {
  CloudSettingsPage({required String key, required SettingsItemArgs args}) : super(key: key, args: args, newLogic: CloudSettingsLogic());

  @override
  String get title => "数据备份";

  /// 构建页面容器
  @override
  Widget buildSettings() {
    return ListView(
      clipBehavior: Clip.none,
      padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.5, top: 12),
      children: [
        buildAutoUpload(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildUpload(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildDownloadLast(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildVersions(),
      ],
    );
  }

  /// 自动备份
  Widget buildAutoUpload() {
    return AutoUploadWidget(key: "cloud_auto_upload");
  }

  /// 备份
  Widget buildUpload() {
    return UploadWidget(key: "cloud_upload");
  }

  /// 下载最新版本
  Widget buildDownloadLast() {
    return DownloadWidget(key: "cloud_download_last");
  }

  /// 查看所有版本
  Widget buildVersions() {
    return DownloadVersionWidget(key: "cloud_download_version");
  }
}

abstract class CloudItemLogic extends GetxController {
  late String key;
  OverlayEntry? loader;
  OverlayEntry? background;

  Rx<int> overlayUpdateFlag = 0.obs;

  bool isOverlay = false;

  void onOpen() {
    overlayUpdateFlag.value = 0;
  }

  /// 打开弹框
  void showOverlay() {
    if (isOverlay) return;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    isOverlay = true;
    RouteHelper.overlayBuilder((loader, background) {
      this.loader = loader;
      this.background = background;
      if (!isOverlay) closeOverlay();
      return Scaffold(
        backgroundColor: themeData.baseColor.withOpacity(0.5),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: overlayContent,
        ),
      );
    });
  }

  /// 弹框内容
  List<Widget> get overlayContent;

  /// 关闭弹框
  void closeOverlay() {
    if (!isOverlay) return;
    loader?.remove();
    background?.remove();
    loader = null;
    background = null;
    isOverlay = false;
  }
}

/// 组件
abstract class CloudItemWidget<L extends CloudItemLogic> extends StatelessWidget {
  late final L logic;

  CloudItemWidget({required String key, required L newLogic}) : super(key: ValueKey(key)) {
    logic = Get.put<L>(newLogic, tag: key);
    logic.key = key;
    logic.onOpen();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<L>(
      init: logic,
      tag: logic.key,
      builder: (logic) {
        return buildContent();
      },
    );
  }

  Widget buildContent();

  Widget buildToolTip() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    if (tooltip.isEmpty) return Container();
    return Container(
      padding: const EdgeInsets.only(left: 3),
      child: GestureDetector(child: HgNeumorphicIcon(Icons.help, color: themeData.disabledColor), onTap: showTooltip),
    );
  }

  String get tooltip => "";

  /// 帮助信息
  void showTooltip() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    HapticFeedback.lightImpact();
    RouteHelper.overlay(SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Text(
            tooltip,
            style: TextStyle(overflow: TextOverflow.visible, color: themeData.defaultTextColor, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    ));
  }
}
