import 'package:animate_do/animate_do.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/entity/data/event.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/event/detail/attribute_editor/priority/priority_picker.dart';
import 'package:hg_logger/view/page/event/detail/attribute_editor/status/status_picker.dart';
import 'package:hg_logger/view/page/event/detail/attribute_editor/tag/tag_picker.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'timing/timing_picker.dart';

/// 外部参数
@immutable
class EventAttributeEditorArgs extends ViewArgs {
  /// 导航id，有使用新页面，没有使用bottom sheet
  final int? navigatorId;

  /// 页面状态
  final PageState state;

  const EventAttributeEditorArgs({
    this.navigatorId,
    required this.state,
  });
}

/// 外部数据源
@immutable
class EventAttributeEditorDataSource extends ViewDataSource {
  final Event event;

  const EventAttributeEditorDataSource({required this.event});
}

/// 控制器
class EventAttributeEditorLogic extends TutorialViewLogic<EventAttributeEditorArgs, EventAttributeEditorDataSource> {
  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "editor_row",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("事件属性编辑行，\n可左右滑动"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "status_editor",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("事件状态，\n点击后选择事件状态，"
              "\n事件状态为单选，可以为空，"
              "\n只有新增事件时，事件状态可以编辑，"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "tag_editor",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("事件标签，\n点击后选择事件标签，"
              "\n事件标签为多选，可以为空"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "priority_editor",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("事件优先级，\n点击后选择事件优先级，"
              "\n事件优先级为单选，可以为空"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "timing_editor",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("事件发生时间，\n点击后设置事件时间"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "attribute_editor";

  @override
  HomePages get homePage => HomePages.event;
}

/// 只负责编辑，不负责保存
class EventAttributeEditor extends View<EventAttributeEditorLogic> {
  EventAttributeEditor({
    required String key,
    required EventAttributeEditorArgs args,
    required EventAttributeEditorDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: EventAttributeEditorLogic());

  @override
  Widget buildView(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          key: logic.addTutorialTargetKey(0, "editor_row"),
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: buildStatus()),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: buildTag()),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: buildPriority()),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: buildTiming()),
          ],
        ),
      ),
    );
  }

  /// 状态
  Widget buildStatus() {
    return FadeIn(
      child: Container(
        key: logic.addTutorialTargetKey(1, "status_editor"),
        child: StatusPicker(
          key: logic.key,
          dataSource: StatusPickerDataSource(event: logic.dataSource.event),
          args: StatusPickerArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
        ),
      ),
    );
  }

  /// 构建标签属性
  Widget buildTag() {
    return FadeIn(
      child: Container(
        key: logic.addTutorialTargetKey(2, "tag_editor"),
        child: TagPicker(
          key: logic.key,
          dataSource: TagPickerDataSource(event: logic.dataSource.event),
          args: TagPickerArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
        ),
      ),
    );
  }

  /// 优先级
  Widget buildPriority() {
    return FadeIn(
      child: Container(
        key: logic.addTutorialTargetKey(3, "priority_editor"),
        child: PriorityPicker(
          key: logic.key,
          dataSource: PriorityPickerDataSource(event: logic.dataSource.event),
          args: PriorityPickerArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
        ),
      ),
    );
  }

  /// 构建发生时间属性
  /// 有提醒的时候没有事件
  Widget buildTiming() {
    return FadeIn(
      child: Container(
        key: logic.addTutorialTargetKey(4, "timing_editor"),
        child: TimingPicker(
          key: logic.key,
          dataSource: TimingPickerDataSource(event: logic.dataSource.event),
          args: TimingPickerArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
        ),
      ),
    );
  }
}
