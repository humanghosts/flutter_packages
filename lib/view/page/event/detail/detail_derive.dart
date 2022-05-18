import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/view/enum/page_states.dart';
import 'package:hg_logger/view/page/event/detail/origin_editor/origin_editor.dart';

import 'detail_event.dart';
import 'detail_origin.dart';

/// 事件详情的逻辑
class DeriveEventDetailLogic extends EventDetailLogic<DeriveEvent> {
  @override
  DeriveEventService get service => DeriveEventService.instance;

  /// 源事件更新标识
  Rx<int> originUpdateFlag = 0.obs;

  @override
  void beforeSuperCall() {
    originUpdateFlag.value = 0;
    super.beforeSuperCall();
  }

  @override
  DeriveEvent newModel() {
    return DeriveEvent();
  }

  /// 派生事件的子事件直接删除
  @override
  Future<bool> isRemoveChildren(DeriveEvent event) async {
    return true;
  }

  /// 删除子事件
  @override
  void removeChild(DeriveEvent child) async {
    if (args.state == PageState.browse) return;
    data.children.remove(child);
    if (child.state == States.none) return;
    // 是否同时删除子事件
    bool isRemoveChildrenRes = await isRemoveChildren(child);
    await service.remove(child, isRemoveChildren: isRemoveChildrenRes);
    childUpdateFlag.value++;
  }

  @override
  Future<bool> canChildRemove(DeriveEvent child) async {
    bool? canRemove = await RouteHelper.showOneChoiceRequest();
    return canRemove == true;
  }
}

/// 事件明细页面
class DeriveEventDetail extends EventDetail<DeriveEvent, DeriveEventDetailLogic> {
  DeriveEventDetail({
    required String key,
    required EventDetailArgs<DeriveEvent> args,
    required EventDetailDataSource<DeriveEvent> dataSource,
  }) : super(key: key, args: args, dataSource: dataSource, newLogic: DeriveEventDetailLogic());

  @override
  List<String> buildExtendsTabBar() {
    DeriveEvent event = logic.data;
    if (event.origin.isNull) return [];
    return ["源事件"];
  }

  @override
  List<Widget> buildExtendsTab() {
    DeriveEvent event = logic.data;
    if (event.origin.isNull) return [];
    return [buildOrigin()];
  }

  /// 构建源事件
  Widget buildOrigin() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Obx(() {
            int originUpdateFlag = logic.originUpdateFlag.value;
            debugPrint("源事件更新次数:$originUpdateFlag");
            return DeriveDetailOriginEditor(
              key: logic.key,
              args: DeriveDetailOriginEditorArgs(onTap: toOrigin, state: logic.args.state),
              dataSource: DeriveDetailOriginEditorDataSource(
                origin: logic.data.origin.value!,
                config: logic.dataSource.config,
              ),
            );
          }),
        )
      ],
    );
  }

  /// 打开源事件
  void toOrigin(OriginEvent origin) {
    RouteHelper.bottomPageNested(
      nestedId: getNextDetailNavigatorId(origin),
      parentId: logic.args.parentNavigatorId,
      page: OriginEventDetail(
        key: origin.id.value,
        args: EventDetailArgs<OriginEvent>(
          state: logic.args.state,
          navigatorId: getNextDetailNavigatorId(origin),
          parentNavigatorId: logic.args.parentNavigatorId,
          onBack: logic.afterBack,
          onDone: logic.afterBack,
        ),
        dataSource: EventDetailDataSource<OriginEvent>(event: origin, config: logic.dataSource.config),
      ),
    );
  }

  @override
  Widget buildNext({required DeriveEvent event, required PageState state, VoidCallback? onBack, VoidCallback? onDone}) {
    return DeriveEventDetail(
      key: event.id.value,
      args: EventDetailArgs<DeriveEvent>(
        state: logic.args.state == PageState.browse ? PageState.browse : state,
        navigatorId: getNextDetailNavigatorId(event),
        parentNavigatorId: logic.args.parentNavigatorId,
        onBack: onBack,
        onDone: onDone,
      ),
      dataSource: EventDetailDataSource<DeriveEvent>(event: event, config: logic.dataSource.config),
    );
  }
}
