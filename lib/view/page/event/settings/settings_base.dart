import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/export.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

@immutable
class EventSettingsBuilderArgs extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 返回回调
  final VoidCallback? onBack;

  const EventSettingsBuilderArgs({
    required this.navigatorId,
    this.onBack,
  });
}

@immutable
class EventSettingsBuilderDataSource extends ViewDataSource {
  final EventConfig config;

  const EventSettingsBuilderDataSource({required this.config});
}

/// 逻辑控制器
abstract class EventSettingsBuilderLogic extends TutorialViewLogic<EventSettingsBuilderArgs, EventSettingsBuilderDataSource> {
  /// 状态服务
  static final StatusService _statusService = StatusService.instance;

  /// 优先级服务
  static final PriorityService _priorityService = PriorityService.instance;

  /// 返回按钮
  void back() {
    RouteHelper.back(id: args.navigatorId);
  }

  /// 打开回调
  @override
  void afterArgsUpdate();

  /// 清空字段
  void clear(Attribute attribute, Rx<int> updateFlag) {
    attribute.clear();
    updateFlag.value++;
  }

  /// 查询所有状态
  Future<List<Status>> findAllStatus() async {
    return await _statusService.find();
  }

  /// 查询所有优先级
  Future<List<Priority>> findAllPriority() async {
    return await _priorityService.find();
  }

  /// 设置状态
  void setStatusList(List<Status> status, ListAttribute<Status> attribute, Rx<int> updateFlag) {
    attribute.clear();
    attribute.addAll(status);
    updateFlag.value++;
  }

  /// 设置bool值
  void setBool(bool value, Attribute<bool> attribute, Rx<bool> rxValue, {VoidCallback? afterSet}) {
    attribute.value = value;
    rxValue.value = value;
    HapticFeedback.selectionClick();
    afterSet?.call();
  }

  /// number控制
  bool isButtonPush = false;

  @override
  String? get tutorialSubKey => "settings_item";

  @override
  HomePages get homePage => HomePages.event;

  @override
  void buildTutorial() {
    buildAndAddTargetFocus(
      "settings_item",
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("设置项，\n用于设置事件或事件列表相关属性"),
        ),
      ],
    );
    buildAndAddTargetFocus(
      "settings_item_comment",
      shape: ShapeLightFocus.Circle,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => HgNeumorphicText("设置项提示，\n点击可查看设置项说明"),
        ),
      ],
    );
  }
}

