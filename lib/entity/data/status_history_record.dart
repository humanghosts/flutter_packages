import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/util/datetime_util.dart';

import '../entities.dart';

/// 状态历史类
class StatusHistoryRecord extends SimpleModel {
  static const String modelTitle = "状态历史记录";

  late final Attribute<DateTime> datetime;
  static const String datetimeKey = "datetime";

  late final CustomAttribute<StatusRecordSource> source;
  static const String sourceKey = "source";

  late final Attribute<String?> reason;
  static const String reasonKey = "reason";

  late final Attribute<String?> statusId;
  static const String statusIdKey = "status_id";

  StatusHistoryRecord({
    DateTime? datetime,
    StatusRecordSourceType? sourceType,
    Status? status,
    String? reason,
  }) {
    this.datetime = attributes.datetime(
      name: datetimeKey,
      title: "时间",
      value: datetime ?? DateTime.now(),
      dvalue: DateTime.now(),
    );
    source = attributes.custom(
      name: sourceKey,
      title: "来源",
      value: StatusRecordSource(sourceType: sourceType ?? StatusRecordSourceType.user),
      dvalue: StatusRecordSource(sourceType: StatusRecordSourceType.user),
    );
    statusId = attributes.stringNullable(name: statusIdKey, title: "状态ID", value: status?.id.value);
    this.reason = attributes.stringNullable(name: reasonKey, title: "原因", value: reason);
  }

  @override
  String toString() {
    if (statusId.isNull) return "${DateTimeUtil.format(datetime.value)}删除状态,原因是${reason.value}";
    return "${DateTimeUtil.format(datetime.value)}状态由${source.value.sourceType.toString()}修改为${statusId.value.toString()},原因是${reason.value}";
  }
}
