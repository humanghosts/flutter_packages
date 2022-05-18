import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/util/string_util.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/event/detail/detail_origin.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../card/card.dart';
import '../detail/detail_event.dart';
import '../detail/quick_add.dart';
import '../settings/settings.dart';
import '../tag/tag.dart';

/// 外部参数
@immutable
class OriginEventListArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  const OriginEventListArgs({required this.navigatorId});
}

/// 逻辑
class OriginEventListLogic extends OriginEventLogic<OriginEventListArgs, ViewDataSource> {
  /// 下拉刷新控制器
  final RefreshController refreshController = RefreshController();

  /// 列表滚动控制器
  final ScrollController listController = ScrollController();

  /// 卡片动画控制器
  final Map<String, AnimationController> cardController = {};

  /// 活跃的标签
  Tag? activeTag;

  /// 新增的事件，避免频繁搜索
  List<OriginEvent> newEventList = [];

  /// 列表分组事件 key是属性id
  /// 如果分组属性为空，是{null:[event]}
  Map<String?, List<OriginEvent>> groupEvent = {};

  /// 分组属性 key是属性id
  /// 如果属性为空，这里放[null:null]
  Map<String?, EventAttribute?> groupEntity = {};

  /// 列表更新标识
  Rx<int> listUpdateFlag = 0.obs;

  Rx<int> tagUpdateFlag = 0.obs;

  @override
  void onReady() async {
    await findConfig();
    setActiveTag(config.tagList.isNull ? null : config.tagList.first);
  }

  @override
  void afterArgsUpdate() {
    super.afterArgsUpdate();
    findConfig();
    listUpdateFlag.value = 0;
    tagUpdateFlag.value = 0;
  }

  @override
  void onWidgetInitState(BuildContext context, GetBuilderState<GetxController> state) {
    super.onWidgetInitState(context, state);
    refreshList();
  }

  /// 保存配置
  void saveConfig(EventConfig config) async {
    await originService.saveConfig(config);
    this.config = config;
    group();
  }

  /// 保存标签列表
  void onTagListUpdate(EventConfig config) async {
    await configService.save(config);
    this.config = config;
    tagUpdateFlag.value++;
    List<Tag> tagList = this.config.tagList.value;
    // 判断当前活跃标签是否还在列表中
    int index = tagList.indexWhere((tag) => tag.id.value == activeTag?.id.value);
    if (index < 0) {
      // 设置保存后的活跃标签
      setActiveTag(tagList.isNotEmpty ? tagList.first : null);
    }
  }

  /// 刷新列表
  void refreshList() => find();

  /// 刷新成功 更新页面
  void refreshEndAndUpdate() {
    refreshController.refreshCompleted();
    listUpdateFlag.value++;
  }

  /// 通过选中的标签查找事件，没有选中的标签，查找所有事件
  Future<void> find() async {
    // 清空原来的数据
    eventList.clear();
    groupEvent.clear();
    newEventList.clear();
    groupEntity.clear();
    cardController.clear();
    // 如果没有选中的标签，结束
    if (activeTag == null) return refreshEndAndUpdate();
    // 根据标签查询源事件
    List<OriginEvent> recordTree = await originService.findTreeByTag(activeTag!);
    Set<String> originIdSet = originService.dao.treeToList(recordTree).map((e) => e.id.value).toSet();
    // 根据标签查询日程事件
    List<DeriveEvent> deriveList = await deriveService.findListByTag(activeTag!);
    // 符合的源事件
    for (DeriveEvent derive in deriveList) {
      OriginEvent? origin = derive.origin.value;
      if (origin == null) continue;
      if (originIdSet.contains(origin.id.value)) continue;
      originIdSet.add(origin.id.value);
      recordTree.add(origin);
    }
    // 没有事件结束
    if (recordTree.isEmpty) return refreshEndAndUpdate();
    // 更新
    eventList.addAll(recordTree);
    // 不分组直接返回
    group();
  }

  /// 事件分组
  void group() {
    // 清空分组信息
    groupEvent.clear();
    groupEntity.clear();
    // 不分组 结束
    if (config.groupField.value == null) return refreshEndAndUpdate();
    // 事件分组
    for (OriginEvent event in eventList) {
      // 分组属性
      Attribute groupAttribute = event.attributes.get(config.groupField.value)!;
      // 分组值
      EventAttribute? value = groupAttribute.value;
      // 值id
      String? id = value?.id.value;
      List<OriginEvent> groupEventList = groupEvent.putIfAbsent(id, () => <OriginEvent>[]);
      groupEventList.add(event);
      groupEntity.putIfAbsent(id, () => value);
    }
    refreshEndAndUpdate();
  }

