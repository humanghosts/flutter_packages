import 'package:hg_entity/hg_entity.dart';

import 'entities.dart';

/// 数据模型的初始化数据
Map<Type, List<DataModel> Function()> getDataModelInitData() {
  return {
    Status: () => Status.initData,
    Tag: () => Tag.initData,
    Priority: () => Priority.initData,
    ThemeTemplate: () => ThemeTemplate.initData,
  };
}

/// 简单模型的初始化数据
Map<Type, SimpleModel Function()> getSimpleModelInitData() {
  return {
    AttributeTagListConfig: () => AttributeTagListConfig.initData,
    AttributeStatusListConfig: () => AttributeStatusListConfig.initData,
    AttributePriorityListConfig: () => AttributePriorityListConfig.initData,
    EventConfig: () => EventConfig.initData,
    QuickAccessConfig: () => QuickAccessConfig.initData,
    ThemeConfig: () => ThemeConfig.initData,
    ScheduleConfig: () => ScheduleConfig.initData,
  };
}
