import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

import 'notice/notice_detail.dart';
import 'notice/notice_list.dart';

@immutable
class TimingDetailTimeArgs extends ViewArgs {
  /// 导航id
  final int? navigatorId;

  /// 页面状态
  final PageState state;

  const TimingDetailTimeArgs({
    this.navigatorId,
    required this.state,
  });
}

@immutable
class TimingDetailTimeDataSource<T extends Timing> extends ViewDataSource {
  final T timing;

  const TimingDetailTimeDataSource({required this.timing});
}

class TimingDetailTimeLogic<T extends Timing> extends TutorialViewLogic<TimingDetailTimeArgs, TimingDetailTimeDataSource<T>> {
  /// 提醒列表更新次数
  Rx<int> noticeUpdateFlag = 0.obs;

  /// 打开回调
  @override
  void afterArgsUpdate() {
    noticeUpdateFlag.value = 0;
    // 当前时间
    DateTime now = DateTime.now();
    // 没有时间赋值当前
    dataSource.timing.start.value ??= now;
    dataSource.timing.end.value = dataSource.timing.start.value;
    // 时间点使用开始提醒 结束提醒直接清空
    dataSource.timing.endNotice.clear();
  }

  /// 时间修改
  void onDateTimeChanged(DateTime dateTime) {
    dataSource.timing.start.value = dateTime;
    dataSource.timing.end.value = dateTime;
  }

  /// 清空提醒
  void clearNotice() async {
    bool? isClear = await RouteHelper.showOneChoiceRequest(msg: "确定删除所有提醒吗?");
    if (isClear != true) return;
    dataSource.timing.startNotice.clear();
    dataSource.timing.endNotice.clear();
    noticeUpdateFlag.value++;
  }

  /// 提醒列表修改
  void onNoticeListChanged(List<Notice> noticeList) {
    dataSource.timing.startNotice.value = noticeList;
    dataSource.timing.endNotice.clear();
    noticeUpdateFlag.value++;
  }

  /// 提醒修改
  void onNoticeChanged() {
    noticeUpdateFlag.value++;
  }

  @override
  void buildTutorial() {}

  @override
  String? get tutorialSubKey => "attribute_timing_time";

  @override
  HomePages get homePage => HomePages.event;
}

/// 时间详情弹框
class TimingDetailTime<M extends Timing, L extends TimingDetailTimeLogic<M>> extends View<L> {
  TimingDetailTime({
    required String key,
    required TimingDetailTimeArgs args,
    required TimingDetailTimeDataSource<M> dataSource,
    required L newLogic,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: newLogic);

  @override
  Widget buildView(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: Get.height * 0.5),
      clipBehavior: Clip.none,
      children: [
        buildDateTimePicker(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildTimeNotice(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        ...buildExtend(),
      ],
    );
  }

  /// 构建额外的内容
  List<Widget> buildExtend() => [];

  /// 构建日期
  Widget buildDateTimePicker() {
    return DateTimePicker(
      key: "timing_detail_time_date_time",
      args: DateTimePickerArgs(
        firstDate: DateTime.fromMillisecondsSinceEpoch(0),
        lastDate: DateTime(2050, 12, 31),
        initialDate: logic.dataSource.timing.start.value ?? DateTime.now(),
        onDateTimeChanged: logic.onDateTimeChanged,
      ),
    );
  }

  ///  时间点提醒
  Widget buildTimeNotice() {
    return NeumorphicFormField(
      title: Row(children: [HgNeumorphicIcon(Icons.notifications), const Text("提醒")]),
      onTap: toNoticeList,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // 提示
          TextFormField(onTap: toNoticeList, maxLines: 1, decoration: const InputDecoration(hintText: "提醒选择"), readOnly: true),
          // 提醒列表
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              int noticeUpdateFlag = logic.noticeUpdateFlag.value;
              debugPrint("时间提醒列表更新次数:$noticeUpdateFlag");
              List<Notice> noticeList = logic.dataSource.timing.startNotice.value;
              List<Widget> children = [];
              for (Notice notice in noticeList) {
                children.add(Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: HgNeumorphicChip(
                    label: Text(notice.toString()),
                    onTap: () => toNoticeDetail(notice),
                  ),
                ));
              }
              return Row(children: children);
            }),
          ),
          // 清空按钮
          Obx(() {
            int noticeUpdateFlag = logic.noticeUpdateFlag.value;
            debugPrint("时间提醒列表更新次数:$noticeUpdateFlag");
            if (logic.args.state == PageState.browse || logic.dataSource.timing.startNotice.isNull) return Container();
            return Positioned(
              right: 0,
              child: HgNeumorphicButton(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.only(right: 16),
                style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                child: HgNeumorphicIcon(Icons.clear),
                onPressed: logic.clearNotice,
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 打开提醒列表
  void toNoticeList() {
    if (logic.args.state == PageState.browse) return;
    HapticFeedback.lightImpact();
    if (null == logic.args.navigatorId) {
      RouteHelper.cupertinoBottomSheet(sheet: buildNoticeList());
    } else {
      RouteHelper.to(page: buildNoticeList(), id: logic.args.navigatorId);
    }
  }

  /// 提醒列表页面组件
  Widget buildNoticeList() {
    return NoticeList(
      key: 'timing_detail_time_notice',
      dataSource: NoticeListDataSource(noticeList: logic.dataSource.timing.startNotice.value),
      args: NoticeListArgs(
        state: logic.args.state,
        navigatorId: logic.args.navigatorId,
        onBack: logic.onNoticeListChanged,
      ),
    );
  }

  /// 打开单个提醒
  void toNoticeDetail(Notice notice) {
    if (logic.args.state == PageState.browse) return;
    if (null == logic.args.navigatorId) {
      RouteHelper.cupertinoBottomSheet(sheet: buildNoticeDetail(notice));
    } else {
      RouteHelper.to(page: buildNoticeDetail(notice), id: logic.args.navigatorId);
    }
  }

  /// 提醒详情页面组件
  Widget buildNoticeDetail(Notice notice) {
    return NoticeDetail(
      key: notice.hashCode.toString(),
      dataSource: NoticeDetailDataSource(notice: notice),
      args: NoticeDetailArgs(onBack: logic.onNoticeChanged, navigatorId: logic.args.navigatorId),
    );
  }
}
