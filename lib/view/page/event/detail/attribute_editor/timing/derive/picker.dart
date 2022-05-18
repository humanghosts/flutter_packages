import 'dart:math';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

import '../base/detail.dart';
import 'detail.dart';

/// 时间选择参数
@immutable
class DeriveTimingPickerArgs extends ViewArgs {
  /// 导航ID
  final int? navigatorId;

  /// 页面状态
  final PageState state;

  const DeriveTimingPickerArgs({
    this.navigatorId,
    required this.state,
  });
}

/// 时间选择数据源
@immutable
class DeriveTimingPickerDataSource extends ViewDataSource {
  final DeriveEvent event;

  const DeriveTimingPickerDataSource({required this.event});
}

class DeriveTimingPickerLogic extends ViewLogic<DeriveTimingPickerArgs, DeriveTimingPickerDataSource> {
  /// 更改返回
  void onDetailBack() {
    update();
  }
}

class DeriveTimingPicker extends View<DeriveTimingPickerLogic> {
  DeriveTimingPicker({
    required String key,
    required DeriveTimingPickerArgs args,
    required DeriveTimingPickerDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: DeriveTimingPickerLogic());

  @override
  Widget buildView(BuildContext context) {
    DeriveEvent event = logic.dataSource.event;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    Widget label;
    String tooltip = "";
    bool fullScreenTooltip;
    if (event.timing.isNull || event.timing.value!.isNull) {
      label = Column(
        children: [
          Neumorphic(
            style: NeumorphicStyle(depth: min(1, themeData.depth)),
            child: Logo(iconValue: IconValue.fontIcon(iconData: Icons.calendar_today, backgroundColor: Colors.white, iconColor: Colors.black54), size: 30),
          ),
          const Padding(padding: EdgeInsets.only(top: 2)),
          Container(
            alignment: Alignment.center,
            width: 40,
            child: Text(logic.dataSource.event.timing.title, style: TextStyle(color: themeData.disabledColor)),
          ),
        ],
      );
      tooltip = logic.dataSource.event.timing.title;
      fullScreenTooltip = false;
    } else {
      label = label = Stack(
        alignment: Alignment.centerLeft,
        children: [
          // 撑空间
          Opacity(
            opacity: 0,
            child: Column(
              children: [
                Neumorphic(
                  style: NeumorphicStyle(depth: min(1, themeData.depth)),
                  child: Logo(
                    iconValue: IconValue.fontIcon(iconData: Icons.calendar_today),
                    size: 30,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 2)),
                Container(alignment: Alignment.center, child: Text("1", style: TextStyle(color: themeData.disabledColor))),
              ],
            ),
          ),
          // 内容
          Container(child: buildTimingItem(event.timing.value!)),
        ],
      );
      tooltip = event.timing.value.toString();
      fullScreenTooltip = true;
    }
    return HgNeumorphicChip(
      label: label,
      onTap: toTimingDetail,
      getTooltip: () => tooltip,
      fullScreenTooltip: fullScreenTooltip,
      style: NeumorphicStyle(depth: fullScreenTooltip ? -themeData.depth : themeData.depth),
    );
  }

  /// 构建单个时间
  Widget buildTimingItem(Timing timing) {
    List<Widget> children = [];
    for (int i = 0; i < 2; i++) {
      Attribute<DateTime?> dta;
      ListAttribute<Notice> lin;
      if (i == 0) {
        dta = timing.start;
        lin = timing.startNotice;
      } else {
        dta = timing.end;
        lin = timing.endNotice;
      }
      if (!dta.isNull) {
        List<Widget> subChildren = [Text("${dta.title}:${DateTimeUtil.format(dta.value)}")];
        if (!lin.isNull) {
          subChildren.add(HgNeumorphicIcon(Icons.notifications));
        }
        children.add(Row(children: subChildren));
      }
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }

  /// 打开提醒列表
  void toTimingDetail() {
    if (logic.args.navigatorId == null) {
      RouteHelper.cupertinoBottomSheet(sheet: timingDetail());
    } else {
      RouteHelper.to(page: timingDetail(), id: logic.args.navigatorId);
    }
  }

  Widget timingDetail() {
    SingleTiming timing = logic.dataSource.event.timing.value!;
    return DeriveTimingDetail(
      key: timing.hashCode.toString(),
      dataSource: TimingDetailDataSource(timing: timing),
      args: TimingDetailArgs(
        state: logic.args.state,
        onBack: logic.onDetailBack,
        navigatorId: logic.args.navigatorId,
      ),
    );
  }
}
