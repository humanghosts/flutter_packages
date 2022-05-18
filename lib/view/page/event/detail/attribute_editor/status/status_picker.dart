import 'dart:math';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/data/attribute/status.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/event/detail/detail_derive.dart';
import 'package:hg_logger/view/page/event/detail/detail_event.dart';
import 'package:hg_logger/view/page/event/detail/detail_origin.dart';

@immutable
class StatusPickerArgs extends ViewArgs {
  /// 导航id
  final int? navigatorId;

  /// 页面状态
  final PageState state;

  const StatusPickerArgs({
    this.navigatorId,
    required this.state,
  });
}

@immutable
class StatusPickerDataSource extends ViewDataSource {
  /// 事件
  final Event event;

  const StatusPickerDataSource({required this.event});
}

class StatusPickerLogic extends ViewLogic<StatusPickerArgs, StatusPickerDataSource> {
  final StatusService _statusService = StatusService.instance;

  /// 查询所有优先级
  Future<List<Status>> findAllStatus() async {
    return await _statusService.find();
  }

  /// 优先级变化
  void setStatus(List<Status> statusList) {
    dataSource.event.status.value = statusList.isEmpty ? null : statusList[0];
    StatusHistoryRecord record = dataSource.event.statusHistory.value.last;
    if (statusList.isEmpty) {
      dataSource.event.statusHistory.add(
        StatusHistoryRecord(sourceType: StatusRecordSourceType.user, reason: "新增事件用户修改"),
      );
    } else {
      if (record.statusId.value != statusList[0].id.value) {
        dataSource.event.statusHistory.add(
          StatusHistoryRecord(sourceType: StatusRecordSourceType.user, status: statusList[0], reason: "新增事件用户修改"),
        );
        EventDetailLogic? detailLogic;
        if (dataSource.event is DeriveEvent) {
          bool isRegistered = Get.isRegistered<DeriveEventDetailLogic>(tag: key);
          if (isRegistered) {
            detailLogic = Get.find<DeriveEventDetailLogic>(tag: key);
          }
        } else {
          bool isRegistered = Get.isRegistered<OriginEventDetailLogic>(tag: key);
          if (isRegistered) {
            detailLogic = Get.find<OriginEventDetailLogic>(tag: key);
          }
        }
        detailLogic?.findStatusHistory();
      }
    }
    update();
  }
}

class StatusPicker extends View<StatusPickerLogic> {
  StatusPicker({
    required String key,
    required StatusPickerDataSource dataSource,
    required StatusPickerArgs args,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: StatusPickerLogic());

  @override
  Widget buildView(BuildContext context) {
    Status? status = logic.dataSource.event.status.value;
    Widget label;
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    String tooltip = "";
    IconValue hgIcon;
    bool fullScreenTooltip;
    if (null == status) {
      label = Text(logic.dataSource.event.status.title, style: TextStyle(color: themeData.disabledColor));
      hgIcon = IconValue.text(text: "无", iconColor: Colors.black54, backgroundColor: Colors.white);
      tooltip = logic.dataSource.event.status.title;
      fullScreenTooltip = false;
    } else {
      hgIcon = status.icon.value;
      label = Text(status.toString());
      tooltip = status.toString();
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
      getTooltip: () => tooltip,
      fullScreenTooltip: fullScreenTooltip,
      style: NeumorphicStyle(
          depth: logic.args.state == PageState.add
              ? fullScreenTooltip
                  ? -themeData.depth
                  : themeData.depth
              : 0),
      onTap: logic.args.state == PageState.add ? toStatusSelect : null,
    );
  }

  /// 状态选择
  void toStatusSelect() async {
    if (logic.args.state == PageState.browse) return;
    List<Status> statusList = [];
    statusList = await logic.findAllStatus();
    List<int> selected = [];
    Status? value = logic.dataSource.event.status.value;
    if (null != value) {
      selected.add(statusList.indexWhere((element) => element.id.value == value.id.value));
    }
    if (logic.args.navigatorId == null) {
      RouteHelper.cupertinoBottomSheet(sheet: statusSelect(selected, statusList));
    } else {
      RouteHelper.to(
        page: statusSelect(selected, statusList),
        id: logic.args.navigatorId,
      );
    }
  }

  /// 状态选择组件
  Widget statusSelect(List<int> selected, List<Status> statusList) {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return MultiSelect(
      key: "event_status_select",
      args: MultiSelectArgs(
          title: "状态",
          isMulti: false,
          navigatorId: logic.args.navigatorId,
          itemCount: statusList.length,
          canBeEmpty: true,
          itemBuilder: (context, index, isSelect, action) {
            Status model = statusList[index];
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
            List<Status> selectedList = indexList.map((e) => statusList[e]).toList();
            logic.setStatus(selectedList);
          }),
      dataSource: MultiSelectDataSource(selected: selected),
    );
  }
}
