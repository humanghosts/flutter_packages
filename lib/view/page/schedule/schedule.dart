import 'package:animate_do/animate_do.dart';
import 'package:badges/badges.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../event/detail/detail_derive.dart';
import '../event/detail/detail_event.dart';
import '../event/detail/quick_add.dart';
import 'schedule_item.dart';
import 'settings.dart';

/// 逻辑
class ScheduleHomeLogic extends HomePageLogic {
  // ---- 日历时间属性 ----
  /// 月份，单独刷新
  Rx<DateTime> month = DateTime.now().obs;

  /// 日历开始日期
  DateTime start = DateTime.now();

  /// 日历结束日期
  DateTime end = DateTime.now();

  /// 初始日期
  Rx<DateTime> currentDate = DateTime.now().obs;

  /// 最早日期
  final DateTime firstDate = DateTime.fromMillisecondsSinceEpoch(0);

  /// 最晚日期
  final DateTime lastDate = DateTime(2050, 12, 31);

  /// 日历模式更新标识
  Rx<int> modeUpdateFlag = 0.obs;

  /// 当前日历状态
  CalendarMode mode = CalendarMode.week;

  /// 所有日历状态
  List<CalendarMode> modeList = [
    CalendarMode.week,
    CalendarMode.month,
  ];

  /// 日历状态图标
  Map<CalendarMode, IconData> modeIcon = {
    CalendarMode.week: Icons.view_week,
    CalendarMode.month: Icons.view_comfy,
  };

  // ---- 事件列表属性 ----
  /// 事件列表
  Map<String, DeriveEvent> eventMap = {};

  /// 展开的事件
  Set<String> expandedEvent = {};

  /// 日程设置
  ScheduleConfig config = ScheduleConfig();

  /// 事件设置
  EventConfig? eventConfig;

  /// 事件服务
  static final DeriveEventService _eventService = DeriveEventService.instance;

  /// 设置保存
  static final ScheduleConfigService _configService = ScheduleConfigService.instance;

  /// 当前活跃页面
  int activeIndex = 0;

  /// 页面切换控制器
  PageController pageController = PageController(initialPage: 0);

  /// 下拉刷新控制器
  RefreshController refreshController = RefreshController();

  /// 卡片的动画控制器
  final Map<String, AnimationController> cardController = {};
  final Map<String, AnimationController> itemController = {};
  final Map<String, AnimationController> statusController = {};

  /// 列表更新标识
  Rx<int> eventListUpdateFlag = 0.obs;

  /// 日期事件数量
  Map<int, Rx<int>> dateCount = {};

  @override
  void onWidgetInitState(BuildContext context, GetBuilderState<GetxController> state) async {
    super.onWidgetInitState(context, state);
    eventListUpdateFlag.value = 0;
    modeUpdateFlag.value = 0;
    activeIndex = getPageIndex();
    cardController.clear();
    statusController.clear();
    itemController.clear();
    dateCount.clear();
    pageController = PageController(initialPage: activeIndex);
    // 查询事件配置
    eventConfig = await _eventService.findConfig();
    config = await _configService.find();
    // 查询事件
    await findCurrentEventList();
  }

  /// 保存设置
  void saveConfig(ScheduleConfig config) async {
    await _configService.save(config);
    this.config = config;
    await _configService.sendNotice(config);
  }

  /// 获取页数
  int getPageIndex() {
    DateTime first = DateTime(firstDate.year, firstDate.month, firstDate.day);
    DateTime current = DateTime(currentDate.value.year, currentDate.value.month, currentDate.value.day);
    return current.difference(first).inDays;
  }

  /// 获取页面大小
  int getPageSize() {
    DateTime first = DateTime(firstDate.year, firstDate.month, firstDate.day);
    DateTime last = DateTime(lastDate.year, lastDate.month, lastDate.day);
    return last.difference(first).inDays;
  }

  /// 切换状态
  void changeMode() {
    int index = modeList.indexOf(mode);
    int nextIndex = (index + 1) % modeList.length;
    mode = modeList[nextIndex];
    modeUpdateFlag.value++;
  }

  /// 日期选择回调
  void onDateSelected(DateTime dateTime) {
    if (currentDate.value.isSameDay(dateTime)) return;
    currentDate.value = dateTime;
    activeIndex = getPageIndex();
    pageController.jumpToPage(activeIndex);
    if (!month.value.isSameMonth(dateTime)) month.value = dateTime;
    findCurrentEventList();
  }

