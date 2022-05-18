import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../card/card.dart';

/// 外部参数
@immutable
class EventDetailChildrenEditorArgs<M extends Event> extends ViewArgs {
  final void Function(M child)? onTap;
  final VoidCallback? onAdd;
  final void Function(M child)? onRemove;
  final Future<bool> Function(M child)? canRemove;
  final PageState state;
  final Widget Function(GlobalKey? key)? addButtonBuilder;

  const EventDetailChildrenEditorArgs({
    this.onTap,
    this.onAdd,
    this.onRemove,
    this.canRemove,
    required this.state,
    this.addButtonBuilder,
  });
}

/// 外部数据
@immutable
class EventDetailChildrenEditorDataSource<M extends Event> extends ViewDataSource {
  final M event;
  final EventConfig config;

  const EventDetailChildrenEditorDataSource({required this.event, required this.config});
}

/// 逻辑
class EventDetailChildrenEditorLogic<M extends Event> extends TutorialViewLogic<EventDetailChildrenEditorArgs<M>, EventDetailChildrenEditorDataSource<M>> {
  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "view",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("子事件列表，显示当前事件的所有子事件，"
              "\n点击可查看子事件"
              "\n向左滑动可以删除子事件"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "add_button",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("添加按钮，新增子事件或关联其他事件"),
        ),
      ],
    );
  }

  @override
  HomePages get homePage => HomePages.event;

  @override
  String? get tutorialSubKey => "detail_children_editor";
}

/// 页面
class EventDetailChildrenEditor<M extends Event> extends View<EventDetailChildrenEditorLogic<M>> {
  EventDetailChildrenEditor({
    required String key,
    required EventDetailChildrenEditorArgs args,
    required EventDetailChildrenEditorDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: EventDetailChildrenEditorLogic<M>());

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      key: logic.addTutorialTargetKey(0, "view"),
      floatingActionButton: logic.args.addButtonBuilder?.call(logic.addTutorialTargetKey(1, "add_button")),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: buildList(),
    );
  }

  Widget buildList() {
    List<M> allChildren = logic.dataSource.event.children.value as List<M>;
    // 未删除的子事件
    List<M> children = allChildren.where((child) => child.isDelete.value != true).toList();
    return ListView.builder(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.25),
      itemCount: children.length,
      itemBuilder: (context, index) {
        M event = children[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: EventCard<M>(
            key: "${logic.key}_event_detail_child_${event.id.value}",
            dataSource: EventCardDataSource(event: event, config: logic.dataSource.config),
            args: EventCardArgs(
              onTap: logic.args.onTap,
              onRemove: logic.args.onRemove,
              canRemove: logic.args.canRemove,
              state: logic.args.state,
            ),
          ),
        );
      },
    );
  }
}
