import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/data/focus.dart' as models;
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/export.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 外部参数
@immutable
class FocusHistoryArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 上级导航id
  final int parentNavigatorId;

  const FocusHistoryArgs({
    required this.navigatorId,
    required this.parentNavigatorId,
  });
}

/// 逻辑
class FocusHistoryLogic extends ViewLogicOnlyArgs<FocusHistoryArgs> {
  Rx<int> listUpdateFlag = 0.obs;

  /// 所有专注
  List<models.Focus> focusList = [];

  /// 专注服务
  static final FocusService _focusService = FocusService.instance;

  /// 下拉刷新控制器
  RefreshController refreshController = RefreshController();

  /// 返回
  void back() {
    RouteHelper.back(id: args.parentNavigatorId);
  }

  /// 打开回调
  @override
  void afterArgsUpdate() {
    listUpdateFlag.value = 0;
    refreshController = RefreshController();
    findFocusList();
  }

  /// 所有专注记录
  Future<void> findFocusList() async {
    focusList = await _focusService.find(isLogicDelete: false);
    // 倒序排序
    focusList.sort((a, b) => -a.start.value.compareTo(b.start.value));
    listUpdateFlag.value++;
    refreshController.refreshCompleted();
  }
}

/// 页面
class FocusHistory extends View<FocusHistoryLogic> {
  FocusHistory({
    required String key,
    required FocusHistoryArgs args,
  }) : super(key: key, args: args, newLogic: FocusHistoryLogic());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      title: HgNeumorphicText("专注历史"),
      body: buildSmartRefresher(),
      bodyPadding: const EdgeInsets.only(top: 12),
    );
  }

  /// 构建列表刷新器
  Widget buildSmartRefresher() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return SafeArea(
      bottom: false,
      child: SmartRefresher(
        key: ValueKey(logic.key),
        controller: logic.refreshController,
        child: buildHistoryList(),
        header: WaterDropHeader(
          refresh: SpinKitCircle(color: themeData.disabledColor),
          waterDropColor: themeData.disabledColor,
          complete: HgNeumorphicIcon(Icons.done, color: themeData.disabledColor),
        ),
        onRefresh: () {
          HapticFeedback.lightImpact();
          logic.findFocusList();
        },
      ),
    );
  }

  /// 构建历史记录
  Widget buildHistoryList() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(() {
      int listUpdateFlag = logic.listUpdateFlag.value;
      debugPrint("专注历史列表更新次数：$listUpdateFlag");
      if (logic.focusList.isEmpty) {
        return Center(child: Text("无专注记录", style: TextStyle(color: themeData.disabledColor)));
      }
      return ListView.builder(
        itemCount: logic.focusList.length,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.width * 0.5),
        itemBuilder: (context, index) {
          models.Focus focus = logic.focusList[index];
          DateTime start = focus.start.value;
          DateTime end = focus.end.value;
          DeriveEvent? event = focus.event.value;
          int milliseconds = focus.milliseconds.value;
          Duration duration = Duration(milliseconds: milliseconds);
          String dateTime;
          String period = DateTimeUtil.period(start, end, joinStr: "~");
          List<String> periods = period.split("~");
          String startTime = periods[0];
          String endTime = periods[1];
          if (startTime == endTime) {
            dateTime = startTime;
          } else {
            dateTime = "$startTime~$endTime";
          }
          return Neumorphic(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text("时间 : $dateTime"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text.rich(TextSpan(children: [
                    const TextSpan(text: "事件 : "),
                    TextSpan(
                      text: event == null ? "" : event.toString(),
                      style: TextStyle(decoration: event?.isDelete.value ?? false ? TextDecoration.lineThrough : null),
                    ),
                    TextSpan(text: event?.isDelete.value ?? false ? " (已删除)" : "", style: const TextStyle(color: Colors.red)),
                  ])),
                  Text("专注时长 : ${duration.toString().split(".")[0]}"),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
