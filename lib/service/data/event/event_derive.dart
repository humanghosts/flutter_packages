import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:hg_logger/ability/events/events.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_orm/hg_orm.dart';

/// 事件服务
class DeriveEventService extends EventService<DeriveEvent> {
  DeriveEventService._();

  static DeriveEventService? _instance;

  static DeriveEventService get instance => _instance ??= DeriveEventService._();

  /// 提醒服务
  EventNoticeService get noticeService => EventNoticeService.instance;

  /// 源事件服务
  OriginEventService get originService => OriginEventService.instance;

  /// 保存的情况
  /// 1. 日程新增/修改事件
  /// 2. 日程新增/修改子事件
  @override
  Future<void> save(DeriveEvent model, {Transaction? tx, EventConfig? config}) async {
    await super.save(model, tx: tx);
    EventConfig eventConfig = config ?? await findConfig(tx: tx);
    await noticeOrNot(model, eventConfig);
    await updateBadges(tx: tx);
  }

  /// 删除派生事件，调用源事件的派生处理
  /// 1. 日程删除事件
  /// 2. 日程删除子事件
  /// 3. 源事件详情中的日程删除事件或子事件
  @override
  Future<void> remove(DeriveEvent derive, {Transaction? tx, bool isRemoveChildren = true}) async {
    await dao.withTransaction(tx, (tx) async {
      await dao.remove(derive, tx: tx, isRemoveChildren: isRemoveChildren);
      await noticeRemove(derive, dealChildren: true);
      await originService.afterDeriveRemove(derive, tx: tx);
    });
    await updateBadges(tx: tx);
  }

  ///  通过源事件新增
  ///  源事件派生保存
  Future<void> saveListByOrigin(List<DeriveEvent> deriveList, {Transaction? tx, EventConfig? config}) async {
    await dao.saveList(deriveList, tx: tx);
    EventConfig eventConfig = config ?? await findConfig(tx: tx);
    await noticeOrNotList(deriveList, eventConfig);
    await updateBadges(tx: tx);
  }

  ///  通过源事件删除
  ///  源事件派生删除
  Future<void> removeListByOrigin(List<DeriveEvent> deriveList, {bool isLogicDelete = true, Transaction? tx}) async {
    await dao.removeList(deriveList, tx: tx, isLogicDelete: isLogicDelete);
    await noticeListRemove(deriveList, dealChildren: true);
    await updateBadges(tx: tx);
  }

  /// 提醒或不提醒
  Future<void> noticeOrNot(DeriveEvent derive, EventConfig config) async {
    List<String> endStatusIdList = config.endStatus.value.map((e) => e.id.value).toList();
    List<DeriveEvent> modelList = dao.treeToList([derive]);
    List<DeriveEvent> notices = [];
    List<DeriveEvent> cancels = [];
    for (DeriveEvent derive in modelList) {
      bool isEndStatus = endStatusIdList.contains(derive.status.value?.id.value);
      if (isEndStatus) {
        cancels.add(derive);
      } else {
        notices.add(derive);
      }
    }
    await noticeList(notices);
    await noticeListRemove(cancels);
  }

  /// 提醒或不提醒
  Future<void> noticeOrNotList(List<DeriveEvent> deriveList, EventConfig config) async {
    List<String> endStatusIdList = config.endStatus.value.map((e) => e.id.value).toList();
    List<DeriveEvent> modelList = dao.treeToList(deriveList);
    List<DeriveEvent> notices = [];
    List<DeriveEvent> cancels = [];
    for (DeriveEvent derive in modelList) {
      bool isEndStatus = endStatusIdList.contains(derive.status.value?.id.value);
      if (isEndStatus) {
        cancels.add(derive);
      } else {
        notices.add(derive);
      }
    }
    await noticeList(notices);
    await noticeListRemove(cancels);
  }

  /// 添加提醒
  Future<void> notice(DeriveEvent derive, {bool dealChildren = false}) async {
    await noticeService.noticeByEvent(derive, dealChildren);
  }

  /// 取消提醒
  Future<void> noticeRemove(DeriveEvent derive, {bool dealChildren = false}) async {
    await noticeService.removeNoticeByEvent(derive, dealChildren);
  }

  /// 批量添加提醒
  Future<void> noticeList(List<DeriveEvent> deriveList, {bool dealChildren = false}) async {
    await noticeService.noticeByEventList(deriveList, dealChildren);
  }

  /// 批量取消提醒
  Future<void> noticeListRemove(List<DeriveEvent> deriveList, {bool dealChildren = false}) async {
    for (DeriveEvent event in deriveList) {
      await noticeRemove(event, dealChildren: dealChildren);
    }
  }

