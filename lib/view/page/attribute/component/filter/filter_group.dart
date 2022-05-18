import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/route/observer.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/attribute/component/filter/filter_single.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../to_string.dart';

/// 条件组模式
enum FilterGroupMode { page, widget }

/// 条件组参数
@immutable
class FilterGroupEditorArgs extends ViewArgs {
  /// 导航ID
  final int navigatorId;

  /// 主条件移除
  final VoidCallback? onRemove;

  /// 页面模式返回调用
  final VoidCallback? onBack;

  /// 条件组模式
  final FilterGroupMode mode;

  /// 页面模式的标题
  final String pageTitle;

  /// 页面状态
  final PageState state;

  const FilterGroupEditorArgs({
    this.mode = FilterGroupMode.page,
    required this.navigatorId,
    this.onRemove,
    this.pageTitle = "",
    this.onBack,
    required this.state,
  });
}

/// 数据
@immutable
class FilterGroupEditorDataSource extends ViewDataSource {
  /// 条件组 值
  final GroupFilterValue groupFilterValue;

  const FilterGroupEditorDataSource({required this.groupFilterValue});
}

/// 逻辑
class FilterGroupEditorLogic extends TutorialViewLogic<FilterGroupEditorArgs, FilterGroupEditorDataSource> {
  /// 是否展开
  Rx<bool> isExpand = true.obs;

  /// 子条件数量
  Rx<int> childrenLength = 0.obs;

  /// 操作符名称
  Rx<String> op = "".obs;

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  @override
  void afterArgsUpdate() {
    childrenLength.value = dataSource.groupFilterValue.filters.length;
    op.value = dataSource.groupFilterValue.op.name;
  }

  /// 返回上一界面
  void onBack() {
    if (args.state == PageState.browse) return;
    String oldString = dataSource.groupFilterValue.toString();
    // 清空非法数据
    clearIllegal(dataSource.groupFilterValue);
    String newString = dataSource.groupFilterValue.toString();
    if (oldString != newString) {
      // 提示
      RouteHelper.toast(msg: "已自动删除无效条件和重复条件");
    }
    // 返回回调
    args.onBack?.call();
  }

  /// 清空非法数据(为空数据)
  /// 返回值为是否是空条件组
  bool clearIllegal(GroupFilterValue groupFilterValue) {
    // 所有子条件
    List<FilterValue> filterValueList = groupFilterValue.filters;
    if (filterValueList.isEmpty) return true;
    // 需要删除的子条件
    List<FilterValue> needClearList = [];
    // 遍历子条件
    for (FilterValue filterValue in filterValueList) {
      // 条件处理
      if (filterValue is SingleFilterValue) {
        if (filterValue.isNull) needClearList.add(filterValue);
      }
      // 条件组处理
      else {
        // 是否是空条件组，是的话 移除
        bool isEmptyGroup = clearIllegal(filterValue as GroupFilterValue);
        if (isEmptyGroup) needClearList.add(filterValue);
      }
    }
    // 如果需要移除的条件数量等于总条件数量，说明是空条件组，还原
    if (needClearList.length == filterValueList.length) {
      groupFilterValue.filters.clear();
      groupFilterValue.op = GroupFilterOp.and;
      return true;
    }
    // 移除需要移除的
    for (FilterValue element in needClearList) {
      filterValueList.remove(element);
    }
    return false;
  }

  /// 添加条件
  void addSingle() {
    dataSource.groupFilterValue.filters.add(SingleFilterValue());
    childrenLength.value = childrenLength.value + 1;
  }

  /// 添加条件组
  void addGroup() {
    dataSource.groupFilterValue.filters.add(GroupFilterValue());
    childrenLength.value = childrenLength.value + 1;
  }

  /// 展开/收起
  void expand(bool isExpand) => this.isExpand.value = isExpand;

  /// 删除父条件
  void removeParent() => args.onRemove?.call();

  /// 删除一个子条件
  void removeChild(int index) {
    dataSource.groupFilterValue.filters.removeAt(index);
    childrenLength.value = childrenLength.value - 1;
  }

