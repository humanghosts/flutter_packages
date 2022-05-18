import 'package:hg_orm/hg_orm.dart';

import 'entities.dart';

/// 注册entity:dao
Map<Type, Dao> getDaoMap() {
  return {
    // data
    OriginEvent: SembastDataTreeDao<OriginEvent>(),
    DeriveEvent: SembastDataTreeDao<DeriveEvent>(),
    StatusHistoryRecord: SembastSimpleDao<StatusHistoryRecord>(),
    Status: SembastDataDao<Status>(),
    Priority: SembastDataDao<Priority>(),
    Tag: SembastDataDao<Tag>(),
    Focus: SembastDataDao<Focus>(),
    ThemeTemplate: SembastDataDao<ThemeTemplate>(),
    // simple
    Notice: SembastSimpleDao<Notice>(),
    RepeatableTiming: SembastSimpleDao<RepeatableTiming>(),
    SingleTiming: SembastSimpleDao<SingleTiming>(),
    // config
    EventConfig: SembastSimpleDao<EventConfig>(),
    AttributePriorityListConfig: SembastSimpleDao<AttributePriorityListConfig>(),
    AttributeStatusListConfig: SembastSimpleDao<AttributeStatusListConfig>(),
    AttributeTagListConfig: SembastSimpleDao<AttributeTagListConfig>(),
    CloudConfig: SembastSimpleDao<CloudConfig>(),
    QuickAccessConfig: SembastSimpleDao<QuickAccessConfig>(),
    ThemeConfig: SembastSimpleDao<ThemeConfig>(),
    ScheduleConfig: SembastSimpleDao<ScheduleConfig>(),
  };
}
