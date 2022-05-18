import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/ability/route/route.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/main.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/event/card/card.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 外部参数
@immutable
class EventSelectListArgs<T extends Event> extends ViewArgs {
  /// 导航id
  final int navigatorId;

  /// 上级导航id
  final int parentNavigatorId;

  /// 返回回调
  final ValueChanged<List<T>>? onDone;

  const EventSelectListArgs({
    required this.navigatorId,
    required this.parentNavigatorId,
    this.onDone,
  });
}

@immutable
class EventSelectListDataSource<T extends Event> extends ViewDataSource {
  final EventConfig config;
  final T event;

  const EventSelectListDataSource({
    required this.config,
    required this.event,
  });
}

/// 逻辑
abstract class EventSelectListLogic<T extends Event> extends ViewLogic<EventSelectListArgs<T>, EventSelectListDataSource<T>> {
  /// 所有事件更新标识
  Rx<int> listUpdateFlag = 0.obs;

  /// 所有事件
  List<T> dataList = [];

  /// 选择的事件
  List<T> selectedList = [];
  Set<String> selectedId = {};

  /// 选择事件更新标识
  Rx<int> selectedUpdateFlag = 0.obs;

  /// 事件服务
  EventService get service;

  /// 下拉刷新控制器
  RefreshController refreshController = RefreshController();

  /// 返回
  void back() {
    RouteHelper.back(id: args.parentNavigatorId);
  }

  /// 打开回调
  @override
  void afterArgsUpdate() {
    listUpdateFlag.value = 0;
    selectedUpdateFlag.value = 0;
    refreshController = RefreshController();
    selectedList.clear();
    selectedId.clear();
    selectedUpdateFlag.value++;
    findChildList();
  }

  /// 查询非当前事件上下级的根事件
  Future<void> findChildList() async {
    String fullPath = dataSource.event.fullPath.value;
    List<String> pathList = fullPath.split(dataSource.event.fullPathDivider);
    String rootPath = pathList[0];
    dataList = await service.findTree(filter: SingleFilter.notMatchesStart(field: dataSource.event.fullPath.name, value: rootPath)) as List<T>;
    listUpdateFlag.value++;
    refreshController.refreshCompleted();
  }

  /// 事件选择
  void done() {
    back();
    args.onDone?.call(selectedList);
  }

  /// 选择事件
  void onSelect(int index) {
    T select = dataList[index];
    if (selectedId.contains(select.id.value)) return;
    selectedList.add(select);
    selectedId.add(select.id.value);
  }

  /// 取消选择事件
  void onUnSelect(int index) {
    T unSelect = dataList[index];
    selectedList.removeWhere((element) => element.id.value == unSelect.id.value);
    selectedId.add(unSelect.id.value);
  }
}

/// 事件列表
abstract class EventSelectList<M extends Event, L extends EventSelectListLogic<M>> extends View<L> {
  EventSelectList({
    required String key,
    required EventSelectListArgs<M> args,
    required EventSelectListDataSource<M> dataSource,
    required L newLogic,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: newLogic);

  @override
  Widget buildView(BuildContext context) {
    return HgNeumorphicScaffold(
      leading: HgNeumorphicBackButton(onPressed: logic.back),
      trailing: HgNeumorphicDoneButton(onPressed: logic.done),
      title: HgNeumorphicText("事件列表"),
      body: buildSmartRefresher(),
      bodyPadding: const EdgeInsets.only(top: 12),
    );
  }

  /// 构建列表刷新器
  Widget buildSmartRefresher() {
    return SafeArea(
      bottom: false,
      child: SmartRefresher(
        key: ValueKey(logic.key),
        controller: logic.refreshController,
        child: buildBaseEventList(),
        onRefresh: () {
          HapticFeedback.lightImpact();
          logic.findChildList();
        },
      ),
    );
  }

  /// 构建历史记录
  Widget buildBaseEventList() {
    NeumorphicThemeData themeData = MainLogic.instance.neumorphicThemeData;
    return Obx(() {
      int listUpdateFlag = logic.listUpdateFlag.value;
      debugPrint("事件列表更新次数：$listUpdateFlag");
      int selectedUpdateFlag = logic.selectedUpdateFlag.value;
      debugPrint("选中事件列表更新次数：$selectedUpdateFlag");
      if (logic.dataList.isEmpty) {
        return Center(child: Text("无事件", style: TextStyle(color: themeData.disabledColor)));
      }
      List<int> selected = [];
      for (int i = 0; i < logic.dataList.length; i++) {
        M data = logic.dataList[i];
        bool isSelected = logic.selectedId.contains(data.id.value);
        if (isSelected) selected.add(i);
      }
      return MultiSelect(
        key: "focus_event_select",
        args: MultiSelectArgs(
          title: "事件",
          navigatorId: logic.args.navigatorId,
          itemCount: logic.dataList.length,
          isMulti: true,
          canBeEmpty: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const ClampingScrollPhysics(),
          mode: MultiSelectMode.widget,
          itemBuilder: (context, index, isSelect, action) {
            return buildEvent(logic.dataList[index], isSelect, () => action(index, !isSelect));
          },
          onSelect: logic.onSelect,
          onUnSelect: logic.onUnSelect,
        ),
        dataSource: MultiSelectDataSource(selected: selected),
      );
    });
  }

  /// 事件
  Widget buildEvent(M event, bool isSelected, Function() onTap) {
    return EventCard<M>(
      key: logic.key + event.id.value,
      args: EventCardArgs(
        state: PageState.browse,
        onTap: (event) => onTap(),
        style: const NeumorphicStyle(disableDepth: true),
      ),
      dataSource: EventCardDataSource(event: event, config: logic.dataSource.config),
    );
  }
}
