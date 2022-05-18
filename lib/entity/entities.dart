import 'config/attribute/priority_list_config.dart';
import 'config/attribute/status_list_config.dart';
import 'config/attribute/tag_list_config.dart';
import 'config/cloud/cloud_config.dart';
import 'config/event/event_config.dart';
import 'config/quickaccess/quickaccess_config.dart';
import 'config/schedule/schedule_config.dart';
import 'config/theme/neumorphic.dart';
import 'config/theme/theme.dart';
import 'data/event.dart';
import 'data/focus.dart';
import 'data/notice.dart';
import 'data/priority.dart';
import 'data/status.dart';
import 'data/status_history_record.dart';
import 'data/tag.dart';
import 'data/timing.dart';
import 'value/event_content.dart';
import 'value/filter_datetime.dart';
import 'value/focus_mode_value.dart';
import 'value/icon_value.dart';
import 'value/page_value.dart';
import 'value/repeat_rule.dart';
import 'value/status_record_source.dart';
import 'value/theme_data_value.dart';

export 'config/attribute/attribute_list_config.dart';
export 'config/attribute/priority_list_config.dart';
export 'config/attribute/status_list_config.dart';
export 'config/attribute/tag_list_config.dart';
export 'config/cloud/cloud_config.dart';
export 'config/event/event_config.dart';
export 'config/quickaccess/quickaccess_config.dart';
export 'config/schedule/schedule_config.dart';
export 'config/theme/neumorphic.dart';
export 'config/theme/neumorphic.dart';
export 'config/theme/theme.dart';
export 'data/event.dart';
export 'data/event_attribute.dart';
export 'data/focus.dart';
export 'data/notice.dart';
export 'data/priority.dart';
export 'data/status.dart';
export 'data/status_history_record.dart';
export 'data/tag.dart';
export 'data/timing.dart';
export 'enum/event_filter.dart';
export 'enum/filter_datetime_type.dart';
export 'enum/focus_mode.dart';
export 'enum/icon_type.dart';
export 'enum/notice_type.dart';
export 'enum/repeat_unit.dart';
export 'enum/status_record_source_type.dart';
export 'enum/theme_type.dart';
export 'value/event_content.dart';
export 'value/filter_datetime.dart';
export 'value/focus_mode_value.dart';
export 'value/icon_value.dart';
export 'value/page_value.dart';
export 'value/repeat_rule.dart';
export 'value/status_record_source.dart';
export 'value/theme_data_value.dart';

/// 注册entity的构造方法
Map<Type, Object Function([Map<String, dynamic>? args])> getEntitiesMap() {
  return {
    // custom value
    Content: ([Map<String, dynamic>? args]) => Content(),
    FilterDateTime: ([Map<String, dynamic>? args]) => FilterDateTime(),
    IconValue: ([Map<String, dynamic>? args]) => IconValue(),
    RepeatRule: ([Map<String, dynamic>? args]) => RepeatRule(),
    StatusRecordSource: ([Map<String, dynamic>? args]) => StatusRecordSource(),
    FocusModeValue: ([Map<String, dynamic>? args]) => FocusModeValue(),
    PageValue: ([Map<String, dynamic>? args]) => PageValue(),
    ThemeDataValue: ([Map<String, dynamic>? args]) => ThemeDataValue(),
    // simple model
    Notice: ([Map<String, dynamic>? args]) => Notice(),
    // data model
    RepeatableTiming: ([Map<String, dynamic>? args]) => RepeatableTiming(),
    SingleTiming: ([Map<String, dynamic>? args]) {
      if (args == null || args.isEmpty || !args.containsKey(SingleTiming.originKey)) return SingleTiming();
      return SingleTiming(origin: args[SingleTiming.originKey]);
    },
    Status: ([Map<String, dynamic>? args]) => Status(),
    Priority: ([Map<String, dynamic>? args]) => Priority(),
    Tag: ([Map<String, dynamic>? args]) => Tag(),
    OriginEvent: ([Map<String, dynamic>? args]) => OriginEvent(),
    DeriveEvent: ([Map<String, dynamic>? args]) {
      if (args == null || args.isEmpty || args.containsKey(DeriveEvent.originKey)) return DeriveEvent();
      return DeriveEvent(origin: args[DeriveEvent.originKey]);
    },
    Focus: ([Map<String, dynamic>? args]) => Focus(),
    StatusHistoryRecord: ([Map<String, dynamic>? args]) => StatusHistoryRecord(),
    ThemeTemplate: ([Map<String, dynamic>? args]) => ThemeTemplate(),
    // config model
    EventConfig: ([Map<String, dynamic>? args]) => EventConfig(),
    AttributeTagListConfig: ([Map<String, dynamic>? args]) => AttributeTagListConfig(),
    AttributeStatusListConfig: ([Map<String, dynamic>? args]) => AttributeStatusListConfig(),
    AttributePriorityListConfig: ([Map<String, dynamic>? args]) => AttributePriorityListConfig(),
    CloudConfig: ([Map<String, dynamic>? args]) => CloudConfig(),
    QuickAccessConfig: ([Map<String, dynamic>? args]) => QuickAccessConfig(),
    NeumorphicThemeTemplateData: ([Map<String, dynamic>? args]) => NeumorphicThemeTemplateData(),
    ThemeConfig: ([Map<String, dynamic>? args]) => ThemeConfig(),
    ScheduleConfig: ([Map<String, dynamic>? args]) => ScheduleConfig(),
  };
}
