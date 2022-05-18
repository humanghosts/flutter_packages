import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/route/observer.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/data/timing.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

import '../base/detail.dart';
import 'detail.dart';

@immutable
class TimingListArgs extends ViewArgs {
  /// 导航id
  final int? navigatorId;

  /// 回调
  final VoidCallback onBack;

  /// 页面状态
  final PageState state;

  const TimingListArgs({
    required this.onBack,
    this.navigatorId,
    required this.state,
  });
}

@immutable
class TimingListDataSource extends ViewDataSource {
  final ListAttribute<RepeatableTiming> timingListAttribute;

  const TimingListDataSource({required this.timingListAttribute});
}

class TimingListLogic extends ViewLogic<TimingListArgs, TimingListDataSource> {
  /// 临时存储变量
  List<RepeatableTiming> timingList = [];

  Rx<int> listUpdateFlag = 0.obs;

  /// 打开回调
  /// TODO 列表为空自动新增一个，并且跳转到详情页面
  @override
  void afterArgsUpdate() {
    if (args.state == PageState.browse) return;
    listUpdateFlag.value = 0;
    timingList = dataSource.timingListAttribute.value.map((e) => e.clone() as RepeatableTiming).toList();
    // if (timingList.isEmpty) {
    //   RepeatableTiming timing = RepeatableTiming();
    //   timingList.add(timing);
    //   WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //     listUpdateFlag.value++;
    //     (widget as TimingList).toDetail(timing);
    //   });
    // }
  }

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 界面返回时调用
  void onBack() {
    clearEmpty();
    dataSource.timingListAttribute.clear();
    dataSource.timingListAttribute.addAll(timingList);
    args.onBack.call();
  }

  /// 清空无效或相同时间
  void clearEmpty() {
    List<RepeatableTiming> finalList = [];
    Set<String> uniqueCodeSet = {};
    for (RepeatableTiming timing in timingList) {
      // 为空 返回
      if (timing.isNull) continue;
      String uniqueCode = timing.uniqueCode;
      // 相同 返回
      if (uniqueCodeSet.contains(uniqueCode)) return;
      uniqueCodeSet.add(uniqueCode);
      finalList.add(timing);
    }
    if (timingList.length != finalList.length) {
      RouteHelper.toast(msg: "已清空无效时间和重复时间");
      timingList = finalList;
    }
  }

  /// 新添加一个时间
  void add() {
    RepeatableTiming timing = RepeatableTiming();
    timingList.add(timing);
    listUpdateFlag.value++;
    (widget as TimingList).toDetail(timing);
  }

  /// 移除某个时间
  void remove(int index) {
    timingList.removeAt(index);
    listUpdateFlag.value++;
  }

  /// 时间变化回调
  void onTimingChange() {
    listUpdateFlag.value++;
  }

  void addNow() {
    DateTime now = DateTime.now();
    RepeatableTiming timing = RepeatableTiming()
      ..start.value = now
      ..end.value = now;
    timingList.add(timing);
    listUpdateFlag.value++;
  }

  void addToday() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = DateTime(today.year, today.month, today.day + 1);
    RepeatableTiming timing = RepeatableTiming()
      ..start.value = today
      ..end.value = tomorrow.add(const Duration(microseconds: -1));
    timingList.add(timing);
    listUpdateFlag.value++;
  }

  void addTomorrow() {
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    DateTime afterTomorrow = DateTime(tomorrow.year, tomorrow.month, tomorrow.day + 1);
    RepeatableTiming timing = RepeatableTiming()
      ..start.value = tomorrow
      ..end.value = afterTomorrow.add(const Duration(microseconds: -1));
    timingList.add(timing);
    listUpdateFlag.value++;
  }
}

/// 日期时间列表
class TimingList extends View<TimingListLogic> with ObserverWidget {
  TimingList({
    required String key,
    required TimingListArgs args,
    required TimingListDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: TimingListLogic());

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      title: HgNeumorphicText("${logic.dataSource.timingListAttribute.title}列表"),
      body: buildTimingList(),
      bodyPadding: EdgeInsets.zero,
      // 新增按钮 浏览状态没有
      floatingActionButton: logic.args.state == PageState.browse ? null : buildPageFab(),
      // 按钮位置
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  /// 新增按钮
  Widget? buildPageFab() {
    String expandableFabKey = logic.key;

    void closeExpandableFab({Function()? then}) {
      ExpandableFabLogic logic = Get.find<ExpandableFabLogic>(tag: expandableFabKey);
      logic.toggle();
      then?.call();
    }

    // 展开动画按钮
    return ExpandableFab(
      key: expandableFabKey,
      args: ExpandableFabArgs(
        children: [
          ActionButton(
            child: HgNeumorphicIcon(Icons.add_outlined),
            title: "自定义",
            onPressed: () => closeExpandableFab(then: logic.add),
          ),
          ActionButton(
            child: HgNeumorphicIcon(Icons.timer_outlined),
            title: "现在",
            onPressed: () => closeExpandableFab(then: logic.addNow),
          ),
          ActionButton(
            child: HgNeumorphicIcon(Icons.today_rounded),
            title: "今天",
            onPressed: () => closeExpandableFab(then: logic.addToday),
          ),
          ActionButton(
            child: HgNeumorphicIcon(Icons.hourglass_top_outlined),
            title: "明天",
            onPressed: () => closeExpandableFab(then: logic.addTomorrow),
          ),
        ],
      ),
    );
  }

  /// 构建已选日期时间的列表
  Widget buildTimingList() {
    return Obx(() {
      int listUpdateFlag = logic.listUpdateFlag.value;
      debugPrint("时间列表更新次数:$listUpdateFlag");
      List<RepeatableTiming> timingList = logic.timingList;
      return ListView.builder(
        itemBuilder: (context, index) {
          RepeatableTiming timing = timingList[index];
          return HgNeumorphicButton(
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Removeable(
              key: "timing_list_${index}_${timing.hashCode}",
              child: Container(
                padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                // 内容
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [buildTimingItem(timing), HgNeumorphicNextButton(onPressed: () => toDetail(timing))],
                ),
              ),
              // 删除操作
              onRemove: logic.args.state == PageState.browse ? null : () => logic.remove(index),
              // 是否提示删除
              isShowHint: () => !timing.isNull,
            ),
            onPressed: () => toDetail(timing),
          );
        },
        itemCount: timingList.length,
      );
    });
  }

  /// 构建已选日期时间的单项
  Widget buildTimingItem(RepeatableTiming timing) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    if (timing.isNull) return Text(timing.toString(), style: TextStyle(color: themeData.disabledColor));
    return Expanded(
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: const AlwaysScrollableScrollPhysics(),
        child: timing.toWidget(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  /// 打开明细页面
  void toDetail(RepeatableTiming timing) {
    if (null == logic.args.navigatorId) {
      RouteHelper.cupertinoBottomSheet(sheet: buildDetail(timing));
    } else {
      RouteHelper.to(page: buildDetail(timing), id: logic.args.navigatorId);
    }
  }

  /// 明细页面组件
  Widget buildDetail(RepeatableTiming timing) {
    return RepeatableTimingDetail(
      key: timing.hashCode.toString(),
      dataSource: TimingDetailDataSource(timing: timing),
      args: TimingDetailArgs(
        state: logic.args.state,
        onBack: logic.onTimingChange,
        navigatorId: logic.args.navigatorId,
      ),
    );
  }
}