  /// 修改选中标签
  void setActiveTag(Tag? tag) async {
    if (tag?.id.value == activeTag?.id.value) return;
    activeTag = tag;
    tagUpdateFlag.value++;
    refreshList();
  }

  /// 新增源事件
  Future<void> add(OriginEvent newOrigin) async {
    await originService.save(newOrigin);
    newEventList.add(newOrigin);
    listUpdateFlag.value++;
  }

  @override
  void afterRemove(OriginEvent event) {
    eventList.removeWhere((e) => e.id.value == event.id.value);
    newEventList.removeWhere((e) => e.id.value == event.id.value);
    cardController[event.id.value]?.reverse();
    Future.delayed(AppConfig.animationConfig.middleAnimationDuration, () {
      refreshList();
    });
  }

  /// 检查是否满足标签过滤条件
  @override
  void afterAction(OriginEvent event, Status action) {
    checkEventIsMatchTag(event, isMatchCallBack: (isMatch) {
      if (!isMatch) {
        // 都不符合 删除
        cardController[event.id.value]?.reverse();
        eventList.removeWhere((element) => element.id.value == event.id.value);
      }
      refreshList();
    });
  }

  /// 详情页返回操作
  void onDetailBack(OriginEvent event, PageState state) async {
    if (state == PageState.add) return;
    bool isRemoved = event.isDelete.value;
    if (isRemoved) {
      cardController[event.id.value]?.reverse();
      eventList.removeWhere((element) => element.id.value == event.id.value);
      return refreshList();
    }
    checkEventIsMatchTag(event, isMatchCallBack: (isMatch) {
      if (!isMatch) {
        // 都不符合 删除
        cardController[event.id.value]?.reverse();
        eventList.removeWhere((element) => element.id.value == event.id.value);
      }
      refreshList();
    });
  }

  /// 详情页返回操作
  void onDetailAdd(OriginEvent event) async {
    newEventList.add(event);
    listUpdateFlag.value++;
  }

