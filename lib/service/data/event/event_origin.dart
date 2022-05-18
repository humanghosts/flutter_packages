import 'package:hg_logger/ability/export.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_logger/util/var_util.dart';
import 'package:hg_orm/hg_orm.dart';

/// 源事件服务
class OriginEventService extends EventService<OriginEvent> {
  OriginEventService._();

  static OriginEventService? _instance;

  static OriginEventService get instance => _instance ??= OriginEventService._();

  /// 派生事件服务
  DeriveEventService get eventService => DeriveEventService.instance;

  @override
  Future<void> saveConfig(EventConfig config, {Transaction? tx}) async {
    Set<String> oldEndStatusIdSet = config.oldEndStatus.value.map((e) => e.id.value).toSet();
    Set<String> endStatusIdSet = config.endStatus.value.map((e) => e.id.value).toSet();
    // 修改旧结束状态
    config.oldEndStatus.clear();
    config.oldEndStatus.addAll(config.endStatus.value);
    super.saveConfig(config, tx: tx);
    // 结束状态变动 修改事件提醒
    if (oldEndStatusIdSet.join(",") != endStatusIdSet.join(",")) {
      List<OriginEvent> originList = await findTree(tx: tx);
      for (OriginEvent origin in originList) {
        List<DeriveEvent> deriveList = await eventService.findByOriginId(origin.id.value, tx: tx);
        await eventService.noticeOrNotList(deriveList, config);
      }
    }
    await eventService.updateBadges(tx: tx);
  }

  /// 保存源事件
  @override
  Future<void> save(OriginEvent origin, {Transaction? tx}) async {
    // 开启事务
    await dao.withTransaction(tx, (tx) async {
      // 完整保存 事件及其子事件
      await dao.save(origin, tx: tx);
      // 查询事件配置
      EventConfig config = await findConfig(tx: tx);
      // 获取真正的源事件 有父事件使用父事件去重新匹配，保证子事件更新时间之后父事件的子事件属性也更新
      OriginEvent toDeriveEvent = origin.parent.isNull ? origin : origin.parent.value!;
      // 派生
      List<DeriveEvent> saveDeriveList = [];
      List<DeriveEvent> removeDeriveList = [];
      await derive(
        origin: toDeriveEvent,
        config: config,
        saveList: saveDeriveList,
        removeList: removeDeriveList,
        tx: tx,
        isUpdateDerive: Var(null),
        isUpdateDone: Var(null),
        isNoParentChildSave: Var(null),
      );
      // 保存派生事件
      await eventService.saveListByOrigin(saveDeriveList, tx: tx);
      // 永久移除无用派生事件
      await eventService.removeListByOrigin(removeDeriveList, isLogicDelete: false, tx: tx);
    });
  }

  /// 删除源事件
  /// 同时删除子事件，以及所有派生事件
  @override
  Future<void> remove(OriginEvent origin, {Transaction? tx, bool isRemoveChildren = true}) async {
    // 开启事务
    await dao.withTransaction(tx, (tx) async {
      // 删除事件及其子事件
      await dao.remove(origin, tx: tx, isRemoveChildren: isRemoveChildren);
      // 删除派生时间及提醒
      // 获取事件树上的所有ID
      List<String> eventTreeId = getEventTreeIdList(origin);
      // 查询所有的派生事件 这里要查是因为需要根据事件取消已经有的提醒
      List<DeriveEvent> deriveEventList = await eventService.find(filter: SingleFilter.inList(field: DeriveEvent.originKey, value: eventTreeId), tx: tx);
      // 删除所有派生事件
      await eventService.removeListByOrigin(deriveEventList, tx: tx);
    });
  }

