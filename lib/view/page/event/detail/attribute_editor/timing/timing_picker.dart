import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

import 'derive/picker.dart';
import 'repeatable/picker.dart';

/// 时间选择参数
@immutable
class TimingPickerArgs extends ViewArgs {
  /// 导航ID
  final int? navigatorId;

  /// 页面状态
  final PageState state;

  const TimingPickerArgs({
    this.navigatorId,
    required this.state,
  });
}

/// 时间选择数据源
@immutable
class TimingPickerDataSource extends ViewDataSource {
  final Event event;

  const TimingPickerDataSource({required this.event});
}

class TimingPickerLogic extends ViewLogic<TimingPickerArgs, TimingPickerDataSource> {}

class TimingPicker extends View<TimingPickerLogic> {
  TimingPicker({
    required String key,
    required TimingPickerArgs args,
    required TimingPickerDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: TimingPickerLogic());

  @override
  Widget buildView(BuildContext context) {
    Event event = logic.dataSource.event;
    if (event is OriginEvent) {
      return RepeatableTimingPicker(
        key: logic.key,
        args: RepeatableTimingPickerArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
        dataSource: RepeatableTimingPickerDataSource(event: event),
      );
    } else if (event is DeriveEvent) {
      return DeriveTimingPicker(
        key: logic.key,
        args: DeriveTimingPickerArgs(navigatorId: logic.args.navigatorId, state: logic.args.state),
        dataSource: DeriveTimingPickerDataSource(event: event),
      );
    } else {
      return Container();
    }
  }
}