  /// 日程事件的父事件 检查事件是否符合标签
  void checkEventIsMatchTag(OriginEvent event, {ValueChanged<bool>? isMatchCallBack}) async {
    // 检查源事件
    if (activeTag == null) return isMatchCallBack?.call(true);
    // 标签的过滤条件
    GroupFilter? originFilter = activeTag!.getFilter(eventType: OriginEvent);
    // 标签的主键条件
    String tagId = activeTag!.id.value;
    Filter tagIdFilter = SingleFilter.containsOne(field: Event.tagListKey, value: [tagId]);
    // 两个条件或，标签是这个的或者符合这个标签过滤要求的
    List<Filter> subFilters = [tagIdFilter];
    if (originFilter != null) subFilters.add(originFilter);
    GroupFilter filter;
    if (activeTag!.isAndFilter.value) {
      filter = GroupFilter.and(subFilters);
    } else {
      filter = GroupFilter.or(subFilters);
    }
    Map<String, Object?>? record = await originService.convertToMap(event);
    if (null == record) return isMatchCallBack?.call(true);
    bool isMatch = filter.isMatch(record);
    if (isMatch) return isMatchCallBack?.call(true);
    // 检查日程
    List<DeriveEvent> deriveList = await deriveService.findByOriginId(event.id.value);
    if (deriveList.isNotEmpty) {
      GroupFilter? deriveFilter = activeTag!.getFilter(eventType: DeriveEvent);
      subFilters = [tagIdFilter];
      if (deriveFilter != null) subFilters.add(deriveFilter);
      if (activeTag!.isAndFilter.value) {
        filter = GroupFilter.and(subFilters);
      } else {
        filter = GroupFilter.or(subFilters);
      }
      for (DeriveEvent derive in deriveList) {
        Map<String, Object?>? deriveRecord = await deriveService.convertToMap(derive);
        if (null == deriveRecord) continue;
        bool isDeriveMatch = filter.isMatch(deriveRecord);
        // 有一个符合即可
        if (isDeriveMatch) return isMatchCallBack?.call(true);
      }
    }
    return isMatchCallBack?.call(false);
  }

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "tag_row",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("标签栏，\n点击选择标签可快速检索事件，"
              "\n左右滑动可翻页,"
              "\n向下滑动可添加或删除标签，或对标签进行排序"),
        ),
      ],
    );
    // 事件列表位置和大小计算，屏幕大小剪去标签页大小，计算的原因是用户再次启动引导的时候，标签页可能为1行
    // 高度固定会有bug
    addTutorialTargetKey(1, "list");
    GlobalKey globalKey = getTutorialTargetKey("tag_row")!;
    RenderBox renderObject = globalKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderObject.size;
    Offset offset = renderObject.localToGlobal(Offset.zero);
    buildAndAddTargetFocus(
      "list",
      targetPosition: TargetPosition(
        Size(Get.width - 12, Get.height - (size.height + offset.dy + 12)),
        Offset(offset.dx, (size.height + offset.dy + 12)),
      ),
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("事件列表，\n用于显示通过标签检索到的事件，"
              "\n 点击事件可进行编辑"
              "\n 左右滑动可修改事件状态或删除事件"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "settings_button",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("设置按钮，\n点击可对事件相关进行设置"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "add_button",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("新增按钮，\n点击可快速添加新事件"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "origin_list";
}

/// 页面
class OriginEventList extends View<OriginEventListLogic> {
  OriginEventList({
    required String key,
    required OriginEventListArgs args,
  }) : super(key: key, args: args, newLogic: OriginEventListLogic());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      key: getWidgetKey(HgNeumorphicScaffold),
      settingsButtonKey: logic.addTutorialTargetKey(2, "settings_button"),
      onSettings: toSettings,
      addButtonKey: logic.addTutorialTargetKey(3, "add_button"),
      onAdd: quickAdd,
      bodyPadding: EdgeInsets.zero,
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          key: getWidgetKey(CustomScrollView),
          controller: logic.listController,
          clipBehavior: Clip.none,
          body: SmartRefresher(
            key: getWidgetKey(SmartRefresher),
            controller: logic.refreshController,
            child: buildEvent(),
            onRefresh: () {
              HapticFeedback.lightImpact();
              logic.find();
            },
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [buildTagRow()];
          },
        ),
      ),
    );
  }

  /// 构建标签
  Widget buildTagRow() {
    return Obx(() {
      debugPrint("标签更新次数:${logic.tagUpdateFlag.value}，标签数量：${logic.config.tagList.value.length}");
      return TagRow(
        key: logic.key,
        args: TagRowArgs(
          onActive: logic.setActiveTag,
          navigatorId: logic.args.navigatorId,
          tutorialKey: logic.addTutorialTargetKey(0, "tag_row"),
          onTagListChange: logic.onTagListUpdate,
        ),
        dataSource: TagRowDataSource(config: logic.config, activeTag: logic.activeTag),
      );
    });
  }

  /// 构建事件
  Widget buildEvent() {
    return Obx(() {
      debugPrint("列表更新次数:${logic.listUpdateFlag.value}");
      if (logic.eventList.isEmpty && logic.newEventList.isEmpty) return buildEmpty();
      if (null == logic.config.groupField.value) {
        return buildSingleList();
      } else {
        return buildGroupList();
      }
    });
  }

  /// 事件为空
  Widget buildEmpty() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Center(child: Text("无事发生", style: TextStyle(color: themeData.disabledColor.withOpacity(0.3), fontSize: 20)));
  }

  /// 不分组
  Widget buildSingleList() {
    List<_OriginListItem> listItems = [];
    if (logic.newEventList.isNotEmpty) {
      listItems.add(_OriginListItem(_OriginListItemType.title, "新增"));
      for (OriginEvent event in logic.newEventList) {
        listItems.add(_OriginListItem(_OriginListItemType.event, event));
      }
    }
    listItems.add(_OriginListItem(_OriginListItemType.padding, null));
    for (OriginEvent event in logic.eventList) {
      listItems.add(_OriginListItem(_OriginListItemType.event, event));
    }
    return buildList(listItems);
  }

  /// 分组
  Widget buildGroupList() {
    // 分组列表
    Map<String?, List<OriginEvent>> groupList = logic.groupEvent;
    // 分组属性
    Map<String?, EventAttribute?> groupEntity = logic.groupEntity;
    // 分组属性排序 null排到最后
    List<EventAttribute?> eaList = groupEntity.values.toList();
    eaList.sort((a, b) {
      if (null == a && b == null) return 0;
      if (a == null) return 1;
      if (b == null) return 0;
      if (a is Priority) {
        return (b as Priority).weight.value - a.weight.value;
      } else {
        return StringUtils.compare(a.name.value, b.name.value);
      }
    });
    List<_OriginListItem> listItems = [];
    if (logic.newEventList.isNotEmpty) {
      listItems.add(_OriginListItem(_OriginListItemType.title, "新增"));
      for (OriginEvent event in logic.newEventList) {
        listItems.add(_OriginListItem(_OriginListItemType.event, event));
      }
    }
    // 排序后的分组组id
    List<String?> orderKeyList = eaList.map((e) => e?.id.value).toList();
    for (int index = 0; index < orderKeyList.length; index++) {
      // 分组id
      String? key = groupList.keys.toList()[index];
      // 分组事件
      List<OriginEvent>? eventList = groupList[key];
      if (eventList == null || eventList.isEmpty) continue;
      // 标题名称
      EventAttribute? ea = groupEntity[key];
      String nullTitle = "无";
      if (logic.config.groupField.value == Event.statusKey) {
        nullTitle = "无状态";
      } else if (logic.config.groupField.value == Event.priorityKey) {
        nullTitle = "无优先级";
      }
      listItems.add(_OriginListItem(_OriginListItemType.title, ea == null ? nullTitle : ea.toString()));
      for (OriginEvent event in eventList) {
        listItems.add(_OriginListItem(_OriginListItemType.event, event));
      }
    }
    return buildList(listItems);
  }

  /// 事件列表
  Widget buildList(List<_OriginListItem> listItems) {
    List<Widget> children = listItems.map((listItem) {
      _OriginListItemType itemType = listItem.type;
      Object? itemValue = listItem.value;
      switch (itemType) {
        case _OriginListItemType.title:
          return Padding(padding: const EdgeInsets.only(top: 16, bottom: 8), child: Text(itemValue as String));
        case _OriginListItemType.event:
          return buildEventCard(itemValue as OriginEvent);
        case _OriginListItemType.padding:
          return const Padding(padding: EdgeInsets.only(top: 16));
      }
    }).toList();
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.5, left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  /// 事件项
  Widget buildEventCard(OriginEvent event) {
    return FadeInLeft(
      key: getWidgetKey(FadeInLeft, "${event.id.value}_${logic.activeTag?.id.value}"),
      duration: AppConfig.animationConfig.middleAnimationDuration,
      controller: (controller) => logic.cardController[event.id.value] = controller,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: EventCard<OriginEvent>(
          key: event.id.value,
          args: EventCardArgs<OriginEvent>(
            onTap: (event) => toDetail(event, PageState.edit),
            canRemove: logic.canRemove,
            onRemove: logic.remove,
            onAction: logic.doAction,
            state: PageState.edit,
          ),
          dataSource: EventCardDataSource<OriginEvent>(event: event, config: logic.config),
        ),
      ),
    );
  }

  /// 快速新增
  void quickAdd() {
    // 新建源事件
    OriginEvent origin = OriginEvent();
    // 设置初始标签
    if (logic.activeTag != null) origin.tagList.add(logic.activeTag!);
    RouteHelper.bottomSheet(
      sheet: EventQuickAdd<OriginEvent>(
        key: origin.id.value,
        args: EventQuickAddArgs(
          onFullScreen: (event) => toDetail(event, PageState.add, onDone: () => logic.onDetailAdd(origin)),
          navigatorId: logic.args.navigatorId,
          onDone: (event) => logic.add(event),
        ),
        dataSource: EventQuickAddDataSource(event: origin, config: logic.config),
      ),
    );
  }

  /// 派生事件详情
  /// 如果是唯一派生，打开源事件编辑
  void toDetail(OriginEvent event, PageState state, {VoidCallback? onDone, VoidCallback? onBack}) {
    debugPrint(logic.listController.offset.toString());
    debugPrint(logic.refreshController.position.toString());
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: event.id.value.hashCode,
      page: OriginEventDetail(
        key: event.id.value,
        args: EventDetailArgs(
          parentNavigatorId: logic.args.navigatorId,
          state: state,
          navigatorId: event.id.value.hashCode,
          onBack: onBack ?? () => logic.onDetailBack(event, state),
          onDone: onDone ?? () => logic.onDetailBack(event, state),
        ),
        dataSource: EventDetailDataSource(event: event, config: logic.config),
      ),
    );
  }

  /// 打开设置页面
  void toSettings() {
    int id = "event_settings".hashCode;
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: id,
      page: EventSettings(
        key: "event_settings",
        args: EventSettingsArgs(
          parentNavigatorId: logic.args.navigatorId,
          navigatorId: id,
          onDone: logic.saveConfig,
        ),
        dataSource: EventSettingsDataSource(config: logic.config.clone() as EventConfig),
      ),
    );
  }
}

enum _OriginListItemType {
  title,
  padding,
  event,
}

class _OriginListItem {
  final _OriginListItemType type;
  final Object? value;

  _OriginListItem(this.type, this.value);
}