  /// 状态更改
  /// 父事件状态更改 更改子事件状态
  /// 源事件状态更改 更改派生事件状态
  /// 子事件状态一致 更改父事件状态
  /// 派生事件状态一致 并且没有新的派生事件，更改源事件状态
  /// 更新派生事件数量
  /// 提醒修改
  /// 只要不是用户手动修改状态的，都算自动修改
  @override
  Future<void> doAction(
    OriginEvent origin,
    Status status, {
    StatusRecordSourceType sourceType = StatusRecordSourceType.user,
    String? reason,
    Transaction? tx,
  }) async {
    await dao.withTransaction(tx, (tx) async {
      // 事件状态更改
      origin.status.value = status;
      origin.statusHistory.add(StatusHistoryRecord(sourceType: sourceType, status: status, reason: reason ?? "用户修改"));
      // 更改子事件状态
      doChildrenAction(origin, status);
      // 更改父事件状态
      OriginEvent rootParent = doParentAction(origin, status);
      // 更新数据库
      await dao.save(rootParent, tx: tx);
      // 更新派生事件
      await eventService.doActionByOrigin(rootParent, status, tx: tx);
    });
  }

  /// 派生事件状态变更后处理
  /// 1. 派生事件增派或不处理
  /// 2. 查询当前所有派生事件，判断状态是否相同 决定是否修改源事件状态
  Future<void> afterDeriveDoAction(DeriveEvent derive, Status status, {Transaction? tx}) async {
    OriginEvent? origin = derive.origin.value;
    if (origin == null) return;
    await dao.withTransaction(tx, (tx) async {
      String originId = origin.id.value;
      // 派生时间
      SingleTiming? singleTiming = derive.timing.value;
      // 源时间
      RepeatableTiming? originTiming;
      if (singleTiming != null && !singleTiming.origin.isNull) {
        for (RepeatableTiming timing in origin.timingList.value) {
          bool isOrigin = singleTiming.isOrigin(timing);
          if (isOrigin) {
            originTiming = timing;
            break;
          }
        }
      }
      // 源时间不为空并且重复，增派处理
      if (originTiming != null && !originTiming.repeatRule.isNull) {
        // 查询事件配置
        EventConfig config = await findConfig(tx: tx);
        // 查找已经派生的事件，因为后面处理需要知道总派生数量(包括删除),未结束数量
        List<DeriveEvent> derivedList = await eventService.findByOriginIdWithRemoved(originId, tx: tx);
        // 派生
        List<DeriveEvent> saveDeriveList = [];
        List<DeriveEvent> removeDeriveList = [];
        await deriveByTiming(
          origin: origin,
          derivedList: derivedList,
          originTiming: originTiming,
          config: config,
          saveList: saveDeriveList,
          removeList: removeDeriveList,
          tx: tx,
          isUpdateDerive: Var(false),
          isUpdateDone: Var(false),
        );
        if (saveDeriveList.isNotEmpty) await eventService.saveListByOrigin(saveDeriveList, tx: tx);
        if (removeDeriveList.isNotEmpty) await eventService.removeListByOrigin(removeDeriveList, tx: tx);
      }
      // 没有originTiming或者不重复 直接修改
      if (originTiming == null || originTiming.repeatRule.isNull) {
        await doAction(origin, status, sourceType: StatusRecordSourceType.auto, reason: "日程事件状态一致，修改源事件", tx: tx);
        return;
      }
      // 派生事件状态一致 更改源事件状态
      // 当前所有派生事件 不包括删除的
      List<DeriveEvent> deriveEventList = await eventService.find(filter: SingleFilter.equals(field: DeriveEvent.originKey, value: originId), tx: tx);
      // 是否状态一致
      for (DeriveEvent deriveEvent in deriveEventList) {
        // 有一个状态不一致就不用处理
        if (deriveEvent.status.value?.id.value != status.id.value) return;
      }
      await doAction(origin, status, sourceType: StatusRecordSourceType.auto, reason: "日程事件状态一致，修改源事件", tx: tx);
    });
  }

