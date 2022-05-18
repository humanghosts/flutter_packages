import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/cloud/export.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/component/export.dart';
import 'package:hg_logger/view/page/home_pages.dart';

import '../../../../main.dart';

/// 逻辑
class AutoUploadLogic extends CloudItemLogic {
  /// 数据服务
  final CloudConfigService _configService = CloudConfigService.instance;

  /// 同步配置
  CloudConfig config = CloudConfig();

  /// 配置更新标识
  Rx<int> configUpdateFlag = 0.obs;

  /// 是否正在自动上传
  Rx<bool> isAutoUploadingValue = false.obs;

  /// 是否自动同步
  Rx<bool> isAutoUpload = false.obs;

  /// 下次同步时间
  Rx<DateTime> nextUploadTime = DateTime.now().obs;

  /// 监测是否正在自动同步中
  Timer? checkAutoUploadingTimer;

  @override
  void onReady() {
    checkAutoUploadingTimer = Timer.periodic(const Duration(seconds: 30), (timer) => isAutoUploading());
  }

  @override
  void onClose() {
    super.onClose();
    checkAutoUploadingTimer?.cancel();
    checkAutoUploadingTimer = null;
  }

  /// 打开调用
  @override
  void onOpen() async {
    await findConfig();
  }

  /// 监测是否正在自动上传
  void isAutoUploading() {
    isAutoUploadingValue.value = _configService.isAutoUploading();
    if (isAutoUploadingValue.value && loader == null && background == null) showOverlay();
    if (!isAutoUploadingValue.value && (loader != null || background != null)) closeOverlay();
  }

  /// 查询同步配置
  Future<void> findConfig() async {
    config = await _configService.find();
    configUpdateFlag.value++;
    isAutoUpload.value = config.isAutoUpload.value;
    nextUploadTime.value = config.nextUploadTime.value ?? DateTime.now();
  }

  /// 设置是否自动同步
  void setIsAuto(bool? value) async {
    bool can = await CloudHelper.cloud.isAvailable();
    if (!can) {
      RouteHelper.toast(msg: "iCloud不可用");
      return;
    }
    value ??= !isAutoUpload.value;
    config.isAutoUpload.value = value;
    isAutoUpload.value = config.isAutoUpload.value;
    DateTime now = DateTime.now();
    if (value) {
      config.nextUploadTime.value = DateTime(now.year, now.month, now.day, now.hour, now.minute);
      nextUploadTime.value = config.nextUploadTime.value!;
    } else {
      config.nextUploadTime.clear();
    }
    await _configService.save(config);
    if (config.isAutoUpload.value && !config.nextUploadTime.isNull) showOverlay();
    _configService.autoUpload(
      onDone: (config) {
        this.config = config;
        nextUploadTime.value = config.nextUploadTime.value!;
        closeOverlay();
        RouteHelper.toast(msg: "备份成功");
      },
      onError: (error) {
        closeOverlay();
        RouteHelper.toast(msg: "备份失败,请重试");
      },
    );
  }

  @override
  List<Widget> get overlayContent {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return [
      SpinKitCircle(color: themeData.defaultTextColor),
      const Text("自动备份中"),
    ];
  }
}

/// 页面
class AutoUploadWidget extends CloudItemWidget<AutoUploadLogic> {
  AutoUploadWidget({required String key}) : super(key: key, newLogic: AutoUploadLogic());

  @override
  Widget buildContent() {
    return buildAutoUpload();
  }

  /// 自动备份
  Widget buildAutoUpload() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      padding: const EdgeInsets.all(8),
      getTooltip: () => tooltip,
      fullScreenTooltip: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [Text(logic.config.isAutoUpload.title), buildToolTip()]),
              // 下次备份时间
              Obx(() {
                bool isAutoUpload = logic.isAutoUpload.value;
                DateTime nextUploadTime = logic.nextUploadTime.value;
                if (!isAutoUpload) return Container();
                return Container(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text("预计下次备份时间:${DateTimeUtil.format(nextUploadTime)}", style: TextStyle(color: themeData.disabledColor)),
                );
              }),
            ],
          ),
          // 开关按钮
          Obx(() => NeumorphicSwitch(value: logic.isAutoUpload.value, onChanged: logic.setIsAuto)),
        ],
      ),
      onPressed: () => logic.setIsAuto(null),
    );
  }

  @override
  String get tooltip => "用于自动备份本地数据到icloud中。\n"
      "设置自动备份后，会根据备份时间设置定时任务进行备份(应用被杀死的情况下任务不会执行)。"
      "为了保证任务执行，冷启动应用的时候会检查是否备份，没有备份的话会立即备份一次。\n"
      "备份完成之后会更新下次备份时间(+24小时)";
}
