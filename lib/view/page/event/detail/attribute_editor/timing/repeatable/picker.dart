import 'dart:math';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

import 'list.dart';

/// 时间选择参数
@immutable
class RepeatableTimingPickerArgs extends ViewArgs {
  /// 导航ID
  final int? navigatorId;

  /// 页面状态
  final PageState state;

  const RepeatableTimingPickerArgs({
    this.navigatorId,
    required this.state,
  });
}

/// 时间选择数据源
@immutable
class RepeatableTimingPickerDataSource extends ViewDataSource {
  final OriginEvent event;

  const RepeatableTimingPickerDataSource({required this.event});
}

class RepeatableTimingPickerLogic extends ViewLogic<RepeatableTimingPickerArgs, RepeatableTimingPickerDataSource> {
  /// 更改返回
  void onListBack() {
    update();
  }
}

/// 时间选择
class RepeatableTimingPicker extends View<RepeatableTimingPickerLogic> {
  RepeatableTimingPicker({
    required String key,
    required RepeatableTimingPickerArgs args,
    required RepeatableTimingPickerDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: RepeatableTimingPickerLogic());

  @override
  Widget buildView(BuildContext context) {
    List<RepeatableTiming> timingList = logic.dataSource.event.timingList.value;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    Widget label;
    String tooltip = "";
    bool fullScreenTooltip;
    if (timingList.isEmpty) {
      label = buildEmpty();
      tooltip = logic.dataSource.event.timingList.title;
      fullScreenTooltip = false;
    } else {
      List<Widget> children = [];
      for (int i = 0; i < timingList.length; i++) {
        RepeatableTiming timing = timingList[i];
        // 构建单个时间
        children.add(Padding(padding: const EdgeInsets.symmetric(horizontal: 2), child: buildTimingItem(timing)));
        tooltip += "${i + 1}.\n${timing.toStringWithNotice()}";
        if (i != timingList.length - 1) {
          children.add(SizedBox(height: 30, child: VerticalDivider(width: 12, color: themeData.disabledColor, thickness: 2)));
          tooltip += "\n";
        }
      }
      label = Stack(
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
          Container(padding: const EdgeInsets.symmetric(horizontal: 2), child: Row(children: children)),
        ],
      );
      fullScreenTooltip = true;
    }
    return HgNeumorphicChip(
      label: label,
      onTap: showTimingList,
      getTooltip: () => tooltip,
      fullScreenTooltip: fullScreenTooltip,
      style: NeumorphicStyle(depth: fullScreenTooltip ? -themeData.depth : themeData.depth),
    );
  }

  Widget buildEmpty() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Column(
      children: [
        // 图标
        Neumorphic(
          style: NeumorphicStyle(depth: min(1, themeData.depth)),
          child: Logo(iconValue: IconValue.fontIcon(iconData: Icons.calendar_today, backgroundColor: Colors.white, iconColor: Colors.black54), size: 30),
        ),
        const Padding(padding: EdgeInsets.only(top: 2)),
        // 文字
        Container(
          alignment: Alignment.center,
          width: 40,
          child: Text(logic.dataSource.event.timingList.title, style: TextStyle(color: themeData.disabledColor)),
        ),
      ],
    );
  }

  /// 构建单个时间组件
  Widget buildTimingItem(RepeatableTiming timing) {
    List<Widget> dateTime = [];
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
        dateTime.add(Row(children: subChildren));
      }
    }
    List<Widget> children = [Column(crossAxisAlignment: CrossAxisAlignment.start, children: dateTime)];

    // 重复标识
    if (!timing.repeatRule.isNull) children.add(HgNeumorphicIcon(Icons.refresh));

    return Row(children: children);
  }

  /// 打开提醒列表
  void showTimingList() {
    if (logic.args.navigatorId == null) {
      RouteHelper.cupertinoBottomSheet(sheet: timingList(), barrierColor: Colors.transparent);
    } else {
      RouteHelper.to(page: timingList(), id: logic.args.navigatorId);
    }
  }

  /// 提醒列表组件
  Widget timingList() {
    return TimingList(
      key: logic.key,
      args: TimingListArgs(
        navigatorId: logic.args.navigatorId,
        onBack: logic.onListBack,
        state: logic.args.state,
      ),
      dataSource: TimingListDataSource(
        timingListAttribute: logic.dataSource.event.timingList,
      ),
    );
  }
}