  /// 日历翻页回调
  void onCalendarPageChange(DateTime start, DateTime end) {
    this.start = start;
    this.end = end;
    findCount(start, end);
    if (mode == CalendarMode.month) {
      if (month.value.isSameMonth(start)) return;
      month.value = start;
    } else {
      // 当前时间是否在本周
      int inDays = currentDate.value.difference(start).inDays;
      if (inDays < 0 || inDays > 6) {
        month.value = start;
      } else {
        month.value = currentDate.value;
      }
    }
  }

  /// 页面滑动回调
  void onPageChanged(int index) {
    if (index == activeIndex) return;
    DateTime dateTime = DateTime(firstDate.year, firstDate.month, firstDate.day + index);
    onDateSelected(dateTime);
    HapticFeedback.lightImpact();
  }

  /// 查找事件
  Future<void> findCurrentEventList() async {
    EventConfig? config = eventConfig;
    if (null == config) {
      config = await _eventService.findConfig();
      eventConfig = config;
    }
    // 当前时间
    FilterDateTime today = FilterDateTime(type: FilterDateTimeTypeEnum.custom, customDate: currentDate.value);
    // 用tag做过滤和排序
    Tag filterTag = Tag()
      ..sort.add(SortValue(sort: Sort(field: EventFilterField.startTiming.value)))
      ..filter.value = GroupFilterValue(
        filters: [
          // 1. 开始时间小于等于今天
          SingleFilterValue(filter: SingleFilter.lessThanOrEquals(field: EventFilterField.startTiming.value, value: today)),
          SingleFilterValue(filter: SingleFilter.notNull(field: EventFilterField.startTiming.value)),
          // 2. 结束事件大于等于今天或者为空
          GroupFilterValue(
            op: GroupFilterOp.or,
            filters: [
              SingleFilterValue(filter: SingleFilter.isNull(field: EventFilterField.endTiming.value)),
              SingleFilterValue(filter: SingleFilter.greaterThanOrEquals(field: EventFilterField.endTiming.value, value: today)),
            ],
          ),
        ],
      );
    eventMap.clear();
    Set<String> oldExpandedEvent = {...expandedEvent};
    expandedEvent.clear();
    List<DeriveEvent> eventList = await _eventService.findTreeByTag(filterTag);
    for (DeriveEvent event in eventList) {
      eventMap[event.id.value] = event;
      if (oldExpandedEvent.contains(event.id.value)) {
        expandedEvent.add(event.id.value);
        onEventExpanded(true, event);
      }
    }
    Set<String> endConfigIdSet = eventConfig!.endStatus.value.map((e) => e.id.value).toSet();
    List<DeriveEvent> notDoneList = eventList.where((value) => !endConfigIdSet.contains(value.status.value?.id.value)).toList();
    int key = currentDate.value.millisecondsSinceEpoch;
    Rx<int> count = dateCount.putIfAbsent(key, () => 0.obs);
    count.value = notDoneList.length;
    eventListUpdateFlag.value++;
    if (currentDate.value.isSameDay(DateTime.now())) {
      _eventService.updateBadges();
    }
  }

  /// 查找数量
  Future<void> findCount(DateTime start, DateTime end) async {
    EventConfig? config = eventConfig;
    if (null == config) {
      config = await _eventService.findConfig();
      eventConfig = config;
    }
    int interval = end.difference(start).inDays;
    for (int i = 0; i <= interval; i++) {
      DateTime dateTime = start.add(Duration(days: i));
      // 当前时间
      FilterDateTime filterDateTime = FilterDateTime(type: FilterDateTimeTypeEnum.custom, customDate: dateTime);
      // 用tag做过滤和排序
      Tag filterTag = Tag()
        ..filter.value = GroupFilterValue(
          filters: [
            // 1. 开始时间小于等于今天
            SingleFilterValue(filter: SingleFilter.lessThanOrEquals(field: EventFilterField.startTiming.value, value: filterDateTime)),
            SingleFilterValue(filter: SingleFilter.notNull(field: EventFilterField.startTiming.value)),
            // 2. 结束事件大于等于今天或者为空
            GroupFilterValue(
              op: GroupFilterOp.or,
              filters: [
                SingleFilterValue(filter: SingleFilter.isNull(field: EventFilterField.endTiming.value)),
                SingleFilterValue(filter: SingleFilter.greaterThanOrEquals(field: EventFilterField.endTiming.value, value: filterDateTime)),
              ],
            ),
            SingleFilterValue(filter: SingleFilter.notInList(field: EventFilterField.status.value, value: eventConfig!.endStatus.value))
          ],
        );
      List<DeriveEvent> dataList = await _eventService.findTreeByTag(filterTag);
      int key = dateTime.millisecondsSinceEpoch;
      Rx<int> dateTimeCount = dateCount.putIfAbsent(key, () => 0.obs);
      debugPrint("${dateTime}_${dataList.length}");
      dateTimeCount.value = dataList.length;
    }
  }