  /// 修改主条件的操作符
  void changeOp(List<int> opIndexList) {
    if (opIndexList.isEmpty) return;
    dataSource.groupFilterValue.op = GroupFilterOp.list[opIndexList.first];
    op.value = dataSource.groupFilterValue.op.name;
  }

  @override
  void buildTutorial() {
    if (args.mode == FilterGroupMode.page) {
      buildAndAddTargetFocus(
        "group_header",
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => HgNeumorphicText("条件组条件，\n点击可展开或收起子条件，\n长按可查看当前条件组所有条件"),
          ),
        ],
      );
      buildAndAddTargetFocus(
        "group_expand",
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => HgNeumorphicText("展开或收起按钮，\n点击可展开或收起子条件"),
          ),
        ],
      );
      buildAndAddTargetFocus(
        "group_op",
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => HgNeumorphicText("条件组操作符，\n用来确定子条件相互之间的关系，"
                "\n点击可进入操作符选择页面，\n长按可查看当前选择操作符"),
          ),
        ],
      );
      buildAndAddTargetFocus(
        "group_fab",
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) => HgNeumorphicText("新增按钮，\n点击可新增子条件组或子条件"),
          ),
        ],
      );
      buildAndAddTargetFocus(
        "group_child",
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => HgNeumorphicText("子条件，\n向左滑动可删除此子条件"),
          ),
        ],
      );
    } else {
      buildAndAddTargetFocus(
        "group_header",
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => HgNeumorphicText("子条件组，\n点击可展开或收起子条件，\n长按可查看当前子条件组所有条件，"
                "\n向左滑动可删除此子条件组"),
          ),
        ],
      );
      buildAndAddTargetFocus(
        "group_next",
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => HgNeumorphicText("前进按钮，\n点击进入下一页面编辑该子条件组"),
          ),
        ],
      );
    }
  }

  @override
  String? get tutorialSubKey => "filter_group_${args.mode}";

  @override
  HomePages get homePage => HomePages.attribute;

  /// 条件组返回
  void onGroupBack() {
    update();
    args.onBack?.call();
  }
}

/// 条件编辑页面
class FilterGroupEditor extends View<FilterGroupEditorLogic> with ObserverWidget {
  FilterGroupEditor({
    String? key,
    required FilterGroupEditorArgs args,
    required FilterGroupEditorDataSource dataSource,
  }) : super(key: _getKey(key, args, dataSource), args: args, dataSource: dataSource, newLogic: FilterGroupEditorLogic());

