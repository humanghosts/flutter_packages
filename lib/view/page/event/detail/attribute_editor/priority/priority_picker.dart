import 'dart:math';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';

@immutable
class PriorityPickerArgs extends ViewArgs {
  /// 导航id
  final int? navigatorId;

  /// 页面状态
  final PageState state;

  const PriorityPickerArgs({
    this.navigatorId,
    required this.state,
  });
}

@immutable
class PriorityPickerDataSource extends ViewDataSource {
  final Event event;

  const PriorityPickerDataSource({required this.event});
}

/// 逻辑
class PriorityPickerLogic extends ViewLogic<PriorityPickerArgs, PriorityPickerDataSource> {
  final PriorityService _priorityService = PriorityService.instance;

  /// 查询所有优先级
  Future<List<Priority>> findAllPriority() async {
    return await _priorityService.find();
  }

  /// 优先级变化
  void setPriority(List<Priority> priorityList) {
    dataSource.event.priority.value = priorityList.isEmpty ? null : priorityList[0];
    update();
  }
}

/// 时间选择器
/// 分为开始时间和结束时间
class PriorityPicker extends View<PriorityPickerLogic> {
  PriorityPicker({
    required String key,
    required PriorityPickerArgs args,
    required PriorityPickerDataSource dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: PriorityPickerLogic());

  @override
  Widget buildView(BuildContext context) {
    Priority? priority = logic.dataSource.event.priority.value;
    Widget label;
    IconValue hgIcon;
    String tooltip = "";
    bool fullScreenTooltip;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    if (null == priority) {
      label = Text(logic.dataSource.event.priority.title, style: TextStyle(color: themeData.disabledColor));
      hgIcon = IconValue.fontIcon(iconData: Icons.flag, iconColor: Colors.black54, backgroundColor: Colors.white);
      tooltip = logic.dataSource.event.priority.title;
      fullScreenTooltip = false;
    } else {
      label = Text(priority.toString());
      hgIcon = priority.icon.value;
      tooltip = priority.toString();
      fullScreenTooltip = true;
    }
    return HgNeumorphicChip(
      label: Column(
        children: [
          Neumorphic(style: NeumorphicStyle(depth: min(1, themeData.depth)), child: Logo(iconValue: hgIcon, size: 30)),
          const Padding(padding: EdgeInsets.only(top: 2)),
          Container(alignment: Alignment.center, width: 50, child: label),
        ],
      ),
      onTap: toPrioritySelect,
      style: NeumorphicStyle(depth: fullScreenTooltip ? -themeData.depth : themeData.depth),
      getTooltip: () => tooltip,
      fullScreenTooltip: fullScreenTooltip,
    );
  }

  void toPrioritySelect() async {
    if (logic.args.state == PageState.browse) {
      return;
    }
    List<Priority> priorityList = [];
    priorityList = await logic.findAllPriority();
    List<int> selected = [];
    Priority? value = logic.dataSource.event.priority.value;
    if (null != value) {
      selected.add(priorityList.indexWhere((element) => element.id.value == value.id.value));
    }
    if (logic.args.navigatorId == null) {
      RouteHelper.cupertinoBottomSheet(sheet: prioritySelect(selected, priorityList));
    } else {
      RouteHelper.to(
        page: prioritySelect(selected, priorityList),
        id: logic.args.navigatorId,
      );
    }
  }

  Widget prioritySelect(List<int> selected, List<Priority> priorityList) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return MultiSelect(
      key: "event_priority_select",
      args: MultiSelectArgs(
          title: "优先级",
          isMulti: false,
          navigatorId: logic.args.navigatorId,
          itemCount: priorityList.length,
          canBeEmpty: true,
          itemBuilder: (context, index, isSelect, action) {
            Priority model = priorityList[index];
            // 名称
            Widget mainTitle = Text(model.toString(), style: const TextStyle(fontSize: 16));
            // 描述
            Widget? subTitle = model.content.isNull ? null : Text(model.content.value!, style: TextStyle(color: themeData.disabledColor, fontSize: 12));
            List<Widget> columnChildren = [mainTitle];
            if (null != subTitle) columnChildren.add(subTitle);
            // 图标
            Widget leading = Neumorphic(style: NeumorphicStyle(depth: -themeData.depth), child: Logo(iconValue: model.icon.value));
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: leading,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: columnChildren,
              ),
            );
          },
          onBack: (List<int> indexList) {
            List<Priority> selectedList = indexList.map((e) => priorityList[e]).toList();
            logic.setPriority(selectedList);
          }),
      dataSource: MultiSelectDataSource(
        selected: selected,
      ),
    );
  }
}
