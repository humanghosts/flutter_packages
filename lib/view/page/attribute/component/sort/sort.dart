import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/route/observer.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'sort_value.dart';

/// 排序参数
@immutable
class SortEditorArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 页面返回回调
  final Function()? onBack;

  /// 页面状态
  final PageState state;

  const SortEditorArgs({
    required this.navigatorId,
    this.onBack,
    required this.state,
  });
}

/// 排序数据源
class SortAttributeEditorDataSource extends ViewDataSource {
  /// 排序属性
  final CustomListAttribute<SortValue> attribute;

  const SortAttributeEditorDataSource({required this.attribute});
}

/// 排序逻辑
class SortEditorLogic extends TutorialViewLogic<SortEditorArgs, SortAttributeEditorDataSource> {
  Rx<int> length = 0.obs;

  /// 返回
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 页面打开回调
  @override
  void afterArgsUpdate() {
    length.value = dataSource.attribute.value.length;
    if (args.state == PageState.browse) return;
    // 自动新增一个空的
    if (dataSource.attribute.value.isEmpty) {
      dataSource.attribute.add(SortValue());
      length.value = 1;
    }
  }

  /// 页面退出回调
  void onBack() {
    int oldLength = dataSource.attribute.value.length;
    // 清除非法数据 (不完整数据)
    List<SortValue> needClear = [];
    for (SortValue element in dataSource.attribute.value) {
      if (element.isNull) needClear.add(element);
    }
    // 移除非法数据
    dataSource.attribute.removeAll(needClear);
    // 清除相同条件
    Set<String> sortId = {};
    // 清除相同条件后的最终条件
    List<SortValue> finalSort = [];
    for (SortValue element in dataSource.attribute.value) {
      if (element.isNull) continue;
      // 用名称和操作符作为唯一标识
      String id = "${element.sort?.field}${element.sort?.op.symbol}";
      // 已经有相同条件，跳过
      if (sortId.contains(id)) continue;
      sortId.add(id);
      finalSort.add(element);
    }
    // 设置值
    dataSource.attribute.value = finalSort;
    int newLength = dataSource.attribute.value.length;
    if (oldLength != newLength) {
      RouteHelper.toast(msg: "已自动删除无效条件和重复条件");
    }
    // 提示
    args.onBack?.call();
  }

  ///  新增
  void add() {
    SortValue sortValue = SortValue();
    dataSource.attribute.add(sortValue);
    length.value = length.value + 1;
  }

  ///  移除
  void remove(int index) {
    dataSource.attribute.removeAt(index);
    length.value = length.value - 1;
  }

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "add_button",
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) => HgNeumorphicText("新增按钮，\n点击可新增排序条件"),
        ),
      ],
    );
  }

  @override
  HomePages get homePage => HomePages.attribute;

  @override
  String? get tutorialSubKey => "sort";
}

/// 排序页面
class SortEditor extends View<SortEditorLogic> with ObserverWidget {
  SortEditor({
    required String key,
    required SortEditorArgs args,
    required SortAttributeEditorDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: SortEditorLogic());
  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      title: HgNeumorphicText("排序条件"),
      // 浏览状态不限时新增按钮
      onAdd: logic.args.state == PageState.browse ? null : logic.add,
      addButtonKey: logic.addTutorialTargetKey(0, "add_button"),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 12),
      body: buildList(),
    );
  }

  /// 构建排序列表
  Widget buildList() {
    return Obx(
      () => ListView.builder(
        clipBehavior: Clip.none,
        padding: EdgeInsets.only(bottom: Get.height * 0.5),
        itemBuilder: (context, index) {
          SortValue sortValue = logic.dataSource.attribute.value[index];
          return Container(
            clipBehavior: Clip.none,
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: SortValueItem(
              key: sortValue.hashCode.toString(),
              args: SortValueArgs(
                navigatorId: logic.args.navigatorId,
                onRemove: () => logic.remove(index),
                state: logic.args.state,
              ),
              dataSource: SortValueDataSource(sortValue: sortValue),
            ),
          );
        },
        itemCount: logic.length.value,
      ),
    );
  }
}
