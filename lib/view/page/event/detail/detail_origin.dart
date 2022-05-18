import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/export.dart';
import 'package:hg_logger/view/page/event/detail/derive_editor/derive_editor.dart';
import 'package:hg_logger/view/page/event/detail/detail_event.dart';
import 'package:hg_logger/view/page/event/detail/select/base_select_list.dart';

import 'detail_derive.dart';
import 'select/origin_select_list.dart';

/// 事件详情的逻辑
class OriginEventDetailLogic extends EventDetailLogic<OriginEvent> {
  /// 事件服务
  final DeriveEventService _eventService = DeriveEventService.instance;

  @override
  OriginEventService get service => OriginEventService.instance;

  /// 派生事件列表
  List<DeriveEvent> deriveList = [];

  /// 重置标识
  @override
  void beforeSuperCall() {
    super.beforeSuperCall();
    derivesUpdateFlag.value = 0;
  }

  /// 打开时触发 不需要同步
  @override
  void afterSuperCall() {
    super.afterSuperCall();
    findDerives();
  }

  /// 控制派生事件页签是否刷新
  Rx<int> derivesUpdateFlag = 0.obs;

  /// 如果是只有一个时间并且不重复的，或者没有时间的不提示同时删除派生事件
  @override
  String get canRemoveText {
    OriginEvent event = data;
    if (deriveList.isEmpty) return super.canRemoveText;
    if (event.timingList.isNull) return super.canRemoveText;
    return "删除该事件的同时会删除已添加的日程,确定删除吗?";
  }

  @override
  OriginEvent newModel() {
    return OriginEvent();
  }

  /// 查询派生事件 查询所有的 包括删除的
  /// force 表示是否强制刷新派生事件列表
  Future<void> findDerives() async {
    deriveList.clear();
    OriginEvent event = data;
    bool hasDerive = await service.hasDerive(event.id.value);
    if (hasDerive) deriveList.addAll(await _eventService.findByOriginIdWithRemovedInOrder(event.id.value));
    derivesUpdateFlag.value++;
  }

  /// 是否可以删除派生事件
  Future<bool> canDeriveRemove(DeriveEvent derive) async {
    bool? canRemove = await RouteHelper.showOneChoiceRequest();
    return canRemove == true;
  }

  /// 删除派生事件
  void removeDerive(DeriveEvent derive) async {
    if (args.state == PageState.browse) return;
    // 子事件直接删除
    await _eventService.remove(derive, isRemoveChildren: true);
    derivesUpdateFlag.value++;
  }

  @override
  void buildTutorial() {
    super.buildTutorial();
  }
}

/// 事件明细页面
class OriginEventDetail extends EventDetail<OriginEvent, OriginEventDetailLogic> {
  OriginEventDetail({
    required String key,
    required EventDetailArgs<OriginEvent> args,
    required EventDetailDataSource<OriginEvent> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: OriginEventDetailLogic());

  @override
  List<String> buildExtendsTabBar() {
    List<String> ex = [];
    if (logic.deriveList.isEmpty) return ex;
    ex.add("日程");
    return ex;
  }

  @override
  Widget buildTabBarReactive(Widget Function() child) {
    return Obx(() {
      int derivesUpdateFlag = logic.derivesUpdateFlag.value;
      debugPrint("派生事件更新次数:$derivesUpdateFlag");
      return child();
    });
  }

  @override
  List<Widget> buildExtendsTab() {
    List<Widget> ex = [];
    if (logic.deriveList.isEmpty) return ex;
    ex.add(buildDerives());
    return ex;
  }

  @override
  Widget buildTabViewReactive(Widget Function() child) {
    return Obx(() {
      int derivesUpdateFlag = logic.derivesUpdateFlag.value;
      debugPrint("派生事件更新次数:$derivesUpdateFlag");
      return child();
    });
  }

  /// 子事件新增按钮
  @override
  Widget buildChildAddButton(GlobalKey? key) {
    String expandableFabKey = logic.key;
    // 展开动画按钮
    return ExpandableFab(
      key: expandableFabKey,
      args: ExpandableFabArgs(
        tutorialKey: key,
        children: [
          ActionButton(
            child: HgNeumorphicIcon(Icons.link),
            title: "关联",
            onPressed: () {
              ExpandableFabLogic logic = Get.find<ExpandableFabLogic>(tag: expandableFabKey);
              logic.toggle();
              associateChild();
            },
          ),
          ActionButton(
            child: HgNeumorphicIcon(Icons.add),
            title: "新增",
            onPressed: () {
              ExpandableFabLogic logic = Get.find<ExpandableFabLogic>(tag: expandableFabKey);
              logic.toggle();
              quickAddChild();
            },
          ),
        ],
      ),
    );
  }

  /// 关联子事件
  void associateChild() {
    String key = "${logic.key}_origin_event_list";
    int id = key.hashCode;
    RouteHelper.bottomPageNested(
      parentId: logic.args.parentNavigatorId,
      nestedId: id,
      page: OriginSelectList(
        key: key,
        args: EventSelectListArgs(navigatorId: id, parentNavigatorId: logic.args.parentNavigatorId, onDone: logic.onChildrenAdd),
        dataSource: EventSelectListDataSource(event: logic.data, config: logic.dataSource.config),
      ),
    );
  }

  /// 构建派生事件
  Widget buildDerives() {
    return Obx(() {
      int derivesUpdateFlag = logic.derivesUpdateFlag.value;
      debugPrint("派生事件更新次数:$derivesUpdateFlag");
      return OriginDetailDeriveEditor(
        key: logic.key,
        args: OriginDetailDeriveEditorArgs(
          onTap: toDerive,
          onRemove: logic.removeDerive,
          canRemove: logic.canDeriveRemove,
          state: logic.args.state,
        ),
        dataSource: OriginDetailDeriveEditorDataSource(
          deriveList: logic.deriveList,
          config: logic.dataSource.config,
        ),
      );
    });
  }

  /// 打开派生事件
  void toDerive(DeriveEvent event) {
    RouteHelper.bottomPageNested(
      page: DeriveEventDetail(
        key: event.id.value,
        args: EventDetailArgs<DeriveEvent>(
          state: logic.args.state,
          navigatorId: getNextDetailNavigatorId(event),
          parentNavigatorId: logic.args.parentNavigatorId,
          onBack: logic.afterBack,
          onDone: logic.afterBack,
        ),
        dataSource: EventDetailDataSource<DeriveEvent>(event: event, config: logic.dataSource.config),
      ),
      parentId: logic.args.parentNavigatorId,
      nestedId: getNextDetailNavigatorId(event),
    );
  }

  @override
  Widget buildNext({required OriginEvent event, required PageState state, VoidCallback? onBack, VoidCallback? onDone}) {
    return OriginEventDetail(
      key: event.id.value,
      args: EventDetailArgs<OriginEvent>(
        state: logic.args.state == PageState.browse ? PageState.browse : state,
        navigatorId: getNextDetailNavigatorId(event),
        parentNavigatorId: logic.args.parentNavigatorId,
        onBack: onBack,
        onDone: onDone,
      ),
      dataSource: EventDetailDataSource<OriginEvent>(event: event, config: logic.dataSource.config),
    );
  }
}
