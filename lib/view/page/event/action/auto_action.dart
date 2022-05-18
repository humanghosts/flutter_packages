import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../detail/detail_derive.dart';
import '../detail/detail_event.dart';
import 'action_card.dart';

@immutable
class AutoActionArgs extends ViewArgs {
  /// 导航id
  final int? navigatorId;

  const AutoActionArgs({this.navigatorId});
}

@immutable
class AutoActionDataSource extends ViewDataSource {
  /// 事件列表
  final List<DeriveEvent> eventList;

  const AutoActionDataSource({required this.eventList});
}

/// 逻辑
class AutoActionLogic extends ViewLogic<AutoActionArgs, AutoActionDataSource> {
  /// 事件服务
  final DeriveEventService _deriveEventService = DeriveEventService.instance;
  final EventConfigService _eventConfigService = EventConfigService.instance;

  /// 状态服务
  final StatusService _statusService = StatusService.instance;

  /// 事件配置
  EventConfig eventConfig = EventConfig();

  /// 当前事件
  DeriveEvent? event;
  Map<String, Object?>? eventMap;

  /// 所有状态列表
  List<Status> statusList = [];

  Rx<int> eventUpdateFlag = 0.obs;
  Rx<int> statusUpdateFlag = 0.obs;
  Rx<int> configUpdateFlag = 0.obs;

  SwipableStackController controller = SwipableStackController();

  /// 打开回调
  @override
  void afterArgsUpdate() async {
    controller = SwipableStackController();
    eventUpdateFlag.value = 0;
    statusUpdateFlag.value = 0;
    configUpdateFlag.value = 0;
    eventConfig = await _eventConfigService.find();
    configUpdateFlag.value++;
    statusList = await _statusService.find();
    statusUpdateFlag.value++;
    event = dataSource.eventList.isEmpty ? null : dataSource.eventList.first;
    eventMap = event == null ? null : await _deriveEventService.convertToMap(event!);
    eventUpdateFlag.value++;
  }

  /// 检查是否被删除
  Future<bool> checkRemoved() async {
    if (event?.isDelete.value != true) return false;
    await showCupertinoDialog<bool>(
      context: Get.context!,
      builder: (context) {
        return const CupertinoAlertDialog(
          title: Text("提示"),
          content: Text("该事件已被删除!"),
          actions: <Widget>[CupertinoDialogAction(child: Text("确认"), onPressed: RouteHelper.back)],
        );
      },
    );
    return true;
  }

  /// 状态变更
  void doAction(Status status) async {
    showOverlay();
    await _deriveEventService.doAction(event!, status);
    RouteHelper.toast(msg: "${event.toString()}状态修改成功");
    closeOverlay();
  }

  @override
  List<Widget> get overlayContent {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return [
      SpinKitCircle(color: themeData.defaultTextColor),
      const Text("保存中"),
    ];
  }

  /// 下一个事件
  void nextEvent(int currentIndex) async {
    int nextIndex = currentIndex + 1;
    event = nextIndex >= dataSource.eventList.length ? null : dataSource.eventList[nextIndex];
    // 检查这个事件是否被删除
    bool isRemoved = await checkRemoved();
    if (isRemoved) controller.next(swipeDirection: SwipeDirection.up);
    eventMap = event == null ? null : await _deriveEventService.convertToMap(event!);
    eventUpdateFlag.value++;
  }
}

