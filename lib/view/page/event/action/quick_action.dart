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

import '../detail/detail_derive.dart';
import '../detail/detail_event.dart';
import 'action_card.dart';

/// 外部参数
@immutable
class QuickActionArgs extends ViewArgs {
  /// 导航id
  final int? navigatorId;

  const QuickActionArgs({this.navigatorId});
}

/// 外部数据
@immutable
class QuickActionDataSource extends ViewDataSource {
  /// 事件
  final DeriveEvent? event;

  /// 事件id
  final String? eventId;

  const QuickActionDataSource({
    this.event,
    this.eventId,
  }) : assert(event != null || eventId != null);
}

/// 逻辑
class QuickActionLogic extends ViewLogic<QuickActionArgs, QuickActionDataSource> {
  /// 事件服务
  final DeriveEventService _deriveEventService = DeriveEventService.instance;
  final EventConfigService _eventConfigService = EventConfigService.instance;

  /// 状态服务
  final StatusService _statusService = StatusService.instance;

  /// 事件
  DeriveEvent? event;
  Map<String, Object?>? eventMap;

  /// 事件配置
  EventConfig eventConfig = EventConfig();

  /// 所有状态列表
  List<Status> statusList = [];

  Rx<int> eventUpdateFlag = 0.obs;
  Rx<int> statusUpdateFlag = 0.obs;
  Rx<int> configUpdateFlag = 0.obs;

  /// 打开回调
  @override
  void afterArgsUpdate() async {
    eventUpdateFlag.value = 0;
    statusUpdateFlag.value = 0;
    configUpdateFlag.value = 0;
    if (null == dataSource.event) {
      event = await _deriveEventService.findById(dataSource.eventId!);
    } else {
      event = dataSource.event;
    }
    bool isRemoved = await checkRemoved();
    if (isRemoved) return;
    eventMap = event == null ? null : await _deriveEventService.convertToMap(event!);
    eventUpdateFlag.value++;
    await findStatusList();
    eventConfig = await _eventConfigService.find();
    configUpdateFlag.value++;
  }

  /// 检查是否被删除
  Future<bool> checkRemoved() async {
    if (event != null && event!.isDelete.value == false) return false;
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
    RouteHelper.back();
    return true;
  }

  /// 查询所有状态
  Future<void> findStatusList() async {
    if (statusList.isNotEmpty) return;
    statusList = await _statusService.find();
    statusUpdateFlag.value++;
  }

  /// 状态变更
  void doAction(Status status) async {
    if (null == event) return;
    showOverlay();
    await _deriveEventService.doAction(event!, status);
    RouteHelper.toast(msg: "${event.toString()}状态修改成功");
    closeOverlay();
    RouteHelper.back();
  }

  @override
  List<Widget> get overlayContent {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return [
      SpinKitCircle(color: themeData.defaultTextColor),
      const Text("保存中"),
    ];
  }
}

/// 快速选择事件状态
class QuickAction extends View<QuickActionLogic> {
  QuickAction({
    String? key,
    required QuickActionArgs args,
    required QuickActionDataSource dataSource,
  }) : super(key: _getKey(key, dataSource), args: args, dataSource: dataSource, newLogic: QuickActionLogic());

  static String _getKey(String? key, QuickActionDataSource dataSource) {
    return (key ?? dataSource.event?.id.value ?? dataSource.eventId)!;
  }

  @override
  Widget buildView(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 350,
        clipBehavior: Clip.none,
        child: Neumorphic(
          padding: const EdgeInsets.only(top: 6),
          child: buildQuickAction(),
        ),
      ),
    );
  }

  Widget buildQuickAction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 0, child: buildHeader()),
        Expanded(
          flex: 0,
          child: Container(
            margin: const EdgeInsets.all(12),
            child: buildEvent(),
          ),
        ),
        Expanded(child: Container()),
        Expanded(flex: 0, child: SizedBox(height: 160, child: buildStatus())),
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
  Widget buildEvent() {
    return Obx(() {
      int eventUpdateFlag = logic.eventUpdateFlag.value;
      debugPrint("事件更新次数:$eventUpdateFlag");
      int configUpdateFlag = logic.configUpdateFlag.value;
      debugPrint("事件配置更新次数:$configUpdateFlag");
      DeriveEvent? event = logic.event;
      if (null == event) return Container();
      return FadeInLeft(
        child: ActionCard<DeriveEvent>(
          key: "${logic.key}_${event.id.value}",
          args: ActionCardArgs<DeriveEvent>(state: PageState.browse, onTap: (event) => toDetail(event)),
          dataSource: ActionCardDataSource<DeriveEvent>(event: event, config: logic.eventConfig),
        ),
      );
    });
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
      return groupFilter.isMatch(logic.eventMap ?? {});
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
    int id = "event_quick_action_detail".hashCode;
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
            Get.dialog(
              QuickAction(key: 'quick_action', args: logic.args, dataSource: logic.dataSource),
              barrierDismissible: false,
            );
          },
        ),
        dataSource: EventDetailDataSource(event: event, config: logic.eventConfig),
      ),
    );
  }
}

/// 打开快速修改状态页面
Future<void> showEventQuickAction(DeriveEvent event, {int? navigatorId}) async {
  return await Get.dialog(
    QuickAction(
      key: 'quick_action',
      args: QuickActionArgs(navigatorId: navigatorId),
      dataSource: QuickActionDataSource(event: event),
    ),
    barrierDismissible: false,
  );
}

/// 根据id打开快速修改状态页面
Future<void> showEventQuickActionById(String eventId, {int? navigatorId}) async {
  return await Get.dialog(
    QuickAction(
      key: 'quick_action',
      args: QuickActionArgs(navigatorId: navigatorId),
      dataSource: QuickActionDataSource(eventId: eventId),
    ),
    barrierDismissible: false,
  );
}