  /// 新增日程
  Future<void> add(DeriveEvent event) async {
    await _eventService.save(event);
    await findCurrentEventList();
  }

  /// 事件状态修改
  void afterStatusChanged(DeriveEvent event) {
    findCurrentEventList();
  }

  /// 更新列表
  void refreshList() async {
    HapticFeedback.lightImpact();
    await findCurrentEventList();
    refreshController.refreshCompleted();
  }

  /// 是否可以删除事件
  Future<bool> canRemove(DeriveEvent event) async {
    bool? canRemove = await RouteHelper.showOneChoiceRequest();
    return canRemove == true;
  }

  /// 删除事件 重新分组
  Future<void> onRemove(DeriveEvent event) async {
    String eventId = event.id.value;
    eventMap.remove(eventId);
    cardController[eventId]?.reverse();
    statusController[eventId]?.reverse();
    itemController[eventId]?.reverse();
    bool isRemoveChildrenRes = await isRemoveChildren(event);
    // 删除
    await _eventService.remove(event, isRemoveChildren: isRemoveChildrenRes);
    // 提示
    RouteHelper.toast(msg: "${event.toString()}删除成功");
    Future.delayed(AppConfig.animationConfig.middleAnimationDuration, () {
      eventListUpdateFlag.value++;
      int key = currentDate.value.millisecondsSinceEpoch;
      Rx<int> count = dateCount.putIfAbsent(key, () => 0.obs);
      count.value--;
      if (currentDate.value.isSameDay(DateTime.now())) {
        _eventService.updateBadges();
      }
    });
  }

  /// 是否同时删除子事件
  Future<bool> isRemoveChildren(Event event) async {
    bool hasChildren = !event.children.isNull;
    bool isRemoveChildren = false;
    if (hasChildren) {
      // 询问用户是否删除子事件
      bool? res = await RouteHelper.showOneChoiceRequest(msg: "存在子事件，是否同时删除?", cancelText: "不删除");
      isRemoveChildren = res == true;
    }
    return isRemoveChildren;
  }

  /// 事件展开回调
  void onEventExpanded(bool expanded, DeriveEvent event) async {
    List<DeriveEvent> children = event.children.value;
    String eventId = event.id.value;
    if (children.isEmpty) {
      if (!expanded) {
        expandedEvent.remove(eventId);
        cardController.remove(eventId);
        statusController.remove(eventId);
        itemController.remove(eventId);
      }
      eventListUpdateFlag.value++;
      return;
    }
    if (!expanded) {
      expandedEvent.remove(eventId);
      for (DeriveEvent child in children) {
        String childId = child.id.value;
        eventMap.remove(childId);
        cardController[childId]?.reverse();
        statusController[childId]?.reverse();
        itemController[childId]?.reverse();
        cardController.remove(childId);
        statusController.remove(childId);
        itemController.remove(childId);
      }
      await Future.delayed(AppConfig.animationConfig.middleAnimationDuration);
    } else {
      expandedEvent.add(event.id.value);
      // linkedHashMap
      Map<String, DeriveEvent> newMap = {};
      eventMap.forEach((key, value) {
        if (key == event.id.value) {
          newMap[key] = value;
          for (DeriveEvent child in children) {
            newMap[child.id.value] = child;
          }
        } else {
          newMap[key] = value;
        }
      });
      eventMap.clear();
      eventMap.addAll(newMap);
    }
    eventListUpdateFlag.value++;
  }

  /// ----- 角标处理 -----

  /// 今日待办
  Rx<int> todayEventNumber = 0.obs;

  @override
  void onReady() async {
    // 监听事件
    EventsHelper.badgesUpdate.listen(key: "schedule", callback: (args) => todayEventNumber.value = args);
    _eventService.updateBadges();
  }