  /// 派生事件删除回调
  /// 增派或者不处理
  Future<void> afterDeriveRemove(DeriveEvent derive, {Transaction? tx}) async {
    OriginEvent? origin = derive.origin.value;
    if (origin == null) return;
    await dao.withTransaction(tx, (tx) async {
      String originId = origin.id.value;
      // 派生时间
      SingleTiming? singleTiming = derive.timing.value;
      // 源时间
      RepeatableTiming? originTiming;
      if (singleTiming != null && !singleTiming.origin.isNull) {
        for (RepeatableTiming timing in origin.timingList.value) {
          bool isOrigin = singleTiming.isOrigin(timing);
          if (isOrigin) {
            originTiming = timing;
            break;
          }
        }
      }
      if (originTiming == null || originTiming.repeatRule.isNull) return;
      // 源时间不为空，增派处理
      // 查询事件配置
      EventConfig config = await findConfig(tx: tx);
      // 查找已经派生的事件，因为后面处理需要知道总派生数量(包括删除),未结束数量
      List<DeriveEvent> derivedList = await eventService.findByOriginIdWithRemoved(originId, tx: tx);
      // 派生
      List<DeriveEvent> saveDeriveList = [];
      List<DeriveEvent> removeDeriveList = [];
      await deriveByTiming(
        origin: origin,
        derivedList: derivedList,
        originTiming: originTiming,
        config: config,
        saveList: saveDeriveList,
        removeList: removeDeriveList,
        tx: tx,
        isUpdateDerive: Var(false),
        isUpdateDone: Var(false),
      );
      if (saveDeriveList.isNotEmpty) await eventService.saveListByOrigin(saveDeriveList, tx: tx);
      if (removeDeriveList.isNotEmpty) await eventService.removeListByOrigin(removeDeriveList, tx: tx);
    });
  }

  /// 派生
  /// [saveList]需要保存的列表
  /// [removeList]需要删除的列表
  ///
  /// 0. 处于完成状态的事件不派生
  /// 1. timing被删除后，删除现有的派生事件
  /// 2. 同时根据设置修改未完成派生事件的所有属性
  /// 3. 如果事件没有时间属性，作为属性跟随父事件派生
  /// 4. 如果事件及其父事件都没有时间属性，不派生
  /// 4. 如果事件只有一个时间属性 并且不重复，源事件会与父事件匹配
  /// 6. 没有与父事件匹配的会按照设置决定是否单独存储
  /// 7. 间接子事件不参与匹配，也就是说如果子事件没有时间属性，有时间的孙事件将作为独立事件单独派生
  Future<void> derive({
    required OriginEvent origin,
    required EventConfig config,
    required List<DeriveEvent> saveList,
    required List<DeriveEvent> removeList,
    required Transaction tx,
    required Var<bool?> isUpdateDerive,
    required Var<bool?> isUpdateDone,
    required Var<bool?> isNoParentChildSave,
  }) async {
    // 1 递归处理子事件的派生
    List<DeriveEvent> childrenSaveList = [];
    List<DeriveEvent> childrenRemoveList = [];
    for (OriginEvent child in origin.children.value) {
      await derive(
        origin: child,
        config: config,
        saveList: childrenSaveList,
        removeList: childrenRemoveList,
        tx: tx,
        isUpdateDerive: isUpdateDerive,
        isUpdateDone: isUpdateDone,
        isNoParentChildSave: isUpdateDerive,
      );
    }
    // 2 查找已经派生的事件，因为后面处理需要知道总派生数量(包括删除),未结束数量
    List<DeriveEvent> derivedList = await eventService.findByOriginIdWithRemoved(origin.id.value, tx: tx);
    // 3.1 有发生时间，遍历发生时间进行派生
    if (origin.timingList.value.isNotEmpty) {
      for (RepeatableTiming repeatableTiming in origin.timingList.value) {
        await deriveByTiming(
          origin: origin,
          derivedList: derivedList,
          originTiming: repeatableTiming,
          config: config,
          saveList: saveList,
          removeList: removeList,
          tx: tx,
          isUpdateDerive: isUpdateDerive,
          isUpdateDone: isUpdateDone,
        );
      }
    }
    // 3.2 没有发生时间 只更新，不派生，派生方法见event.derive
    else {
      // 结束状态ID
      Set<String> endStatusIdList = config.endStatus.value.map((e) => e.id.value).toSet();
      List<DeriveEvent> noTimingDeriveList = derivedList.where((derive) => derive.timing.isNull).toList();
      derivedList.removeWhere((derive) => derive.timing.isNull);
      for (DeriveEvent noTimingDerive in noTimingDeriveList) {
        // 已删除的派生事件
        if (noTimingDerive.isDelete.value) continue;
        // 是否结束状态
        String? statusId = noTimingDerive.status.value?.id.value;
        bool isDone = endStatusIdList.contains(statusId);
        // 询问用户是否同时修改派生事件
        isUpdateDerive.value ??= await RouteHelper.showOneChoiceRequest(msg: "修改内容是否覆盖已存在的日程?", doneText: "覆盖", cancelText: "不覆盖");
        // 不修改继续
        if (isUpdateDerive.value != true) continue;
        if (isDone) {
          // 询问用户是否修改已结束的派生事件
          isUpdateDone.value ??= await RouteHelper.showOneChoiceRequest(msg: "存在结束状态的日程，修改内容是否覆盖已结束日程?", doneText: "覆盖", cancelText: "不覆盖");
          if (isUpdateDone.value != true) continue;
        }
        noTimingDerive.updateByOrigin(origin, null);
      }
      saveList.addAll(noTimingDeriveList);
    }
    List<DeriveEvent> copyChildrenSaveList = [...childrenSaveList];
    // 2.4 父子事件时间匹配
    for (DeriveEvent deriveEvent in saveList) {
      // 这里不用删除不匹配的，不匹配的会进入childrenRemoveList，数据库删除之后，再查就查不到了
      Set<String> childKeySet = deriveEvent.childrenMap.keys.toSet();
      // 2.4.2 遍历子事件
      for (DeriveEvent childDeriveEvent in copyChildrenSaveList) {
        // 已经存在的就不动了，尤其是无时间子事件
        if (childKeySet.contains(childDeriveEvent.id.value)) {
          childDeriveEvent.parent.value = deriveEvent;
          childrenSaveList.remove(childDeriveEvent);
          continue;
        }
        // 子事件的timing
        SingleTiming? childTiming = childDeriveEvent.timing.value;
        // 时间为空，说明是别的派生事件的无时间子事件，不处理
        if (null == childTiming || childTiming.isNull) continue;
        // 父事件的timing
        SingleTiming? parentTiming = deriveEvent.timing.value;
        // 如果父事件没有时间，子事件有时间，不匹配
        if (null == parentTiming) continue;
        // 父事件的时间是否包含子事件的时间
        bool isInclude = parentTiming.isInclude(childTiming);
        // 不包含，不匹配
        if (!isInclude) continue;
        // 父子关联
        deriveEvent.children.add(childDeriveEvent);
        // 从列表中移除，父事件保存的时候会保存子事件，这里移除是防止防止重复保存，同时也可以剩下没有匹配到的子事件
        childrenSaveList.remove(childDeriveEvent);
      }
    }
    if (childrenSaveList.isNotEmpty) {
      // 2.5 根据[派生事件中无父事件的子事件是否保存]设置决定是否保存剩余的无父子事件
      isNoParentChildSave.value ??= await RouteHelper.showOneChoiceRequest(msg: "父子事件进行时间匹配时，存在未匹配到父事件的子事件，是否作为独立日程保存？", doneText: "保存", cancelText: "不保存");
      if (isNoParentChildSave.value == true) {
        saveList.addAll(childrenSaveList);
      } else {
        removeList.addAll(childrenSaveList);
      }
    }
    // 2.6.1 删除需要删除的子事件
    removeList.addAll(childrenRemoveList);
    // 2.6.2 删除剩余没有认领的事件
    removeList.addAll(derivedList);
  }

