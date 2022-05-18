import 'package:flutter/material.dart';
import 'package:hg_logger/entity/entities.dart';

import '../base/detail.dart';
import '../base/detail_custom.dart';
import '../base/detail_period.dart';
import '../base/detail_time.dart';

class DeriveTimingDetailLogic extends TimingDetailLogic<SingleTiming> {}

/// 时间详情弹框
class DeriveTimingDetail extends TimingDetail<SingleTiming, DeriveTimingDetailLogic> {
  DeriveTimingDetail({
    required String key,
    required TimingDetailArgs args,
    required TimingDetailDataSource<SingleTiming> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: DeriveTimingDetailLogic());

  /// 构建时间
  @override
  Widget buildTime() {
    return TimingDetailTime<SingleTiming, TimingDetailTimeLogic<SingleTiming>>(
      key: logic.timing.hashCode.toString(),
      args: TimingDetailTimeArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
      dataSource: TimingDetailTimeDataSource(timing: logic.timing),
      newLogic: TimingDetailTimeLogic<SingleTiming>(),
    );
  }

  /// 构建时间段
  @override
  Widget buildPeriod() {
    return TimingDetailPeriod<SingleTiming, TimingDetailPeriodLogic<SingleTiming>>(
      key: logic.timing.hashCode.toString(),
      args: TimingDetailPeriodArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
      dataSource: TimingDetailPeriodDataSource(timing: logic.timing),
      newLogic: TimingDetailPeriodLogic<SingleTiming>(),
    );
  }

  /// 构建自定义时间
  @override
  Widget buildCustom() {
    return TimingDetailCustom<SingleTiming, TimingDetailCustomLogic<SingleTiming>>(
      key: logic.timing.hashCode.toString(),
      args: TimingDetailCustomArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
      dataSource: TimingDetailCustomDataSource(timing: logic.timing),
      newLogic: TimingDetailCustomLogic<SingleTiming>(),
    );
  }
}