/// 事件状态自动处理页面
class AutoAction extends View<AutoActionLogic> {
  AutoAction({
    required String key,
    required AutoActionArgs args,
    required AutoActionDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: AutoActionLogic());

  @override
  Widget buildView(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 350,
        clipBehavior: Clip.none,
        child: Neumorphic(
          padding: const EdgeInsets.only(top: 6),
          child: buildAutoAction(),
        ),
      ),
    );
  }

  Widget buildAutoAction() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(),
            const Spacer(),
            SizedBox(height: 160, child: buildStatus()),
          ],
        ),
        const Positioned(child: Center(child: Text("到底了")), top: 60),
        SwipableStack(
          itemCount: logic.dataSource.eventList.length,
          controller: logic.controller,
          builder: (context, properties) {
            int index = properties.index;
            DeriveEvent event = logic.dataSource.eventList[index];
            return Container(
              constraints: const BoxConstraints(minHeight: kToolbarHeight, maxHeight: 120),
              margin: const EdgeInsets.only(top: 45, left: 12, right: 12),
              child: buildEvent(event),
            );
          },
          onSwipeCompleted: (index, direction) => logic.nextEvent(index),
        ),
      ],
    );
  }

  Widget buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        HgNeumorphicText("事件状态修改"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const HgNeumorphicBackButton(onPressed: RouteHelper.back), Container()],
        ),
      ],
    );
  }

  /// 构建事件
  Widget buildEvent(DeriveEvent event) {
    return FadeInLeft(
      child: Container(
        clipBehavior: Clip.none,
        margin: const EdgeInsets.all(6),
        child: ActionCard<DeriveEvent>(
          key: "${logic.key}_${event.id.value}",
          args: ActionCardArgs<DeriveEvent>(state: PageState.browse, onTap: (event) => toDetail(event)),
          dataSource: ActionCardDataSource<DeriveEvent>(event: event, config: logic.eventConfig),
        ),
      ),
    );
  }

  /// 构建状态
  Widget buildStatus() {
    return Obx(() {
      int statusUpdateFlag = logic.statusUpdateFlag.value;
      debugPrint("状态列表更新次数:$statusUpdateFlag");
      int eventUpdateFlag = logic.eventUpdateFlag.value;
      debugPrint("事件更新次数:$eventUpdateFlag");
      DeriveEvent? event = logic.event;
      if (null == event) return Container();
      return SlideInLeft(
        child: Column(
          children: [
            Expanded(child: buildMatchesStatus()),
            const Padding(padding: EdgeInsets.only(top: 6)),
            Expanded(child: buildAllStatus()),
          ],
        ),
      );
    });
  }

  /// 构建推荐状态
  Widget buildMatchesStatus() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    // 有处理条件的状态
    List<Status> needAutoStatusList = logic.statusList.where((status) {
      GroupFilter? groupFilter = status.getFilter(eventType: DeriveEvent);
      if (groupFilter == null) return false;
      return groupFilter.isMatch(logic.eventMap!);
    }).toList();
    return SnappingSheet.horizontal(
      grabbing: Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
            const BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          depth: -themeData.depth,
        ),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: needAutoStatusList.isEmpty
                    ? Center(child: Text("没有匹配状态", style: TextStyle(color: themeData.disabledColor)))
                    : buildStatusList(needAutoStatusList),
              ),
              SizedBox(
                width: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("匹配\n状态"),
                    Neumorphic(child: Container(height: 40, width: 5, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      lockOverflowDrag: true,
      snappingPositions: const [
        SnappingPosition.pixels(positionPixels: 70, grabbingContentOffset: GrabbingContentOffset.bottom),
        SnappingPosition.factor(positionFactor: 1.0, grabbingContentOffset: GrabbingContentOffset.bottom),
      ],
      initialSnappingPosition: const SnappingPosition.factor(positionFactor: 1.0, grabbingContentOffset: GrabbingContentOffset.bottom),
      grabbingWidth: Get.width - 24,
    );
  }

  /// 状态列表
  Widget buildAllStatus() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return SnappingSheet.horizontal(
      grabbing: Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
            const BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          depth: -themeData.depth,
        ),
        child: Center(
          child: Row(
            children: [
              Expanded(child: buildStatusList(logic.statusList)),
              SizedBox(
                width: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [const Text("全部\n状态"), Neumorphic(child: Container(height: 40, width: 5, color: Colors.grey))],
                ),
              ),
            ],
          ),
        ),
      ),
      lockOverflowDrag: true,
      snappingPositions: const [
        SnappingPosition.pixels(positionPixels: 70, grabbingContentOffset: GrabbingContentOffset.bottom),
        SnappingPosition.factor(positionFactor: 1.0, grabbingContentOffset: GrabbingContentOffset.bottom),
      ],
      grabbingWidth: Get.width - 24,
    );
  }

  /// 构建状态列表
  Widget buildStatusList(List<Status> statusList) {
    Status? eventStatus = logic.event!.status.value;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Status status = statusList[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Column(
            children: [
              const Spacer(),
              // 标签图标
              HgNeumorphicButton(
                style: NeumorphicStyle(
                  depth: eventStatus?.id.value == status.id.value ? -themeData.depth : themeData.depth,
                  border: eventStatus?.id.value == status.id.value ? const NeumorphicBorder() : const NeumorphicBorder.none(),
                ),
                padding: EdgeInsets.zero,
                child: Logo(iconValue: status.icon.value),
                onPressed: () => logic.doAction(status),
              ),
              // 标签名称
              Container(
                padding: const EdgeInsets.only(top: 4),
                alignment: Alignment.center,
                child: Text(status.toString()),
              ),
              const Spacer(),
            ],
          ),
        );
      },
      itemCount: statusList.length,
    );
  }

  /// 详情
  void toDetail(DeriveEvent event) {
    int id = "event_auto_action_detail".hashCode;
    RouteHelper.back();
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId ?? MainLogic.instance.navigatorId,
      nestedId: id,
      page: DeriveEventDetail(
        key: event.id.value,
        args: EventDetailArgs(
          state: PageState.browse,
          parentNavigatorId: logic.args.navigatorId ?? MainLogic.instance.navigatorId,
          navigatorId: id,
          onBack: () {
            /// TODO 测试
            RouteHelper.back();
          },
        ),
        dataSource: EventDetailDataSource(event: event, config: logic.eventConfig),
      ),
    );
  }
}

/// 打开快速修改状态页面
Future<void> showEventAutoAction(List<DeriveEvent> eventList, {int? navigatorId}) async {
  return await Get.dialog(
    AutoAction(
      key: "auto_action",
      args: AutoActionArgs(navigatorId: navigatorId),
      dataSource: AutoActionDataSource(eventList: eventList),
    ),
    barrierDismissible: false,
  );
}
