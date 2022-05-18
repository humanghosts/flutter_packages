import 'package:flutter/material.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/entities.dart';

import '../base/detail.dart';
import '../base/detail_custom.dart';
import '../base/detail_period.dart';
import '../base/detail_time.dart';
import 'detail_custom.dart';
import 'detail_period.dart';
import 'detail_time.dart';

class RepeatableTimingDetailLogic extends TimingDetailLogic<RepeatableTiming> {
  /// 没有时间清空重复
  @override
  void clearIllegal() {
    super.clearIllegal();
    Attribute<DateTime?> start = timing.start;
    Attribute<DateTime?> end = timing.end;
    CustomAttribute<RepeatRule> repeatRule = timing.repeatRule;
    // 无时间有重复 清空重复内容
    if (start.isNull && end.isNull) repeatRule.clear();
  }
}

/// 时间详情弹框
class RepeatableTimingDetail extends TimingDetail<RepeatableTiming, RepeatableTimingDetailLogic> {
  RepeatableTimingDetail({
    required String key,
    required TimingDetailArgs args,
    required TimingDetailDataSource<RepeatableTiming> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: RepeatableTimingDetailLogic());

  /// 构建时间
  @override
  Widget buildTime() {
    return RepeatableTimingDetailTime(
      key: logic.timing.hashCode.toString(),
      args: TimingDetailTimeArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
      dataSource: TimingDetailTimeDataSource(timing: logic.timing),
    );
  }

  /// 构建时间段
  @override
  Widget buildPeriod() {
    return RepeatableTimingDetailPeriod(
      key: logic.timing.hashCode.toString(),
      args: TimingDetailPeriodArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
      dataSource: TimingDetailPeriodDataSource(timing: logic.timing),
    );
  }

  /// 构建自定义时间
  @override
  Widget buildCustom() {
    return RepeatableTimingDetailCustom(
      key: logic.timing.hashCode.toString(),
      args: TimingDetailCustomArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
      dataSource: TimingDetailCustomDataSource(timing: logic.timing),
    );
  }
}
