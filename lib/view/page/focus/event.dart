import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../event/detail/detail_derive.dart';
import '../event/detail/detail_event.dart';
import 'event_card.dart';

/// 外部参数
@immutable
class EventSelectorArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 事件选择回调
  final ValueChanged<DeriveEvent?>? onSelected;

  final FocusHomeLogic focusLogic;

  const EventSelectorArgs({
    required this.navigatorId,
    this.onSelected,
    required this.focusLogic,
  });
}

@immutable
class EventSelectorDataSource extends ViewDataSource {
  final DeriveEvent? event;

  const EventSelectorDataSource({this.event});
}

/// 逻辑
class EventSelectorLogic extends ViewLogic<EventSelectorArgs, EventSelectorDataSource> {
  /// 事件
  DeriveEvent? event;

  /// 事件配置
  EventConfig config = EventConfig();

  /// 事件服务
  static final DeriveEventService _eventService = DeriveEventService.instance;

  /// 下拉刷新控制器
  RefreshController refreshController = RefreshController();

  Rx<int> eventUpdateFlag = 0.obs;
  Rx<int> configUpdateFlag = 0.obs;

  /// 打开回调
  @override
  void afterArgsUpdate() async {
    refreshController = RefreshController();
    if (null != dataSource.event) event = dataSource.event;
    eventUpdateFlag.value = 0;
    configUpdateFlag.value = 0;
    config = await _eventService.findConfig();
    configUpdateFlag.value++;
  }

  /// 事件选择
  void onEventSelect(DeriveEvent? event) {
    this.event = event;
    eventUpdateFlag.value++;
    args.onSelected?.call(event);
  }
}

/// 事件选择
class EventSelector extends View<EventSelectorLogic> {
  EventSelector({required String key, required EventSelectorArgs args, required EventSelectorDataSource dataSource})
      : super(
          key: key,
          args: args,
          dataSource: dataSource,
          newLogic: EventSelectorLogic(),
        );

  @override
  Widget buildView(BuildContext context) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(
      () => HgNeumorphicButton(
        padding: EdgeInsets.zero,
        style: NeumorphicStyle(
          depth: logic.args.focusLogic.focusState.value == FocusState.stop ? themeData.depth : -themeData.depth,
          border: logic.args.focusLogic.focusState.value == FocusState.stop && themeData.depth > 0 ? const NeumorphicBorder.none() : const NeumorphicBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              int configUpdateFlag = logic.configUpdateFlag.value;
              int eventUpdateFlag = logic.eventUpdateFlag.value;
              debugPrint("专注事件配置更新次数:$configUpdateFlag");
              debugPrint("专注事件更新次数:$eventUpdateFlag");
              return buildEvent(logic.event);
            }),
            HgNeumorphicNextButton(onPressed: logic.args.focusLogic.focusState.value == FocusState.stop ? eventSelect : null),
          ],
        ),
        onPressed: eventSelect,
      ),
    );
  }

  /// 事件
  Widget buildEvent(DeriveEvent? event) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    if (null == event) {
      return Container(
        constraints: const BoxConstraints(minHeight: kToolbarHeight),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Center(child: Text("选择事件", style: TextStyle(color: themeData.disabledColor))),
      );
    }
    return Expanded(
      child: FocusCard<DeriveEvent>(
        key: logic.key + event.id.value,
        args: FocusCardArgs(
          onTap: logic.args.focusLogic.focusState.value == FocusState.stop ? toDetail : null,
          state: PageState.browse,
          style: NeumorphicStyle(depth: min(1, themeData.depth)),
        ),
        dataSource: FocusCardDataSource(event: event, config: logic.config),
      ),
    );
  }

  /// 构建事件选择
  void eventSelect() async {
    if (logic.args.focusLogic.focusState.value != FocusState.stop) return;
    int navigatorId = "focus_event_select".hashCode;
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: navigatorId,
      page: EventList(
        key: "focus_event_select",
        args: EventListArgs(
          navigatorId: navigatorId,
          parentNavigatorId: logic.args.navigatorId,
          onBack: logic.onEventSelect,
        ),
        dataSource: EventListDataSource(selected: logic.event),
      ),
    );
  }

  /// 详情
  void toDetail(DeriveEvent event) {
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: "focus_event_detail".hashCode,
      page: DeriveEventDetail(
        key: event.id.value,
        args: EventDetailArgs(
          parentNavigatorId: logic.args.navigatorId,
          state: PageState.browse,
          navigatorId: "focus_event_detail".hashCode,
        ),
        dataSource: EventDetailDataSource(event: event, config: logic.config),
      ),
    );
  }
}

