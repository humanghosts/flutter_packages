import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/event/settings/settings_base.dart';

class EventTreeSettingsLogic extends EventSettingsBuilderLogic {
  Rx<int> actionsUpdateFlag = 0.obs;
  Rx<int> secondaryActionsUpdateFlag = 0.obs;
  Rx<int> groupFiledUpdateFlag = 0.obs;

  /// 分组字段
  List<String> groupField = [];

  /// 模型例子
  late DeriveEvent sampleModel;

  /// 构造
  EventTreeSettingsLogic() {
    sampleModel = ConstructorCache.get(DeriveEvent);
    groupField.addAll([sampleModel.status.name, sampleModel.priority.name]);
  }

  @override
  void afterArgsUpdate() {
    actionsUpdateFlag.value = 0;
    secondaryActionsUpdateFlag.value = 0;
    groupFiledUpdateFlag.value = 0;
  }

  /// 设置分组字段
  void setGroupField(int index) {
    String name = groupField[index];
    dataSource.config.groupField.value = name;
    groupFiledUpdateFlag.value++;
  }
}

/// 页面
class EventTreeSettings extends EventSettingsBuilder<EventTreeSettingsLogic> {
  EventTreeSettings({
    required String key,
    required EventSettingsBuilderArgs args,
    required EventSettingsBuilderDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: EventTreeSettingsLogic());

  @override
  String get title => "事件列表设置";

  @override
  List<Widget> buildSettings() {
    EventConfig config = logic.dataSource.config;
    return [
      // 分组字段
      buildGroupField(),
      const Padding(padding: EdgeInsets.only(bottom: 16)),
      // 主要动作
      buildStatusList(config.actions, logic.actionsUpdateFlag),
      const Padding(padding: EdgeInsets.only(bottom: 16)),
      // 次要动作
      buildStatusList(config.secondaryActions, logic.secondaryActionsUpdateFlag),
      const Padding(padding: EdgeInsets.only(bottom: 16)),
    ];
  }

  /// 构建分组字段
  Widget buildGroupField() {
    return Obx(() {
      int groupFiledUpdateFlag = logic.groupFiledUpdateFlag.value;
      debugPrint("分组字段更新次数:$groupFiledUpdateFlag");
      EventConfig config = logic.dataSource.config;
      String? field = logic.dataSource.config.groupField.value;
      String? initValue = logic.sampleModel.attributes.get(field)?.title;
      return NeumorphicFormField(
        key: logic.addTutorialTargetKey(0, "settings_item"),
        commentKey: logic.addTutorialTargetKey(1, "settings_item_comment"),
        title: Text(config.groupField.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        hintText: "选择${config.groupField.title}",
        initValue: initValue,
        comment: config.groupField.comment,
        onTap: toGroupFieldSelect,
        onClear: initValue == null ? null : () => logic.clear(logic.dataSource.config.groupField, logic.groupFiledUpdateFlag),
      );
    });
  }

  /// 选择分组字段
  void toGroupFieldSelect() {
    List<int> selected = [];
    String? name = logic.dataSource.config.groupField.value;
    if (null != name) {
      selected.add(logic.groupField.indexOf(name));
    }
    RouteHelper.to(
      id: logic.args.navigatorId,
      page: MultiSelect(
        key: "event_settings_group_field_select",
        args: MultiSelectArgs(
          title: "分组字段",
          navigatorId: logic.args.navigatorId,
          itemCount: logic.groupField.length,
          itemBuilder: (context, index, isSelect, action) {
            String field = logic.groupField[index];
            String title = logic.sampleModel.attributes.get(field)!.title;
            return Text(title);
          },
          canBeEmpty: true,
          onBack: (indexList) {
            if (indexList.isEmpty) {
              logic.clear(logic.dataSource.config.groupField, logic.groupFiledUpdateFlag);
            } else {
              logic.setGroupField(indexList.first);
            }
          },
        ),
        dataSource: MultiSelectDataSource(selected: selected),
      ),
    );
  }
}
