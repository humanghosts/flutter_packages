import 'package:animate_do/animate_do.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'tag_add.dart';
import 'tag_item.dart';

/// 外部参数
@immutable
class TagRowEditArgs extends ViewArgs {
  final int navigatorId;
  final int parentNavigatorId;
  final ValueChanged<EventConfig>? onDone;

  const TagRowEditArgs({
    required this.navigatorId,
    required this.parentNavigatorId,
    this.onDone,
  });
}

/// 外部数据
@immutable
class TagRowEditDataSource extends ViewDataSource {
  final EventConfig config;

  const TagRowEditDataSource({required this.config});
}

/// 逻辑
class TagRowEditLogic extends TutorialViewLogic<TagRowEditArgs, TagRowEditDataSource> {
  /// 是否是编辑模式
  Rx<bool> isEditable = false.obs;

  /// 配置更新次数
  Rx<int> configUpdateFlag = 0.obs;

  /// 配置
  EventConfig config = EventConfig();

  /// 返回
  void back() {
    RouteHelper.back(id: args.parentNavigatorId);
  }

  /// 确认
  void done() {
    args.onDone?.call(config);
    back();
  }

  /// 打开回调
  @override
  void afterArgsUpdate() async {
    isEditable.value = false;
    config = dataSource.config.clone() as EventConfig;
    configUpdateFlag.value = 0;
  }

  ///  移除一个标签
  void remove(Tag tag) async {
    config.tagList.remove(tag);
    configUpdateFlag.value++;
  }

  /// 重排序
  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) return;
    List<Tag> homeList = config.tagList.value;
    Tag tag = homeList[oldIndex];
    config.tagList.remove(tag);
    config.tagList.insert(newIndex, tag);
    configUpdateFlag.value++;
  }

  /// 添加标签
  void add(List<Tag> tagList) {
    config.tagList.addAll(tagList);
    configUpdateFlag.value++;
  }

  void edit() {
    isEditable.value = !isEditable.value;
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
          builder: (context, controller) => HgNeumorphicText("标签栏编辑页面，\n拖拽标签可排序"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "delete_button",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("删除/取消删除 按钮，\n点击可删除或取消删除标签"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "add_button",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("添加按钮，\n点击后进入标签选择页面，选择添加到标签栏的标签"),
        ),
      ],
    );
  }

  @override
  String? get tutorialSubKey => "tag_row_edit";

  @override
  HomePages get homePage => HomePages.event;
}

/// 页面
class TagRowEdit extends View<TagRowEditLogic> {
  TagRowEdit({
    required String key,
    required TagRowEditArgs args,
    required TagRowEditDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: TagRowEditLogic());

  @override
  Widget buildView(BuildContext context) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      trailing: HgNeumorphicDoneButton(onPressed: logic.done),
      title: HgNeumorphicText("标签栏编辑"),
      body: Obx(() => buildTagRowEdit()),
      bodyPadding: EdgeInsets.zero,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 删除/取消删除 按钮
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: HgNeumorphicButton(
              key: logic.addTutorialTargetKey(1, "delete_button"),
              padding: const EdgeInsets.all(16),
              getTooltip: () => logic.isEditable.value ? "取消删除" : "删除",
              child: Obx(
                () => HgNeumorphicIcon(
                  Icons.delete,
                  color: logic.isEditable.value ? themeData.disabledColor : Colors.red,
                ),
              ),
              onPressed: logic.edit,
            ),
          ),
          // 添加按钮
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: HgNeumorphicButton(
              key: logic.addTutorialTargetKey(2, "add_button"),
              getTooltip: () => "添加",
              padding: const EdgeInsets.all(16),
              child: HgNeumorphicIcon(Icons.add),
              onPressed: add,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建编辑页面
  Widget buildTagRowEdit() {
    int configUpdateFlag = logic.configUpdateFlag.value;
    debugPrint("标签页列表更新次数:$configUpdateFlag");
    List<Widget> children = [];
    for (Tag tag in logic.config.tagList.value) {
      children.add(buildTag(tag));
    }
    return ReorderableWrap(
      buildDraggableFeedback: (BuildContext context, BoxConstraints constraints, Widget child) {
        return Neumorphic(
          style: const NeumorphicStyle(disableDepth: true, color: Colors.transparent),
          child: Container(constraints: constraints, child: child),
        );
      },
      spacing: 4,
      runSpacing: 4,
      needsLongPressDraggable: false,
      scrollPhysics: const AlwaysScrollableScrollPhysics(),
      onReorder: logic.onReorder,
      children: children,
    );
  }

  Widget buildTag(Tag tag) {
    return SizedBox(
      height: 80,
      child: AspectRatio(
        aspectRatio: 0.9,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            // 标签
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: TagRowItem(
                key: tag.id.value,
                args: const TagRowItemArgs(canTap: false),
                dataSource: TagRowItemDataSource(tag: tag),
              ),
            ),
            // 删除按钮
            Obx(() {
              if (!logic.isEditable.value) return Container();
              return ElasticIn(
                child: HgNeumorphicButton(
                  padding: const EdgeInsets.all(4),
                  style: const NeumorphicStyle(
                    color: Colors.redAccent,
                    boxShape: NeumorphicBoxShape.circle(),
                    disableDepth: true,
                  ),
                  child: HgNeumorphicIcon(Icons.remove),
                  onPressed: () => logic.remove(tag),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// 跳转到新增标签
  void add() {
    RouteHelper.to(
      id: logic.args.navigatorId,
      page: TagRowAdd(
        key: 'tag_picker',
        args: TagRowAddArgs(
          navigatorId: logic.args.navigatorId,
          onBack: logic.add,
        ),
        dataSource: TagRowAddDataSource(
          inHomeList: logic.config.tagList.value,
        ),
      ),
    );
  }
}