  /// 获取组件的key
  static String _getKey(String? key, FilterGroupEditorArgs args, FilterGroupEditorDataSource dataSource) {
    return key ?? "${dataSource.groupFilterValue.hashCode.toString()}${args.mode}";
  }

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    switch (logic.args.mode) {
      case FilterGroupMode.page:
        return buildPage();
      case FilterGroupMode.widget:
        return buildWidget();
    }
  }

  /// 构建mode=page的内容
  Widget buildPage() {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      title: HgNeumorphicText(logic.args.pageTitle),
      body: NestedScrollView(
        clipBehavior: Clip.none,
        // 列表头，展示条件组条件
        floatHeaderSlivers: true,
        // 组条件
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [SliverToBoxAdapter(child: buildPageHeader())],
        // 列表内容，展示子条件
        body: buildPageChildren(),
      ),
      // 新增按钮 浏览状态没有
      floatingActionButton: logic.args.state == PageState.browse ? null : buildPageFab(),
      // 按钮位置
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  /// 页面模式的头部
  Widget buildPageHeader() {
    return HgNeumorphicButton(
      key: logic.addTutorialTargetKey(0, "group_header"),
      padding: const EdgeInsets.all(8),
      fullScreenTooltip: true,
      getTooltip: () => groupFilterToString(logic.dataSource.groupFilterValue, format: true) ?? "",
      child: Row(
        children: [
          // 展开按钮
          Container(
            key: logic.addTutorialTargetKey(1, "group_expand"),
            child: HgNeumorphicExpandedButton(
              key: logic.key,
              args: HgNeumorphicExpandedButtonArgs(
                padding: const EdgeInsets.all(12),
                initExpanded: logic.isExpand.value,
                onExpanded: logic.expand,
              ),
            ),
          ),
          // 间隔
          const Padding(padding: EdgeInsets.only(left: 16)),
          // 操作符
          Row(children: [buildGroupOp()]),
        ],
      ),
      onPressed: () {
        HgNeumorphicExpandedButtonLogic expandLogic = Get.find<HgNeumorphicExpandedButtonLogic>(tag: logic.key);
        expandLogic.expand();
      },
    );
  }

  /// 新增按钮
  Widget? buildPageFab() {
    String expandableFabKey = logic.key;
    // 展开动画按钮
    return ExpandableFab(
      key: expandableFabKey,
      args: ExpandableFabArgs(
        tutorialKey: logic.addTutorialTargetKey(3, "group_fab"),
        children: [
          ActionButton(
            child: HgNeumorphicIcon(Icons.playlist_add),
            title: "条件组",
            onPressed: () {
              ExpandableFabLogic logic = Get.find<ExpandableFabLogic>(tag: expandableFabKey);
              logic.toggle();
              this.logic.addGroup();
            },
          ),
          ActionButton(
            child: HgNeumorphicIcon(Icons.add),
            title: "条件",
            onPressed: () {
              ExpandableFabLogic logic = Get.find<ExpandableFabLogic>(tag: expandableFabKey);
              logic.toggle();
              this.logic.addSingle();
            },
          ),
        ],
      ),
    );
  }

  /// 构建页面模式的子条件列表
  Widget buildPageChildren() {
    return Obx(() {
      int itemCount = logic.isExpand.value ? logic.childrenLength.value : 0;
      if (itemCount <= 0) return Container();
      return ListView.builder(
        padding: EdgeInsets.only(bottom: Get.width * 0.5),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            clipBehavior: Clip.none,
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: buildChild(context, index),
          );
        },
      );
    });
  }

  /// 构建组件模式
  Widget buildWidget() {
    return Obx(() {
      int itemCount = logic.isExpand.value ? logic.childrenLength.value : 0;
      itemCount++;
      return ListView.builder(
        clipBehavior: Clip.none,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          Widget child;
          if (index == 0) {
            // 第一个元素的操作符
            child = buildWidgetHeader();
          } else {
            // 子条件
            child = Container(
              clipBehavior: Clip.none,
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: buildChild(context, index - 1),
            );
          }
          return child;
        },
      );
    });
  }

  /// 构建组件模式条件组列表头
  Widget buildWidgetHeader() {
    String expandKey = logic.key;
    return HgNeumorphicButton(
      key: logic.addTutorialTargetKey(0, "group_header"),
      padding: EdgeInsets.zero,
      getTooltip: () => groupFilterToString(logic.dataSource.groupFilterValue, format: true) ?? "",
      fullScreenTooltip: true,
      child: Removeable(
        groupTag: "filter",
        key: logic.dataSource.groupFilterValue.hashCode.toString(),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // 展开按钮
                  HgNeumorphicExpandedButton(
                    key: expandKey,
                    args: HgNeumorphicExpandedButtonArgs(
                      initExpanded: logic.isExpand.value,
                      onExpanded: logic.expand,
                      // 8+4
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                  // 间隔
                  const Padding(padding: EdgeInsets.only(left: 16)),
                  // 操作符
                  Row(children: [buildGroupOp()]),
                ],
              ),
              HgNeumorphicNextButton(key: logic.addTutorialTargetKey(1, "group_next"), onPressed: toGroupPage),
            ],
          ),
        ),
        // 浏览状态不可删除
        onRemove: logic.args.state == PageState.browse ? null : () => logic.removeParent(),
        // 空值不提示是否删除
        isShowHint: () => !logic.dataSource.groupFilterValue.isNull,
        // 提示语
        text: "该操作会删除所有子条件，确定删除吗？",
      ),
      onPressed: () {
        HgNeumorphicExpandedButtonLogic expandLogic = Get.find<HgNeumorphicExpandedButtonLogic>(tag: expandKey);
        expandLogic.expand();
      },
    );
  }

  /// 构建条件组操作符
  Widget buildGroupOp() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(
      () => HgNeumorphicButton(
        key: logic.addTutorialTargetKey(2, "group_op"),
        padding: const EdgeInsets.all(8),
        style: NeumorphicStyle(depth: -themeData.depth),
        getTooltip: () => logic.op.value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 名称
            Text(logic.op.value),
            // 间隔
            const Padding(padding: EdgeInsets.only(left: 16)),
            // 下一个页面按钮
            HgNeumorphicNextButton(
              padding: const EdgeInsets.all(4),
              onPressed: logic.args.state == PageState.browse ? null : groupOpSelect,
            ),
          ],
        ),
        onPressed: groupOpSelect,
      ),
    );
  }

  /// 构建单个子条件项
  Widget buildChild(BuildContext context, int index) {
    if (index >= logic.childrenLength.value) return Container();
    // 过滤值
    FilterValue filterValue = logic.dataSource.groupFilterValue.filters[index];
    // 单个
    if (filterValue is SingleFilterValue) {
      return Neumorphic(
        key: index == 0 ? logic.addTutorialTargetKey(4, "group_child") : null,
        child: Removeable(
          groupTag: "filter",
          key: filterValue.hashCode.toString(),
          child: Container(padding: const EdgeInsets.all(8), child: buildSingleChild(filterValue)),
          onRemove: logic.args.state == PageState.browse ? null : () => logic.removeChild(index),
          isShowHint: () => !filterValue.isNull,
        ),
      );
    }
    // 组
    if (filterValue is GroupFilterValue) return buildGroupChild(filterValue, index);
    return Container();
  }

  /// 构建单独的条件
  Widget buildSingleChild(SingleFilterValue singleFilterValue) {
    return FilterSingleEditor(
      key: singleFilterValue.hashCode.toString(),
      args: FilterSingleEditorArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
      dataSource: FilterSingleDataSource(singleFilterValue: singleFilterValue),
    );
  }

  /// 构建条件组
  Widget buildGroupChild(GroupFilterValue groupFilterValue, int index) {
    return FilterGroupEditor(
      args: FilterGroupEditorArgs(
        mode: FilterGroupMode.widget,
        navigatorId: logic.args.navigatorId,
        onRemove: () => logic.removeChild(index),
        state: logic.args.state,
        onBack: logic.onGroupBack,
      ),
      dataSource: FilterGroupEditorDataSource(groupFilterValue: groupFilterValue),
    );
  }

  /// 进入下一个页面
  void toGroupPage() {
    RouteHelper.to(
      page: FilterGroupEditor(
        args: FilterGroupEditorArgs(
          pageTitle: "子条件",
          navigatorId: logic.args.navigatorId,
          onBack: logic.onGroupBack,
          state: logic.args.state,
        ),
        dataSource: FilterGroupEditorDataSource(groupFilterValue: logic.dataSource.groupFilterValue),
      ),
      id: logic.args.navigatorId,
    );
  }

  /// 前往操作符选择页面
  void groupOpSelect() {
    // 浏览状态不反应
    if (logic.args.state == PageState.browse) return;
    // 当前操作符
    GroupFilterOp op = logic.dataSource.groupFilterValue.op;
    List<int> selected = [GroupFilterOp.list.indexOf(op)];
    RouteHelper.to(
      page: MultiSelect(
        key: logic.dataSource.groupFilterValue.hashCode.toString(),
        args: MultiSelectArgs(
          title: "条件组操作符",
          navigatorId: logic.args.navigatorId,
          itemCount: GroupFilterOp.list.length,
          itemBuilder: (context, index, isSelect, action) => Text(GroupFilterOp.list[index].name),
          onBack: logic.changeOp,
        ),
        dataSource: MultiSelectDataSource(selected: selected),
      ),
      id: logic.args.navigatorId,
    );
  }
}