abstract class EventSettingsBuilder<T extends EventSettingsBuilderLogic> extends View<T> {
  EventSettingsBuilder({
    required String key,
    required EventSettingsBuilderArgs args,
    required EventSettingsBuilderDataSource dataSource,
    required T newLogic,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: newLogic);

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      title: HgNeumorphicText(title),
      body: ListView(
        clipBehavior: Clip.none,
        padding: EdgeInsets.only(bottom: Get.height * 0.5),
        children: buildSettings(),
      ),
    );
  }

  /// 设置标题
  String get title;

  /// 构建设置项
  List<Widget> buildSettings();

  /// 构建布尔类型设置
  Widget buildBool(
    Attribute<bool> attribute,
    Rx<bool> rx, {
    VoidCallback? afterSet,
    GlobalKey? key,
    GlobalKey? commentKey,
  }) {
    return NeumorphicFormField(
      title: Text(attribute.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      comment: attribute.comment,
      fieldStyle: NeumorphicStyle(disableDepth: true, boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18))),
      child: Obx(
        () => NeumorphicSwitch(
          value: rx.value,
          onChanged: (value) => logic.setBool(value, attribute, rx, afterSet: afterSet),
        ),
      ),
    );
  }

  /// 构建数字类型
  Widget buildNumber(Attribute<int> attribute, Rx<int> rx, {required int max, required int min}) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return NeumorphicFormField(
      title: Text(attribute.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      comment: attribute.comment,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HgNeumorphicButton(
            child: HgNeumorphicIcon(Icons.remove),
            onPressed: () {
              if (attribute.value > min) {
                attribute.value = attribute.value - 1;
                logic.isButtonPush = true;
                rx.value = attribute.value;
              }
            },
          ),
          Listener(
            child: Neumorphic(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Obx(
                () {
                  return NumberPicker(
                    axis: Axis.horizontal,
                    onChanged: (int value) {
                      if (logic.isButtonPush) return;
                      attribute.value = value;
                      rx.value = attribute.value;
                      HapticFeedback.selectionClick();
                    },
                    itemWidth: 50,
                    itemHeight: 50 / 0.618,
                    value: rx.value,
                    maxValue: max,
                    minValue: min,
                    selectedTextStyle: TextStyle(color: themeData.defaultTextColor, fontSize: 16, fontWeight: FontWeight.w500),
                    textStyle: TextStyle(color: themeData.disabledColor, fontSize: 12, fontWeight: FontWeight.w300),
                  );
                },
              ),
            ),
            onPointerDown: (event) {
              logic.isButtonPush = false;
            },
          ),
          HgNeumorphicButton(
            child: HgNeumorphicIcon(Icons.add),
            onPressed: () {
              if (attribute.value < max) {
                attribute.value = attribute.value + 1;
                logic.isButtonPush = true;
                rx.value = attribute.value;
              }
            },
          ),
        ],
      ),
    );
  }

  /// 构建状态列表属性
  Widget buildStatusList(
    ListAttribute<Status> attribute,
    Rx<int> rx, {
    GlobalKey? key,
    GlobalKey? commentKey,
  }) {
    return buildEventAttributeRow<Status>(
      attribute: attribute,
      updateFlag: rx,
      key: key,
      commentKey: commentKey,
      getSelected: () => attribute.value,
      toSelected: () => toEventAttributeSelect<Status>(
        () => attribute.value,
        (statusList) => logic.setStatusList(statusList, attribute, rx),
        logic.findAllStatus,
        true,
      ),
    );
  }

  /// 构建模型列表属性
  Widget buildEventAttributeRow<M extends EventAttribute>({
    required Attribute attribute,
    required Rx<int> updateFlag,
    List<M> Function()? getSelected,
    VoidCallback? toSelected,
    GlobalKey? key,
    GlobalKey? commentKey,
  }) {
    return NeumorphicFormField(
      key: key,
      title: Text(attribute.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      comment: attribute.comment,
      commentKey: commentKey,
      onTap: toSelected,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextFormField(onTap: toSelected, maxLines: 1, decoration: InputDecoration(hintText: '${attribute.title}选择'), readOnly: true),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Obx(() {
              int updateFlagValue = updateFlag.value;
              debugPrint("${attribute.title}更新次数:$updateFlagValue");
              List<Widget> children = [];
              List<M> selected = getSelected?.call() ?? [];
              NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
              for (M model in selected) {
                children.add(HgNeumorphicChip(
                  avatar: Neumorphic(child: Logo(iconValue: model.icon.value, size: 20), style: NeumorphicStyle(depth: min(1, themeData.depth))),
                  label: Container(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(model.toString()),
                  ),
                  onTap: () {},
                ));
                children.add(const Padding(padding: EdgeInsets.only(right: 8)));
              }
              return Row(children: children);
            }),
          ),
          Positioned(right: 0, child: buildCleatButton(attribute, updateFlag)),
        ],
      ),
    );
  }

  /// 状态多选
  void toEventAttributeSelect<M extends EventAttribute>(
    List<M> Function()? getSelectedStatus,
    Function(List<M> statusList)? onBack,
    Future<List<M>> Function() find,
    bool isMulti,
  ) async {
    List<M> modelList = await find();
    List<int> selected = [];
    getSelectedStatus?.call().forEach((status) {
      selected.add(modelList.indexWhere((e) => e.id.value == status.id.value));
    });
    HapticFeedback.lightImpact();
    RouteHelper.to(
      page: MultiSelect(
        key: "event_settings_status_select",
        args: MultiSelectArgs(
            title: "优先级",
            navigatorId: logic.args.navigatorId,
            itemCount: modelList.length,
            isMulti: isMulti,
            canBeEmpty: true,
            itemBuilder: (context, index, isSelect, action) {
              M model = modelList[index];
              return buildOneEventAttributeSelect(model);
            },
            onBack: (List<int> indexList) {
              List<M> selectedList = indexList.map((e) => modelList[e]).toList();
              onBack?.call(selectedList);
            }),
        dataSource: MultiSelectDataSource(selected: selected),
      ),
      id: logic.args.navigatorId,
    );
  }

  /// 构建单个可选择的属性
  Widget buildOneEventAttributeSelect(EventAttribute model) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    // 名称
    Widget mainTitle = Text(model.toString());
    // 描述
    Widget? subTitle = model.content.isNull ? null : Text(model.content.value!, style: TextStyle(color: themeData.disabledColor));
    List<Widget> columnChildren = [mainTitle];
    if (null != subTitle) columnChildren.add(subTitle);
    // 图标
    Widget leading = Neumorphic(
      style: NeumorphicStyle(depth: -themeData.depth),
      child: Logo(iconValue: model.icon.value),
    );
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: leading,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnChildren,
      ),
    );
  }

  /// 构建清空按钮
  Widget buildCleatButton(Attribute attribute, Rx<int> updateFlag) {
    return Obx(() {
      int updateFlagValue = updateFlag.value;
      debugPrint("${attribute.title}更新次数:$updateFlagValue");
      if (attribute.isNull) return Container();
      return HgNeumorphicButton(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(right: 16),
        style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
        child: HgNeumorphicIcon(Icons.clear),
        onPressed: () => logic.clear(attribute, updateFlag),
      );
    });
  }
}