  /// 修改派生事件状态
  @override
  Future<void> doAction(
    DeriveEvent derive,
    Status status, {
    StatusRecordSourceType sourceType = StatusRecordSourceType.user,
    String? reason,
    Transaction? tx,
  }) async {
    await dao.withTransaction(tx, (tx) async {
      // 修改事件状态
      derive.status.value = status;
      derive.statusHistory.add(StatusHistoryRecord(sourceType: sourceType, status: status, reason: reason ?? "用户修改"));
      doChildrenAction(derive, status);
      DeriveEvent rootParent = doParentAction(derive, status);
      // 保存
      await save(rootParent, tx: tx);
      // 查找配置
      EventConfig config = await findConfig(tx: tx);
      await noticeOrNot(derive, config);
      // 处理源事件
      await originService.afterDeriveDoAction(rootParent, status, tx: tx);
    });
    await updateBadges(tx: tx);
  }

  /// 由源事件修改状态
  Future<void> doActionByOrigin(
    OriginEvent origin,
    Status status, {
    StatusRecordSourceType sourceType = StatusRecordSourceType.user,
    Transaction? tx,
  }) async {
    await dao.withTransaction(tx, (tx) async {
      // 更新所有相关派生事件
      List<String> treeId = getEventTreeIdList(origin);
      EventConfig config = await findConfig(tx: tx);
      List<DeriveEvent> deriveEventTree = await findTree(filter: SingleFilter.inList(field: DeriveEvent.originKey, value: treeId), tx: tx);
      // 需要更新的派生事件
      Map<String, DeriveEvent> updateMap = {};
      for (DeriveEvent deriveEvent in deriveEventTree) {
        if (deriveEvent.status.value?.id.value == status.id.value) continue;
        // 更改所有派生事件的状态
        deriveEvent.status.value = status;
        deriveEvent.statusHistory.add(StatusHistoryRecord(sourceType: StatusRecordSourceType.auto, status: status, reason: "源事件修改状态同步修改派生事件状态"));
        doChildrenAction(deriveEvent, status);
        DeriveEvent rootParent = doParentAction(deriveEvent, status);
        updateMap[rootParent.id.value] = rootParent;
      }
      if (updateMap.isEmpty) return;
      List<DeriveEvent> updateList = updateMap.values.toList();
      await saveListByOrigin(updateList, tx: tx, config: config);
    });
    await updateBadges(tx: tx);
  }

  /// 查询所有派生事件的数量，默认查所有
  Future<List<DeriveEvent>> findByOriginIdWithRemoved(String originId, {Transaction? tx}) async {
    return await dao.find(
      filter: SingleFilter.equals(field: sampleModel.origin.name, value: originId),
      tx: tx,
      isLogicDelete: false,
    );
  }

  /// 查询所有派生事件的数量，默认查所有
  Future<List<DeriveEvent>> findByOriginId(String originId, {Transaction? tx}) async {
    return await dao.find(
      filter: SingleFilter.equals(field: sampleModel.origin.name, value: originId),
      tx: tx,
    );
  }

  /// 查询派生事件，按照时间排序
  Future<List<DeriveEvent>> findByOriginIdWithRemovedInOrder(String originId, {Transaction? tx}) async {
    List<DeriveEvent> derives = await dao.find(
      filter: SingleFilter.equals(field: sampleModel.origin.name, value: originId),
      tx: tx,
      isLogicDelete: false,
    );
    if (derives.isEmpty) return [];
    // 排序 根据开始时间
    derives.sort((a, b) {
      SingleTiming? at = a.timing.value;
      SingleTiming? bt = b.timing.value;
      return CompareableTiming.compareNullable(at, bt);
    });
    return derives;
  }

  /// 应用内和应用角标更新
  Future<void> updateBadges({Transaction? tx}) async {
    // 当前时间
    FilterDateTime today = FilterDateTime(type: FilterDateTimeTypeEnum.custom, customDate: DateTime.now());
    // 用tag做过滤和排序
    Tag filterTag = Tag()
      ..filter.value = GroupFilterValue(
        filters: [
          // 1. 开始时间小于等于今天
          SingleFilterValue(filter: SingleFilter.lessThanOrEquals(field: EventFilterField.startTiming.value, value: today)),
          SingleFilterValue(filter: SingleFilter.notNull(field: EventFilterField.startTiming.value)),
          // 2. 结束事件大于等于今天或者为空
          GroupFilterValue(
            op: GroupFilterOp.or,
            filters: [
              SingleFilterValue(filter: SingleFilter.isNull(field: EventFilterField.endTiming.value)),
              SingleFilterValue(filter: SingleFilter.greaterThanOrEquals(field: EventFilterField.endTiming.value, value: today)),
            ],
          ),
        ],
      );
    List<DeriveEvent> eventList = await findTreeByTag(filterTag, tx: tx);
    int todayNumber = 0;
    if (eventList.isNotEmpty) {
      EventConfig config = await findConfig(tx: tx);
      Set<String> endConfigIdSet = config.endStatus.value.map((e) => e.id.value).toSet();
      List<DeriveEvent> notDoneList = eventList.where((value) => !endConfigIdSet.contains(value.status.value?.id.value)).toList();
      todayNumber = notDoneList.length;
    }
    if (todayNumber > 0) {
      FlutterAppBadger.updateBadgeCount(todayNumber);
    } else {
      FlutterAppBadger.removeBadge();
    }
    EventsHelper.badgesUpdate.notify(todayNumber);
  }
}
