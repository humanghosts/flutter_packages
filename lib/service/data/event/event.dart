import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_orm/hg_orm.dart';

/// 事件服务
abstract class EventService<T extends Event> extends DataModelService<T> {
  @override
  DataTreeDao<T> get dao => DaoCache.getByType(T) as DataTreeDao<T>;

  /// 事件配置
  EventConfigService get eventConfigService => EventConfigService.instance;

  /// 状态服务
  StatusService get statusService => StatusService.instance;

  /// 转换为map数据
  Future<Map<String, Object?>?> convertToMap(T event) async {
    return await dao.convertors.modelConvertor.getValue(event);
  }

  @override
  Future<void> remove(T model, {Transaction? tx, bool isRemoveChildren = true}) async {
    await dao.remove(model, tx: tx, isRemoveChildren: isRemoveChildren);
  }

  /// 查询事件配置
  Future<EventConfig> findConfig({Transaction? tx}) async {
    return await eventConfigService.find(tx: tx);
  }

  /// 保存事件配置
  Future<void> saveConfig(EventConfig config, {Transaction? tx}) async {
    await eventConfigService.save(config, tx: tx);
  }

  /// 获取事件树上的所有的id
  List<String> getEventTreeIdList(Event event) {
    List<String> originIdList = [event.id.value];
    for (DataTreeModel child in event.children.value) {
      originIdList.addAll(getEventTreeIdList(child as Event));
    }
    return originIdList;
  }

  /// 修改子状态
  void doChildrenAction(T parent, Status status) {
    if (parent.children.isNull) return;
    for (DataTreeModel child in parent.children.value) {
      (child as T).status.value = status;
      child.statusHistory.add(StatusHistoryRecord(
        sourceType: StatusRecordSourceType.auto,
        status: status,
        reason: "父事件状态修改同步修改子事件状态",
      ));
      doChildrenAction(child, status);
    }
  }

  /// 如果子状态一致，修改父状态
  /// 返回值修改的父状态的最上级
  T doParentAction(T child, Status status) {
    // 没有父事件，不处理
    if (child.parent.isNull) return child;
    T parent = child.parent.value! as T;
    // 父事件状态一致，不处理
    if (parent.status.value?.id.value == status.id.value) return child;
    // 遍历子事件，判断是否所有子事件的状态都等于当前状态，有一个不是不处理
    for (DataTreeModel oneChild in parent.children.value) {
      if ((oneChild as T).status.value?.id.value == status.id.value) continue;
      return child;
    }
    // 修改父事件状态
    parent.status.value = status;
    parent.statusHistory.add(StatusHistoryRecord(sourceType: StatusRecordSourceType.auto, status: status, reason: "所有子事件状态一致，修改父事件状态"));
    // 向上修改
    return doParentAction(parent, status);
  }

  /// 修改状态
  /// [sourceType] 是指修改状态的主体
  Future<void> doAction(T event, Status status, {StatusRecordSourceType sourceType = StatusRecordSourceType.user, String? reason, Transaction? tx});

  /// 检查事件是否被删除
  Future<bool> isRemoved(T event, {Transaction? tx}) async {
    T? t = await dao.findByID(event.id.value, isLogicDelete: false);
    if (t == null && event.state == States.none) return false;
    return t == null || t.isDelete.value;
  }

  /// 查询历史状态
  Future<Map<String, Status>> findHistoryStatus(Set<String> statusIdSet, {Transaction? tx}) async {
    List<Status> statusList = await statusService.findByIdListWithRemoved(statusIdSet.toList());
    if (statusList.isEmpty) return {};
    Map<String, Status> map = {};
    for (Status status in statusList) {
      map[status.id.value] = status;
    }
    return map;
  }

  @override
  Future<List<T>> find({Filter? filter, Transaction? tx}) async {
    DataModelCache.clear();
    List<T> eventList = await dao.find(filter: filter, tx: tx);
    eventList.sort(Tag().eventCompare);
    return eventList;
  }

  /// 树形查询
  Future<List<T>> findTree({Filter? filter, Transaction? tx}) async {
    // DataModelCache.clear();
    List<T> eventList = await dao.find(filter: filter, tx: tx);
    return dao.listToTree(eventList);
  }

  /// 通过标签查询 标签为空查询所有
  Future<List<T>> findListByTag(Tag tag, {Transaction? tx}) async {
    // DataModelCache.clear();
    // 标签的过滤条件
    GroupFilter? tagCondFilter = tag.getFilter(eventType: T);
    // 标签的主键条件
    String tagId = tag.id.value;
    Filter tagIdFilter = SingleFilter.containsOne(field: sampleModel.tagList.name, value: [tagId]);
    // 两个条件或，标签是这个的或者符合这个标签过滤要求的
    List<Filter> subFilters = [tagIdFilter];
    if (tagCondFilter != null) subFilters.add(tagCondFilter);
    Filter filter;
    if (tag.isAndFilter.value) {
      filter = GroupFilter.and(subFilters);
    } else {
      filter = GroupFilter.or(subFilters);
    }
    // 查询列表
    List<T> eventList = await dao.find(filter: filter, tx: tx);
    // 排序
    eventList.sort(tag.eventCompare);
    // 转树
    return dao.listToTree(eventList);
  }

  /// 通过标签查询 标签为空查询所有
  Future<List<T>> findTreeByTag(Tag tag, {Transaction? tx}) async {
    // 查询列表
    List<T> eventList = await findListByTag(tag, tx: tx);
    // 转树
    return dao.listToTree(eventList);
  }
}