  /// 通过时间派生
  Future<void> deriveByTiming({
    required OriginEvent origin,
    required List<DeriveEvent> derivedList,
    required RepeatableTiming originTiming,
    required EventConfig config,
    required List<DeriveEvent> saveList,
    required List<DeriveEvent> removeList,
    required Transaction tx,
    required Var<bool?> isUpdateDerive,
    required Var<bool?> isUpdateDone,
  }) async {
    // 1 获取当前时间已有的派生事件
    List<DeriveEvent> timingDeriveList = derivedList.where((value) => value.isOriginTiming(originTiming)).toList();
    // 2 移除原列表中，最后剩下的就是需要删除的
    if (timingDeriveList.isNotEmpty) derivedList.removeWhere((value) => value.isOriginTiming(originTiming));
    // 结束状态ID
    Set<String> endStatusIdList = config.endStatus.value.map((e) => e.id.value).toSet();
    // 3 不重复事件只生成一个 已经有了就不处理了
    if (originTiming.repeatRule.isNull && timingDeriveList.isNotEmpty) {
      for (DeriveEvent timingDerive in timingDeriveList) {
        if (timingDerive.isDelete.value) continue;
        // 分组
        String? statusId = timingDerive.status.value?.id.value;
        bool isDone = endStatusIdList.contains(statusId);
        // 询问用户是否同时修改派生事件
        isUpdateDerive.value ??= await RouteHelper.showOneChoiceRequest(msg: "修改内容是否覆盖已存在的日程?", doneText: "覆盖", cancelText: "不覆盖");
        // 不修改继续
        if (isUpdateDerive.value != true) continue;
        if (isDone) {
          // 询问用户是否修改已结束的派生事件
          isUpdateDone.value ??= await RouteHelper.showOneChoiceRequest(msg: "存在结束状态的日程，修改内容是否覆盖已结束日程?", doneText: "覆盖", cancelText: "不覆盖");
          if (isUpdateDone.value != true) continue;
        }
        // 更新
        timingDerive.updateByOrigin(origin, originTiming);
        saveList.add(timingDerive);
      }
      return;
    }
    // 4 排序
    timingDeriveList.sort((a, b) => CompareableTiming.compareNullable(a.timing.value, b.timing.value));
    // 当前未结束的派生事件
    List<DeriveEvent> unDoneDerived = [];
    // 当前结束的派生事件
    List<DeriveEvent> doneDerived = [];
    // 当前删除的派生事件
    List<DeriveEvent> deleteDerived = [];
    // 5 遍历已派生的事件分组
    for (DeriveEvent timingDerive in timingDeriveList) {
      // 已删除的派生事件
      if (timingDerive.isDelete.value) {
        deleteDerived.add(timingDerive);
        continue;
      }
      // 是否结束状态
      String? statusId = timingDerive.status.value?.id.value;
      bool isDone = endStatusIdList.contains(statusId);
      if (isDone) {
        doneDerived.add(timingDerive);
      } else {
        unDoneDerived.add(timingDerive);
      }
      // 询问用户是否同时修改派生事件
      isUpdateDerive.value ??= await RouteHelper.showOneChoiceRequest(msg: "修改内容是否覆盖已存在的日程?", doneText: "覆盖", cancelText: "不覆盖");
      // 不修改继续
      if (isUpdateDerive.value != true) continue;
      if (isDone) {
        // 询问用户是否修改已结束的派生事件
        isUpdateDone.value ??= await RouteHelper.showOneChoiceRequest(msg: "存在结束状态的日程，修改内容是否覆盖已结束日程?", doneText: "覆盖", cancelText: "不覆盖");
        if (isUpdateDone.value != true) continue;
      }
      // 更新
      timingDerive.updateByOrigin(origin, originTiming);
    }
    // 6 设置派生限制
    // 获取派生事件的最大数量(并不是总数)
    int maxDeriveNum = config.maxDeriveNum.value;
    // 未结束数量限制，由事件设置里用户设置的上限决定
    int undoneMaxNum = maxDeriveNum;
    // 当前未结束数量
    int unDoneCount = unDoneDerived.length;
    // 没有超过总数限制
    if (undoneMaxNum > unDoneCount) {
      // 派生数量小于最大数量，需要增量派生
      List<DeriveEvent> newDerives = [];
      // 现在是[0,1,2] start 就是3，num是生成的数量，如果是2，那么最终结果是[0,1,2,3,4]
      for (int i = timingDeriveList.length; i < timingDeriveList.length + (undoneMaxNum - unDoneCount); i++) {
        SingleTiming? deriveTiming = originTiming.derive(i);
        if (null == deriveTiming) break;
        newDerives.add(origin.derive(timing: deriveTiming));
      }
      unDoneDerived.addAll(newDerives);
    }
    // 保存未结束
    saveList.addAll(unDoneDerived);
    // 根据[是否只更新未结束派生事件]决定是否保存已结束
    if (isUpdateDone.value == true) saveList.addAll(doneDerived);
  }

  /// 查询是否有派生事件
  Future<bool> hasDerive(String originId, {Transaction? tx}) async {
    DeriveEvent? event = await eventService.dao.findFirst(
      filter: SingleFilter.equals(field: DeriveEvent.originKey, value: originId),
      tx: tx,
      isLogicDelete: false,
    );
    return event != null;
  }
}
