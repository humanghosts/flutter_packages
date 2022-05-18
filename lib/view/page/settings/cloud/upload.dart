import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/cloud/export.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/view/component/export.dart';
import 'package:hg_logger/view/page/home_pages.dart';

import '../../../../main.dart';

/// 逻辑
class UploadLogic extends CloudItemLogic {
  /// 备份进度
  Rx<double> uploadProgress = (0.0).obs;

  /// 备份
  Future<void> upload() async {
    bool can = await CloudHelper.cloud.isAvailable();
    if (!can) {
      RouteHelper.toast(msg: "iCloud不可用");
      return;
    }
    showOverlay();
    await CloudHelper.cloud.upload(
      CloudFile(AppConfig.dbConfig.dbFileName),
      onData: (progress) => uploadProgress.value = progress as double,
      onDone: () async {
        uploadProgress.value = 1;
        closeOverlay();
        RouteHelper.toast(msg: "备份完成");
      },
      onError: (err) {
        uploadProgress.value = 0;
        closeOverlay();
        RouteHelper.toast(msg: "备份失败，请检查网络或icloud设置");
      },
    );
  }

  @override
  List<Widget> get overlayContent {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return [
      SpinKitCircle(color: themeData.defaultTextColor),
      const Text("备份中"),
    ];
  }
}

/// 页面
class UploadWidget extends CloudItemWidget<UploadLogic> {
  UploadWidget({required String key}) : super(key: key, newLogic: UploadLogic());

  /// 构建页面容器
  @override
  Widget buildContent() {
    return buildUpload();
  }

  @override
  String get tooltip => "将数据文件拷贝至本机iCloud容器内";

  /// 备份
  Widget buildUpload() {
    return HgNeumorphicButton(
      getTooltip: () => tooltip,
      fullScreenTooltip: true,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [const Text("备份到iCloud"), buildToolTip()]),
          HgNeumorphicButton(child: const Text("备份"), onPressed: logic.upload),
        ],
      ),
      onPressed: logic.upload,
    );
  }
}
