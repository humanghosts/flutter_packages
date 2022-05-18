import 'package:animate_do/animate_do.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/data/tag.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/export.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'tag_item.dart';

@immutable
class TagRowAddArgs extends ViewArgs {
  /// 返回回调
  final ValueChanged<List<Tag>>? onBack;

  /// 导航id
  final int navigatorId;

  const TagRowAddArgs({
    this.onBack,
    required this.navigatorId,
  });
}

@immutable
class TagRowAddDataSource extends ViewDataSource {
  /// 在主页显示的标签
  final List<Tag> inHomeList;

  const TagRowAddDataSource({required this.inHomeList});
}

class TagRowAddLogic extends TutorialViewLogic<TagRowAddArgs, TagRowAddDataSource> {
  /// 配置服务
  final EventConfigService configService = EventConfigService.instance;

  /// 不再标签页中的标签
  List<Tag> notInHomeList = [];

  /// 选中的标签
  List<Tag> selectedList = [];

  /// 选中更新标识
  Rx<int> selectedUpdateFlag = 0.obs;

  @override
  void afterArgsUpdate() async {
    selectedList.clear();
    notInHomeList = await configService.findNotHomeList(dataSource.inHomeList);
    update();
  }

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 返回回调
  void onBack() {
    args.onBack?.call(selectedList);
  }

  /// 选中/取消选中 标签
  void select(Tag tag) {
    if (selectedList.contains(tag)) {
      selectedList.remove(tag);
    } else {
      selectedList.add(tag);
    }
    selectedUpdateFlag.value++;
  }

  @override
  void buildTutorial() {
    addTutorialTargetKey(0, "page");
    buildAndAddTargetFocus(
      "page",
      targetPosition: TargetPosition(const Size.square(4), Offset(Get.width / 2, Get.height / 2)),
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("标签栏添加页面，\n点击可按顺序添加标签"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "tag_row_edit";

  @override
  HomePages get homePage => HomePages.event;
}

class TagRowAdd extends View<TagRowAddLogic> with ObserverWidget {
  TagRowAdd({
    required String key,
    required TagRowAddArgs args,
    required TagRowAddDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: TagRowAddLogic());

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      title: HgNeumorphicText("添加标签"),
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      body: buildIconGrid(),
      bodyPadding: EdgeInsets.zero,
    );
  }

  Widget buildIconGrid() {
    List<Widget> children = [];
    for (Tag tag in logic.notInHomeList) {
      children.add(buildTagIconContainer(tag));
    }
    return ReorderableWrap(
      buildDraggableFeedback: (BuildContext context, BoxConstraints constraints, Widget child) {
        return Container(constraints: constraints, child: child);
      },
      spacing: 4,
      runSpacing: 4,
      scrollPhysics: const AlwaysScrollableScrollPhysics(),
      onReorder: (oldIndex, newIndex) {},
      children: children,
    );
  }

  Widget buildTagIconContainer(Tag tag) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return SizedBox(
      height: 80,
      child: AspectRatio(
        aspectRatio: 0.9,
        child: Obx(() {
          int index = logic.selectedList.indexOf(tag);
          int selectedUpdateFlag = logic.selectedUpdateFlag.value;
          debugPrint("新增标签列表更新次数:$selectedUpdateFlag");
          Widget number;
          if (index < 0) {
            number = Container();
          } else {
            number = ElasticIn(
              child: ElasticIn(
                child: HgNeumorphicButton(
                  padding: const EdgeInsets.all(4),
                  style: const NeumorphicStyle(
                    color: Colors.redAccent,
                    boxShape: NeumorphicBoxShape.circle(),
                    disableDepth: true,
                  ),
                  child: Container(
                    height: themeData.iconTheme.size,
                    width: themeData.iconTheme.size,
                    child: NeumorphicText("${index + 1}"),
                    alignment: Alignment.center,
                  ),
                  onPressed: () {},
                ),
              ),
            );
          }
          return Stack(
            alignment: Alignment.topLeft,
            children: [
              // 标签
              FadeIn(
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TagRowItem(
                    key: tag.id.value,
                    args: TagRowItemArgs(isActive: index >= 0, onTap: () => logic.select(tag)),
                    dataSource: TagRowItemDataSource(tag: tag),
                  ),
                ),
              ),
              number,
            ],
          );
        }),
      ),
    );
  }
}
