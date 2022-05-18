import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../card/card.dart';

/// 外部参数
@immutable
class OriginDetailDeriveEditorArgs extends ViewArgs {
  final void Function(DeriveEvent derive)? onTap;
  final void Function(DeriveEvent derive)? onRemove;
  final Future<bool> Function(DeriveEvent derive)? canRemove;
  final PageState state;

  const OriginDetailDeriveEditorArgs({
    this.onTap,
    this.onRemove,
    this.canRemove,
    required this.state,
  });
}

/// 外部数据
@immutable
class OriginDetailDeriveEditorDataSource extends ViewDataSource {
  final List<DeriveEvent> deriveList;
  final EventConfig config;

  const OriginDetailDeriveEditorDataSource({required this.deriveList, required this.config});
}

/// 逻辑
class OriginDetailDeriveEditorLogic extends TutorialViewLogic<OriginDetailDeriveEditorArgs, OriginDetailDeriveEditorDataSource> {
  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "list",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("日程列表，"
              "\n事件保存之后会生成的日程事件"
              "\n日程按时间顺序显示，"
              "\n向左滑动可以删除日程事件"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "detail_derive_editor";

  @override
  HomePages get homePage => HomePages.event;
}

/// 页面
class OriginDetailDeriveEditor extends View<OriginDetailDeriveEditorLogic> {
  OriginDetailDeriveEditor({
    required String key,
    required OriginDetailDeriveEditorArgs args,
    required OriginDetailDeriveEditorDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: OriginDetailDeriveEditorLogic());

  @override
  Widget buildView(BuildContext context) {
    List<DeriveEvent> derives = logic.dataSource.deriveList;
    return ListView.builder(
      key: logic.addTutorialTargetKey(0, "list"),
      padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.25),
      itemCount: derives.length,
      itemBuilder: (context, index) {
        DeriveEvent derive = derives[index];
        bool isRemoved = derive.isDelete.value;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: EventCard<DeriveEvent>(
            key: "${logic.key}_event_detail_derives_${derive.id.value}_$isRemoved",
            dataSource: EventCardDataSource(event: derive, config: logic.dataSource.config),
            args: EventCardArgs(
              onTap: isRemoved ? null : logic.args.onTap,
              onRemove: isRemoved ? null : logic.args.onRemove,
              canRemove: isRemoved ? null : logic.args.canRemove,
              state: logic.args.state,
            ),
          ),
        );
      },
    );
  }
}