  @override
  Widget buildDrawer({required bool isActive, required IconData iconData, required String title, required VoidCallback action}) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Obx(
        () {
          int todayNumber = todayEventNumber.value;
          String text = todayNumber.toString();
          if (todayNumber > 9) text = "9+";
          return Badge(
            position: BadgePosition.topEnd(end: -5),
            badgeContent: HgNeumorphicText(text),
            showBadge: todayNumber > 0,
            elevation: themeData.depth,
            child: HgNeumorphicButton(
              style: NeumorphicStyle(depth: isActive ? -themeData.depth : themeData.depth),
              child: Row(children: [HgNeumorphicIcon(iconData, size: 20), const Padding(padding: EdgeInsets.only(left: 8)), HgNeumorphicText(title)]),
              onPressed: action,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildQuickaccess({required bool isActive, required IconData iconData, required String title, required VoidCallback action}) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(
      () {
        int todayNumber = todayEventNumber.value;
        String text = todayNumber.toString();
        if (todayNumber > 9) text = "9+";
        return Badge(
          position: BadgePosition.topEnd(end: -5),
          elevation: themeData.depth,
          badgeContent: HgNeumorphicText(text),
          showBadge: todayNumber > 0,
          child: super.buildQuickaccess(isActive: isActive, iconData: iconData, title: title, action: action),
        );
      },
    );
  }

  /// ---- 新手引导处理 ----

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "calendar",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("日历，\n点击可切换日期，\n左右滑动可切换周或月"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "mode_button",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("日历模式切换按钮，\n点击后切换日历模式为周历或月历"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "timeline",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("时间线列表，\n按照时间顺序显示当日事件"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "add_button",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("设置阿娜妞，\n设置日程列表及日程提醒"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "add_button",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("新增按钮，\n新增所选日期日程"),
        ),
      ],
    );
  }

  @override
  HomePages get homePage => HomePages.schedule;
}

/// 日程页面
class ScheduleHomePage extends HomePage<ScheduleHomeLogic> {
  /// 日程
  ScheduleHomePage({required String key, required HomePageArgs args}) : super(key: key, args: args, newLogic: ScheduleHomeLogic());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      // 月份
      leading: Container(
        padding: const EdgeInsets.only(left: 6),
        child: Obx(() => Text(DateTimeUtil.format(logic.month.value, formats: [yyyy, "年", mm, "月"]), style: const TextStyle(fontSize: 14))),
      ),
      title: HgNeumorphicText("日程"),
      // 日历模式
      trailing: SlideInRight(
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          child: HgNeumorphicButton(
            key: logic.addTutorialTargetKey(1, "mode_button"),
            padding: const EdgeInsets.all(8),
            getTooltip: () => "切换日历模式",
            child: Obx(() {
              int modeUpdateFlag = logic.modeUpdateFlag.value;
              debugPrint("日历模式更新次数:$modeUpdateFlag");
              return HgNeumorphicIcon(logic.modeIcon[logic.mode]!);
            }),
            onPressed: logic.changeMode,
          ),
        ),
      ),
      bodyPadding: const EdgeInsets.only(top: 6),
      body: Column(children: [Expanded(flex: 0, child: buildCalendar()), Expanded(child: buildTimeLine())]),
      addButtonKey: logic.addTutorialTargetKey(6, "add_button"),
      onAdd: quickAdd,
      settingsButtonKey: logic.addTutorialTargetKey(5, "settings_button"),
      onSettings: toSettings,
    );
  }

