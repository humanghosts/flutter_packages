import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/model.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

/// 参数
@immutable
class AttributeSettingsArgs extends ViewArgs {
  /// 用于设置的子导航id
  final int navigatorId;

  /// 父导航id
  final int parentNavigatorId;

  /// 确认回调
  final VoidCallback? onDone;

  const AttributeSettingsArgs({
    required this.navigatorId,
    required this.parentNavigatorId,
    this.onDone,
  });
}

/// 逻辑
abstract class AttributeSettingsLogic<M extends AttributeListConfig> extends TutorialViewLogic<AttributeSettingsArgs, ViewDataSource> {
  /// 设置数据
  M data = ConstructorCache.get(M);

  /// 实体样例
  EventAttribute? _sampleModel;

  /// 服务
  SimpleModelService<M> get service;

  /// 获取样例
  EventAttribute get sampleModel {
    _sampleModel ??= ConstructorCache.get(data.eventAttributeType);
    return _sampleModel!;
  }

  /// 完成
  void onDone() async {
    await service.save(data);
    back();
    args.onDone?.call();
  }

  /// 返回
  void back() {
    RouteHelper.back(id: args.parentNavigatorId);
  }

  /// 字段名称
  Rx<String> sortField = "字段".obs;

  /// 操作符名称
  Rx<String> sortOp = "操作符".obs;

  @override
  void afterArgsUpdate() {
    find();
  }

  /// 查找设置
  Future<void> find() async {
    data = await service.find();
    afterFind();
    update();
  }

  /// 查询后调用
  void afterFind() {
    sortField.value = data.sort.value.sort == null ? "字段" : sampleModel.attributes.get(data.sort.value.sort!.field)!.title;
    sortOp.value = data.sort.value.sort?.op.title ?? "操作符";
  }

  /// 设置排序字段
  void setSortField(List<int> indexList) {
    SortValue sortValue = data.sort.value;
    if (indexList.isEmpty) {
      sortValue.sort = null;
      sortField.value = "";
      return;
    }
    String field = data.sortFieldList[indexList.first];
    if (sortValue.isNull) {
      sortValue.sort = Sort(field: field);
    } else {
      sortValue.sort!.field = field;
    }
    sortField.value = sampleModel.attributes.get(field)!.title;
  }

  /// 设置排序符号
  void setSortOp(List<int> indexList) {
    SortValue sortValue = data.sort.value;
    if (indexList.isEmpty) {
      sortValue.sort!.op = SortOp.asc;
      sortOp.value = SortOp.asc.title;
      return;
    }
    sortValue.sort!.op = SortOp.list[indexList.first];
    sortOp.value = sortValue.sort!.op.title;
  }

  @override
  HomePages get homePage => HomePages.attribute;

  @override
  String? get tutorialSubKey => "settings";

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "sort_settings",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("事件属性列表元素排序设置，\n可设置列表元素依据那个字段和哪种规则排序"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "sort_settings_comment",
      shape: ShapeLightFocus.Circle,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("设置项提示，\n点击可查看设置项说明"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "sort_settings_field",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("列表元素排序依据字段，\n点击可选择，长按可查看已选字段"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "sort_settings_op",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("列表元素排序依据规则，\n点击可选择升序或者降序，长按可查看已选规则"),
        ),
      ],
    );
  }
}

/// 页面
abstract class AttributeSettings<M extends AttributeListConfig, L extends AttributeSettingsLogic<M>> extends View<L> {
  AttributeSettings({
    required String key,
    required AttributeSettingsArgs args,
    required L newLogic,
  }) : super(key: key, args: args, newLogic: newLogic);

  /// 设置内容
  List<Widget> get content;

  /// 页面标题
  String get title;

