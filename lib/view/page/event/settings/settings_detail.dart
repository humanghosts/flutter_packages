import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/event/settings/settings_base.dart';

class EventDetailSettingsLogic extends EventSettingsBuilderLogic {
  /// 默认状态更新标识
  Rx<int> defaultStatusUpdateFlag = 0.obs;
  Rx<int> defaultPriorityUpdateFlag = 0.obs;
  Rx<int> endStatusUpdateFlag = 0.obs;
  Rx<int> maxDeriveNumValue = 0.obs;

  @override
  void afterArgsUpdate() {
    defaultStatusUpdateFlag.value = 0;
    defaultPriorityUpdateFlag.value = 0;
    endStatusUpdateFlag.value = 0;
    maxDeriveNumValue.value = dataSource.config.maxDeriveNum.value;
  }

  /// 设置默认状态
  void setDefaultStatus(List<Status> status) {
    if (status.isEmpty) {
      clear(dataSource.config.defaultStatus, defaultStatusUpdateFlag);
    } else {
      dataSource.config.defaultStatus.value = status.first;
      defaultStatusUpdateFlag.value++;
    }
  }

  /// 设置默认优先级
  void setDefaultPriority(List<Priority> priority) {
    if (priority.isEmpty) {
      clear(dataSource.config.defaultPriority, defaultPriorityUpdateFlag);
    } else {
      dataSource.config.defaultPriority.value = priority.first;
      defaultPriorityUpdateFlag.value++;
    }
  }
}

/// 页面
class EventDetailSettings extends EventSettingsBuilder<EventDetailSettingsLogic> {
  EventDetailSettings({
    required String key,
    required EventSettingsBuilderArgs args,
    required EventSettingsBuilderDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: EventDetailSettingsLogic());

  @override
  String get title => "事件详情设置";

  @override
  List<Widget> buildSettings() {
    EventConfig config = logic.dataSource.config;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return [
      Text("默认值设置", style: TextStyle(color: themeData.disabledColor)),
      const Padding(padding: EdgeInsets.only(bottom: 12)),
      // 默认状态
      buildDefaultStatus(),
      const Padding(padding: EdgeInsets.only(bottom: 16)),
      // 默认优先级
      buildDefaultPriority(),
      const Padding(padding: EdgeInsets.only(bottom: 16)),
      // 结束状态
      buildStatusList(
        config.endStatus,
        logic.endStatusUpdateFlag,
        key: logic.addTutorialTargetKey(0, "settings_item"),
        commentKey: logic.addTutorialTargetKey(1, "settings_item_comment"),
      ),
      const Padding(padding: EdgeInsets.only(bottom: 16)),
      Row(
        children: [
          Text("日程设置", style: TextStyle(color: themeData.disabledColor)),
          GestureDetector(
            child: HgNeumorphicIcon(Icons.help, color: themeData.disabledColor),
            onTap: () {
              HapticFeedback.lightImpact();
              RouteHelper.overlay(SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      child: Text(
                        "多时间或重复时间的事件会基于发生时间派生具体日程。如，每天十点起床为源事件，保存之后，会根据“每天十点”这个时间，"
                        "生成指定数量的日程，如一号早上十点起床，二号早上十点起床等",
                        style: TextStyle(
                          overflow: TextOverflow.visible,
                          color: themeData.defaultTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ));
            },
          ),
        ],
      ),
      const Padding(padding: EdgeInsets.only(bottom: 12)),
      // 最大派生
      buildNumber(config.maxDeriveNum, logic.maxDeriveNumValue, max: 60, min: 1),
    ];
  }

  /// 事件新增的默认状态
  Widget buildDefaultStatus() {
    List<Status> getSelected() {
      List<Status> selected = [];
      EventConfig config = logic.dataSource.config;
      if (!config.defaultStatus.isNull) {
        selected.add(config.defaultStatus.value!);
      }
      return selected;
    }

    return buildEventAttributeRow<Status>(
      attribute: logic.dataSource.config.defaultStatus,
      updateFlag: logic.defaultStatusUpdateFlag,
      getSelected: getSelected,
      toSelected: () => toEventAttributeSelect<Status>(getSelected, logic.setDefaultStatus, logic.findAllStatus, false),
    );
  }

  /// 事件新增的默认优先级
  Widget buildDefaultPriority() {
    List<Priority> getSelected() {
      List<Priority> selected = [];
      EventConfig config = logic.dataSource.config;
      if (!config.defaultPriority.isNull) {
        selected.add(config.defaultPriority.value!);
      }
      return selected;
    }

    return buildEventAttributeRow<Priority>(
      attribute: logic.dataSource.config.defaultPriority,
      updateFlag: logic.defaultPriorityUpdateFlag,
      getSelected: getSelected,
      toSelected: () => toEventAttributeSelect<Priority>(getSelected, logic.setDefaultPriority, logic.findAllPriority, false),
    );
  }
}