  /// 构建日历
  Widget buildCalendar() {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        clipBehavior: Clip.none,
        child: Obx(() {
          int modeUpdateFlag = logic.modeUpdateFlag.value;
          debugPrint("日历模式更新次数:$modeUpdateFlag");
          return Container(
            key: logic.addTutorialTargetKey(0, "calendar"),
            child: Calendar(
              key: "schedule_calendar${logic.mode}",
              args: CalendarArgs(
                mode: logic.mode,
                initialDate: logic.currentDate.value,
                firstDate: logic.firstDate,
                lastDate: logic.lastDate,
                selected: [logic.currentDate.value],
                onPageChange: logic.onCalendarPageChange,
                onDateSelect: logic.onDateSelected,
                wrapper: buildDayWithBadge,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildDayWithBadge({required DateTime dateTime, required Widget child, required bool isEnable}) {
    int key = dateTime.millisecondsSinceEpoch;
    Rx<int> count = logic.dateCount.putIfAbsent(key, () => 0.obs);
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;

    return Obx(() {
      int countValue = count.value;
      String text = countValue > 9 ? "9+" : countValue.toString();
      return Badge(
        badgeContent: SizedBox(height: 20, width: 20, child: Center(child: HgNeumorphicText(text))),
        padding: EdgeInsets.zero,
        elevation: themeData.depth,
        position: BadgePosition.topEnd(end: -5),
        showBadge: countValue > 0 && isEnable,
        child: child,
      );
    });
  }

  Widget buildTimeLine() {
    return Container(
      key: logic.addTutorialTargetKey(2, "timeline"),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: PageView.builder(
        clipBehavior: Clip.none,
        key: const ValueKey("schedule_event"),
        itemCount: logic.getPageSize(),
        controller: logic.pageController,
        itemBuilder: (context, index) {
          logic.refreshController = RefreshController();
          return Obx(() {
            int listUpdateFlag = logic.eventListUpdateFlag.value;
            debugPrint("日程列表更新次数:$listUpdateFlag");
            Widget child;
            if (index != logic.getPageIndex()) {
              child = Container();
            } else if (logic.eventMap.isEmpty) {
              child = buildEmpty();
            } else {
              child = buildEventTimeLine();
            }
            return SmartRefresher(
              key: getWidgetKey(SmartRefresher, index.toString()),
              controller: logic.refreshController,
              child: child,
              onRefresh: logic.refreshList,
            );
          });
        },
        onPageChanged: logic.onPageChanged,
      ),
    );
  }

  /// 事件为空
  Widget buildEmpty() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return FadeInDown(
      child: Center(child: Text("无事发生", style: TextStyle(color: themeData.disabledColor))),
    );
  }

  /// 构建事件时间线
  Widget buildEventTimeLine() {
    List<DeriveEvent> eventList = logic.eventMap.values.toList();
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.5, top: 0),
      itemCount: eventList.length,
      itemBuilder: (context, index) {
        DeriveEvent event = eventList[index];
        bool isFirst = index == 0;
        bool isLast = index == eventList.length - 1;
        return FadeIn(
          controller: (controller) => logic.itemController[event.id.value] = controller,
          child: ScheduleItem(
            key: event.id.value,
            args: ScheduleItemArgs(
              isFirst: isFirst,
              isLast: isLast,
              navigatorId: logic.args.navigatorId,
              canRemove: logic.canRemove,
              onRemove: logic.onRemove,
              afterStatusChanged: () => logic.afterStatusChanged(event),
              onTap: (event) => toDetail(event, PageState.edit, logic.findCurrentEventList),
              level: getEventLevel(event),
              isExpanded: logic.expandedEvent.contains(event.id.value),
              onExpanded: (expanded, event) => logic.onEventExpanded(expanded, event),
            ),
            dataSource: ScheduleItemDataSource(
              event: event,
              config: logic.eventConfig ?? EventConfig(),
              cardController: logic.cardController,
              statusController: logic.statusController,
            ),
          ),
        );
      },
    );
  }

  /// 获取事件等级
  int getEventLevel(DeriveEvent event) {
    DeriveEvent? parent = event.parent.value;
    if (null == parent) return 0;
    String parentId = event.id.value;
    if (!logic.eventMap.containsKey(parentId)) return 0;
    return getEventLevel(parent) + 1;
  }

  /// 新增子事件
  void quickAdd() {
    DateTime now = logic.currentDate.value;
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = DateTime(today.year, today.month, today.day + 1);
    DeriveEvent newEvent = DeriveEvent();
    newEvent.timing.value = SingleTiming()
      ..start.value = today
      ..end.value = tomorrow.add(const Duration(microseconds: -1));
    RouteHelper.bottomSheet(
      sheet: EventQuickAdd<DeriveEvent>(
        key: newEvent.id.value,
        args: EventQuickAddArgs(
          onFullScreen: (newEvent) => toDetail(newEvent, PageState.add, () => logic.add(newEvent)),
          navigatorId: logic.args.navigatorId,
          onDone: logic.add,
        ),
        dataSource: EventQuickAddDataSource(event: newEvent, config: logic.eventConfig ?? EventConfig()),
      ),
    );
  }

  /// 详情
  void toDetail(DeriveEvent event, PageState state, VoidCallback onDone) {
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: "event_detail".hashCode,
      page: DeriveEventDetail(
        key: event.id.value,
        args: EventDetailArgs(
          parentNavigatorId: logic.args.navigatorId,
          state: PageState.edit,
          navigatorId: "event_detail".hashCode,
          onDone: onDone,
        ),
        dataSource: EventDetailDataSource(event: event, config: logic.eventConfig ?? EventConfig()),
      ),
    );
  }

  /// 打开设置页面
  void toSettings() async {
    int id = "schedule_settings".hashCode;
    RouteHelper.bottomPageNested(
      parentId: logic.args.navigatorId,
      nestedId: id,
      page: ScheduleSettings(
        key: "event_settings",
        args: ScheduleSettingsArgs(
          parentNavigatorId: logic.args.navigatorId,
          navigatorId: id,
          onDone: logic.saveConfig,
        ),
        dataSource: ScheduleSettingsDataSource(config: logic.config),
      ),
    );
  }
}
