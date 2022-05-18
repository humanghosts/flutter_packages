import 'package:animate_do/animate_do.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/config.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/schedule/schedule_card.dart';
import 'package:timeline_tile/timeline_tile.dart' as timeline;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ScheduleItemArgs extends ViewArgs {
  final int navigatorId;
  final bool isFirst;
  final bool isLast;
  final Future<bool> Function(DeriveEvent event)? canRemove;
  final ValueChanged<DeriveEvent>? onRemove;
  final VoidCallback? afterStatusChanged;
  final ValueChanged<DeriveEvent>? onTap;
  final int level;
  final bool isExpanded;

  final void Function(bool expanded, DeriveEvent event)? onExpanded;

  const ScheduleItemArgs({
    required this.navigatorId,
    this.isFirst = false,
    this.isLast = false,
    this.canRemove,
    this.onRemove,
    this.afterStatusChanged,
    this.onTap,
    this.level = 0,
    this.isExpanded = false,
    this.onExpanded,
  });
}

class ScheduleItemDataSource extends ViewDataSource {
  final DeriveEvent event;
  final EventConfig config;
  final Map<String, AnimationController> cardController;
  final Map<String, AnimationController> statusController;

  const ScheduleItemDataSource({
    required this.event,
    required this.config,
    required this.cardController,
    required this.statusController,
  });
}

class ScheduleItemLogic extends TutorialViewLogic<ScheduleItemArgs, ScheduleItemDataSource> {
  Rx<int> a = 0.obs;

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "event",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("事件，\n点击可查看事件详情，\n向左滑动可删除事件"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "status",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("事件状态，\n点击可修改当前事件状态"),
        ),
      ],
    );
  }

  @override
  HomePages get homePage => HomePages.schedule;

  @override
  String? get tutorialSubKey => "schedule_item";

  @override
  bool get isTutorial => args.isFirst && super.isTutorial;
}

class ScheduleItem extends View<ScheduleItemLogic> {
  ScheduleItem({
    required String key,
    required ScheduleItemArgs args,
    required ScheduleItemDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: ScheduleItemLogic());

  @override
  Widget buildView(BuildContext context) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return timeline.TimelineTile(
      alignment: timeline.TimelineAlign.start,
      // 指示器样式
      indicatorStyle: timeline.IndicatorStyle(indicator: buildStatus(), color: Colors.transparent, width: 40, height: 40),
      // 线的样式
      beforeLineStyle: timeline.LineStyle(color: themeData.disabledColor, thickness: 2),
      // 右侧组件
      endChild: buildEventItem(),
      // 是否第一个
      isFirst: logic.args.isFirst,
      // 是否最后一个
      isLast: logic.args.isLast,
    );
  }

  /// 构建事件状态
  Widget buildStatus() {
    DeriveEvent event = logic.dataSource.event;
    Status? status = event.status.value;
    Widget icon;
    String text;
    if (null == status) {
      icon = const Text("", style: TextStyle(fontWeight: FontWeight.bold));
      text = "无状态";
    } else {
      icon = Logo(iconValue: status.icon.value);
      text = status.toString();
    }
    return SlideInDown(
      key: getWidgetKey(FadeIn),
      controller: (controller) => logic.dataSource.statusController[event.id.value] = controller,
      child: HgNeumorphicButton(
        key: logic.addTutorialTargetKey(4, "status"),
        padding: EdgeInsets.zero,
        child: Center(child: icon),
        getTooltip: () => text,
        onPressed: () async {
          await showEventQuickAction(event);
          logic.args.afterStatusChanged?.call();
        },
      ),
    );
  }

  /// 构建事件
  Widget buildEventItem() {
    DeriveEvent event = logic.dataSource.event;
    DeriveEvent? parent = event.parent.value;
    bool hasParent;
    if (null == parent) {
      hasParent = false;
    } else {
      String parentId = parent.id.value;
      hasParent = logic.dataSource.cardController.containsKey(parentId);
    }
    return Container(
      margin: EdgeInsets.only(top: 12, left: 12 + logic.args.level * 12),
      child: FadeInRight(
        key: logic.addTutorialTargetKey(3, "event"),
        duration: AppConfig.animationConfig.middleAnimationDuration,
        controller: (controller) => logic.dataSource.cardController[event.id.value] = controller,
        child: ScheduleCard<DeriveEvent>(
          key: logic.key + event.id.value,
          args: ScheduleCardArgs(
            onTap: logic.args.onTap,
            canRemove: logic.args.canRemove,
            onRemove: logic.args.onRemove,
            state: PageState.edit,
            isExpanded: logic.args.isExpanded,
            onExpanded: logic.args.onExpanded,
            isRoot: !hasParent,
          ),
          dataSource: ScheduleCardDataSource(event: event, config: logic.dataSource.config),
        ),
      ),
    );
  }
}
