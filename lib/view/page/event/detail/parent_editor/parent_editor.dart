import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../card/card.dart';

/// 外部参数
@immutable
class EventDetailParentEditorArgs<M extends Event> extends ViewArgs {
  final void Function(M parent)? onTap;

  final PageState state;

  const EventDetailParentEditorArgs({
    this.onTap,
    required this.state,
  });
}

/// 外部数据
@immutable
class EventDetailParentEditorDataSource<M extends Event> extends ViewDataSource {
  final M event;
  final EventConfig config;

  const EventDetailParentEditorDataSource({required this.event, required this.config});
}

/// 逻辑
class EventDetailParentEditorLogic<M extends Event> extends TutorialViewLogic<EventDetailParentEditorArgs<M>, EventDetailParentEditorDataSource<M>> {
  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "list",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("父事件列表，"
              "\n显示事件的父级事件直到根事件"
              "\n从根事件开始排序"
              "\n点击可查看父事件详情"),
        ),
      ],
    );
  }

  @override
  HomePages get homePage => HomePages.event;

  @override
  String? get tutorialSubKey => "detail_parent_editor";
}

/// 页面
class EventDetailParentEditor<M extends Event> extends View<EventDetailParentEditorLogic<M>> {
  EventDetailParentEditor({
    required String key,
    required EventDetailParentEditorArgs args,
    required EventDetailParentEditorDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: EventDetailParentEditorLogic());

  @override
  Widget buildView(BuildContext context) {
    M? parent = logic.dataSource.event.parent.value as M?;
    if (null == parent) return Container();
    List<M> parentList = [];
    // 获取父事件列表
    getParentList(parent, parentList);
    return ListView.builder(
      key: logic.addTutorialTargetKey(0, "list"),
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.25),
      itemCount: parentList.length,
      itemBuilder: (context, index) {
        M event = parentList[index];
        return Container(
          margin: EdgeInsets.only(top: 6, bottom: 6, left: index * 12),
          child: EventCard<M>(
            key: "${logic.key}_event_detail_parent_${event.id.value}",
            dataSource: EventCardDataSource(event: event, config: logic.dataSource.config),
            args: EventCardArgs(onTap: logic.args.onTap, state: logic.args.state),
          ),
        );
      },
    );
  }

  /// 构建父事件树 父事件树不受深度控制
  void getParentList(M event, List<M> parentList) {
    if (!event.parent.isNull) getParentList(event.parent.value! as M, parentList);
    parentList.add(event);
  }
}