/// 外部参数
@immutable
class EventListArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 上级导航id
  final int parentNavigatorId;

  /// 返回回调
  final ValueChanged<DeriveEvent?>? onBack;

  const EventListArgs({
    required this.navigatorId,
    required this.parentNavigatorId,
    this.onBack,
  });
}

@immutable
class EventListDataSource extends ViewDataSource {
  final DeriveEvent? selected;

  const EventListDataSource({this.selected});
}

/// 逻辑
class EventListLogic extends ViewLogic<EventListArgs, EventListDataSource> {
  Rx<int> listUpdateFlag = 0.obs;

  /// 所有事件
  List<DeriveEvent> eventList = [];

  DeriveEvent? event;

  /// 事件配置
  EventConfig config = EventConfig();

  /// 事件服务
  static final DeriveEventService _eventService = DeriveEventService.instance;

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
    event = dataSource.selected;
    findEventList();
  }

  /// 查询非完成状态的所有事件
  Future<void> findEventList() async {
    config = await _eventService.findConfig();
    List<String> endStatusIdList = config.endStatus.value.map((e) => e.id.value).toList();
    eventList = await _eventService.find(filter: SingleFilter.notInList(field: Event.statusKey, value: endStatusIdList));
    listUpdateFlag.value++;
    refreshController.refreshCompleted();
  }

  /// 事件选择
  void onEventSelect(DeriveEvent? event) {
    this.event = event;
    back();
    args.onBack?.call(event);
  }
}

/// 事件列表
class EventList extends View<EventListLogic> {
  EventList({
    required String key,
    required EventListArgs args,
    required EventListDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: EventListLogic());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      title: HgNeumorphicText("事件列表"),
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
        header: WaterDropHeader(
          refresh: SpinKitCircle(color: themeData.disabledColor),
          waterDropColor: themeData.disabledColor,
          complete: HgNeumorphicIcon(Icons.done, color: themeData.disabledColor),
        ),
        controller: logic.refreshController,
        child: buildEventList(),
        onRefresh: () {
          HapticFeedback.lightImpact();
          logic.findEventList();
        },
      ),
    );
  }

  /// 构建历史记录
  Widget buildEventList() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(() {
      int listUpdateFlag = logic.listUpdateFlag.value;
      debugPrint("专注历史列表更新次数：$listUpdateFlag");
      if (logic.eventList.isEmpty) {
        return Center(child: Text("无事件", style: TextStyle(color: themeData.disabledColor)));
      }
      return MultiSelect(
        key: "focus_event_select",
        args: MultiSelectArgs(
          title: "事件",
          navigatorId: logic.args.navigatorId,
          itemCount: logic.eventList.length,
          isMulti: false,
          canBeEmpty: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const ClampingScrollPhysics(),
          mode: MultiSelectMode.widget,
          rawItem: true,
          itemBuilder: (context, index, isSelect, action) {
            DeriveEvent event = logic.eventList[index];
            bool isSelected = event.id.value == logic.event?.id.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: FocusCard<DeriveEvent>(
                key: logic.key + event.id.value,
                args: FocusCardArgs(
                  state: PageState.browse,
                  onTap: (event) => logic.onEventSelect(isSelected ? null : event),
                  style: NeumorphicStyle(
                    depth: isSelected ? -themeData.depth : themeData.depth,
                    border: isSelected ? const NeumorphicBorder() : const NeumorphicBorder.none(),
                  ),
                ),
                dataSource: FocusCardDataSource(event: event, config: logic.config),
              ),
            );
          },
        ),
        dataSource: const MultiSelectDataSource(selected: []),
      );
    });
  }
}
