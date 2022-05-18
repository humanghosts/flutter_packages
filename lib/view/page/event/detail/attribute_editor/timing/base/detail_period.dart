import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

import 'notice/notice_detail.dart';
import 'notice/notice_list.dart';

@immutable
class TimingDetailPeriodArgs extends ViewArgs {
  /// 导航id
  final int? navigatorId;

  /// 页面状态
  final PageState state;

  const TimingDetailPeriodArgs({
    this.navigatorId,
    required this.state,
  });
}

@immutable
class TimingDetailPeriodDataSource<T extends Timing> extends ViewDataSource {
  final T timing;

  const TimingDetailPeriodDataSource({required this.timing});
}

class TimingDetailPeriodLogic<T extends Timing> extends TutorialViewLogic<TimingDetailPeriodArgs, TimingDetailPeriodDataSource<T>> {
  /// 是否全天区间
  bool isDatePeriod = false;

  /// 提醒列表更新次数
  Rx<int> noticeUpdateFlag = 0.obs;

  /// 打开回调
  @override
  void afterArgsUpdate() {
    noticeUpdateFlag.value = 0;
    DateTime now = DateTime.now();
    DateTime start = (dataSource.timing.start.value ??= now);
    DateTime end = (dataSource.timing.end.value ??= now);
    if (dataSource.timing.endNotice.isNull) {
      for (Notice startNotice in dataSource.timing.startNotice.value) {
        dataSource.timing.endNotice.add(startNotice.clone() as Notice);
      }
    }
    isDatePeriod = !start.isSameDay(end);
  }

  /// 切换模式 跨天/当天
  void switchPeriodType() {
    isDatePeriod = !isDatePeriod;
    DateTime now = DateTime.now();
    // 跨天
    if (isDatePeriod) {
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime tomorrow = DateTime(today.year, today.month, today.day + 1);
      dataSource.timing.start.value = today;
      dataSource.timing.end.value = DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        tomorrow.hour,
        tomorrow.minute,
        tomorrow.second,
        tomorrow.millisecond,
        tomorrow.microsecond - 1,
      );
    }
    // 当天
    else {
      dataSource.timing.start.value = now;
      dataSource.timing.end.value = now;
    }
    update();
  }

  /// 开始时间修改
  void onStartChanged(DateTime dateTime) {
    dataSource.timing.start.value = dateTime;
  }

  /// 结束时间修改
  void onEndChanged(DateTime dateTime) {
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

  /// 提醒列表修改 修改开始提醒和结束提醒
  void onNoticeListChanged(List<Notice> noticeList) {
    dataSource.timing.startNotice.value = noticeList;
    dataSource.timing.endNotice.value = noticeList;
    noticeUpdateFlag.value++;
  }

  /// 提醒修改
  void onNoticeChanged() {
    noticeUpdateFlag.value++;
  }

  @override
  void buildTutorial() {}

  @override
  String? get tutorialSubKey => "attribute_timing_period";

  @override
  HomePages get homePage => HomePages.event;
}

/// 时间详情弹框
class TimingDetailPeriod<M extends Timing, L extends TimingDetailPeriodLogic<M>> extends View<L> {
  TimingDetailPeriod({
    required String key,
    required TimingDetailPeriodArgs args,
    required TimingDetailPeriodDataSource<M> dataSource,
    required L newLogic,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: newLogic);

  @override
  Widget buildView(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: Get.height * 0.5),
      clipBehavior: Clip.none,
      children: [
        buildTypeSwitch(),
        logic.isDatePeriod ? buildDatePeriod() : buildTimePeriod(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        buildPeriodNotice(),
        const Padding(padding: EdgeInsets.only(top: 16)),
        ...buildExtend(),
      ],
    );
  }

  /// 额外组件
  List<Widget> buildExtend() => [];

  /// 类型切换
  Widget buildTypeSwitch() {
    return HgNeumorphicButton(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("全天"),
          NeumorphicSwitch(
              value: logic.isDatePeriod,
              onChanged: (value) {
                HapticFeedback.lightImpact();
                logic.switchPeriodType();
              }),
        ],
      ),
      onPressed: logic.switchPeriodType,
    );
  }

  /// 日期区间
  Widget buildDatePeriod() {
    return DateRangePicker(
      key: 'timing_date_period_$M',
      args: DateRangePickerArgs(
        firstDate: DateTime.fromMillisecondsSinceEpoch(0),
        lastDate: DateTime(2050, 12, 31),
        initialStart: logic.dataSource.timing.start.value!,
        initialEnd: logic.dataSource.timing.end.value!,
        onStartChanged: logic.onStartChanged,
        onEndChanged: logic.onEndChanged,
      ),
    );
  }

  /// 时间区间
  Widget buildTimePeriod() {
    return TimeRangePicker(
      key: "timing_time_period_$M",
      args: TimeRangePickerArgs(
        firstDate: DateTime.fromMillisecondsSinceEpoch(0),
        lastDate: DateTime(2050, 12, 31),
        initialStart: logic.dataSource.timing.start.value!,
        initialEnd: logic.dataSource.timing.end.value!,
        onStartChanged: logic.onStartChanged,
        onEndChanged: logic.onEndChanged,
      ),
    );
  }

  /// 区间提醒
  Widget buildPeriodNotice() {
    return NeumorphicFormField(
      title: Row(children: [HgNeumorphicIcon(Icons.notifications), const Text("提醒")]),
      onTap: toNoticeList,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextFormField(onTap: toNoticeList, maxLines: 1, decoration: const InputDecoration(hintText: "提醒选择"), readOnly: true),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              int noticeUpdateFlag = logic.noticeUpdateFlag.value;
              debugPrint("时间段提醒列表更新次数:$noticeUpdateFlag");
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
            debugPrint("时间段提醒列表更新次数:$noticeUpdateFlag");
            M timing = logic.dataSource.timing;
            if (logic.args.state == PageState.browse || (timing.startNotice.isNull && timing.endNotice.isNull)) return Container();
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

  /// 提醒列表组件
  Widget buildNoticeList() {
    return NoticeList(
      key: 'timing_detail_period_notice',
      dataSource: NoticeListDataSource(noticeList: logic.dataSource.timing.startNotice.value),
      args: NoticeListArgs(
        state: logic.args.state,
        navigatorId: logic.args.navigatorId,
        onBack: logic.onNoticeListChanged,
      ),
    );
  }

  /// 提醒详情
  void toNoticeDetail(Notice notice) {
    if (logic.args.state == PageState.browse) return;
    if (null == logic.args.navigatorId) {
      RouteHelper.cupertinoBottomSheet(sheet: buildNoticeDetail(notice));
    } else {
      RouteHelper.to(page: buildNoticeDetail(notice), id: logic.args.navigatorId);
    }
  }

  Widget buildNoticeDetail(Notice notice) {
    return NoticeDetail(
      key: notice.hashCode.toString(),
      dataSource: NoticeDetailDataSource(notice: notice),
      args: NoticeDetailArgs(onBack: logic.onNoticeChanged, navigatorId: logic.args.navigatorId),
    );
  }
}