  /// 外层容器
  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      title: HgNeumorphicText("$title列表设置"),
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      trailing: HgNeumorphicDoneButton(onPressed: logic.onDone),
      body: buildSettings(),
    );
  }

  /// 内容
  Widget buildSettings() {
    List<Widget> children = [buildSort(), const Padding(padding: EdgeInsets.only(bottom: 16)), ...content];
    return ListView(
      clipBehavior: Clip.none,
      physics: const AlwaysScrollableScrollPhysics(),
      children: children,
    );
  }

  /// 排序设置
  Widget buildSort() {
    return NeumorphicFormField(
      key: logic.addTutorialTargetKey(0, "sort_settings"),
      title: Text(logic.data.sort.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      comment: logic.data.sort.comment,
      commentKey: logic.addTutorialTargetKey(1, "sort_settings_comment"),
      child: ListTile(
        title: Row(
          children: [
            Expanded(flex: 3, child: buildSortField()),
            Expanded(child: Container()),
            Expanded(flex: 3, child: buildSortOp()),
          ],
        ),
      ),
    );
  }

  /// 构建字段
  Widget buildSortField() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return HgNeumorphicButton(
      key: logic.addTutorialTargetKey(2, "sort_settings_field"),
      getTooltip: () => logic.sortField.value,
      fullScreenTooltip: true,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            // 定点刷新
            child: Obx(
              () => Text(
                logic.sortField.value,
                style: TextStyle(color: logic.data.sort.value.sort != null ? themeData.defaultTextColor : themeData.disabledColor),
              ),
            ),
          ),
          Expanded(flex: 0, child: HgNeumorphicNextButton(padding: const EdgeInsets.all(4), onPressed: sortFieldSelect)),
        ],
      ),
      onPressed: sortFieldSelect,
    );
  }

  /// 构建操作符
  Widget buildSortOp() {
    return Obx(() {
      SortValue sortValue = logic.data.sort.value;
      Sort? sort = sortValue.sort;
      if (logic.sortOp.value.isEmpty || sort == null) return Container();
      return HgNeumorphicButton(
        key: logic.addTutorialTargetKey(3, "sort_settings_op"),
        getTooltip: () => logic.sortOp.value,
        fullScreenTooltip: true,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: Text(logic.sortOp.value)),
            Expanded(flex: 0, child: HgNeumorphicNextButton(padding: const EdgeInsets.all(4), onPressed: sortOpSelect)),
          ],
        ),
        onPressed: sortOpSelect,
      );
    });
  }

  /// 构建字段选择
  void sortFieldSelect() {
    SortValue sortValue = logic.data.sort.value;
    List<int> selected = [];
    Sort? sort = sortValue.sort;
    if (sort != null) {
      int index = logic.data.sortFieldList.indexOf(sort.field);
      selected.add(index);
    }
    RouteHelper.to(
      page: MultiSelect(
        key: "attribute_settings_sort_field",
        args: MultiSelectArgs(
          title: "排序字段",
          navigatorId: logic.args.navigatorId,
          itemCount: logic.data.sortFieldList.length,
          itemBuilder: (context, index, isSelect, action) {
            String field = logic.data.sortFieldList[index];
            String title = logic.sampleModel.attributes.get(field)!.title;
            return Text(title);
          },
          onBack: logic.setSortField,
        ),
        dataSource: MultiSelectDataSource(selected: selected),
      ),
      id: logic.args.navigatorId,
    );
  }

  /// 构建操作符选择
  void sortOpSelect() {
    SortValue sortValue = logic.data.sort.value;
    List<int> selected = [];
    Sort? sort = sortValue.sort;
    if (null == sort) return;
    int index = SortOp.list.indexOf(sort.op);
    if (index != -1) {
      selected.add(index);
    }
    RouteHelper.to(
      page: MultiSelect(
        key: "settings_sort_op",
        args: MultiSelectArgs(
          title: "排序操作符",
          navigatorId: logic.args.navigatorId,
          itemCount: SortOp.list.length,
          itemBuilder: (context, index, isSelect, action) {
            return Text(SortOp.list[index].title);
          },
          onBack: logic.setSortOp,
        ),
        dataSource: MultiSelectDataSource(selected: selected),
      ),
      id: logic.args.navigatorId,
    );
  }
}
