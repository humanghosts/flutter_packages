import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:hg_framework/ability/database/database.dart';
import 'package:hg_framework/ability/entity/entity.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast.dart' as sembast;

import '../../api/api.dart' as api;

class SembastDataDao<T extends DataModel> extends DataDao<T> {
  /// 获取实体所在存储库的名称
  late StoreRef store;

  /// 获取数据库实例
  sembast.Database get dataBase => (DatabaseHelper().database as SembastDatabase).database;

  @override
  SembastConvertors get convertors => super.convertors as SembastConvertors;

  SembastDataDao({bool? isLogicDelete, String? storeName})
      : super(
          isLogicDelete: isLogicDelete,
          convertors: SembastConvertors.instance,
        ) {
    store = stringMapStoreFactory.store(storeName ?? T.toString());
  }

  @override
  Future<void> transaction(Future<void> Function(api.Transaction tx) action) async {
    return await dataBase.transaction((tx) async {
      await action(api.Transaction(tx));
    });
  }

  @override
  Future<void> withTransaction(api.Transaction? tx, Future<void> Function(api.Transaction tx) action) async {
    if (null == tx) {
      await transaction(action);
    } else {
      await action(tx);
    }
  }

  /// 保存
  /// 保存前后不会修改model的状态
  /// 如果想要改变model状态，手动或者重新查询
  @override
  Future<void> save(T model, {api.Transaction? tx, bool? isLogicDelete}) async {
    States oldStates = model.state;
    DateTime now = DateTime.now();
    model.createTime.value ??= now;
    model.timestamp.value = now;
    model.version.value = dataBase.version.toString();
    await store
        .record(model.id.value)
        .put(api.Transaction.getOr(tx, dataBase), await convertors.modelConvertor.getValue(model, tx: tx, isLogicDelete: isLogicDelete));
    DataModelCache.put(model);
    if (oldStates == States.none) {
      model.state = States.insert;
    } else {
      model.state = States.update;
    }
  }

  /// 保存，存在更新，不存在插入
  @override
  Future<void> saveList(List<T> modelList, {api.Transaction? tx, bool? isLogicDelete}) async {
    if (modelList.isEmpty) return;
    await withTransaction(tx, (tx) async {
      for (T model in modelList) {
        await save(model, tx: tx, isLogicDelete: isLogicDelete);
      }
    });
  }

  @override
  Future<void> saveRaw(Map<String, Object?> model, {api.Transaction? tx, bool? isLogicDelete}) async {
    DateTime now = DateTime.now();
    int nowValue = convertors.attributeConvertor.datetime.getValue(now);
    model[DataModel.createTimeKey] ??= nowValue;
    model[DataModel.timestampKey] = nowValue;
    model[DataModel.versionKey] = dataBase.version.toString();
    String id = model[DataModel.idKey]! as String;
    await store.record(id).put(api.Transaction.getOr(tx, dataBase), model);
    DataModelCache.remove(id);
  }

  @override
  Future<void> update(String id, Map<String, Object?> value, {api.Transaction? tx}) async {
    await store.record(id).update(
      api.Transaction.getOr(tx, dataBase),
      {
        ...value,
        DataModel.timestampKey: convertors.attributeConvertor.datetime.getValue(DateTime.now()),
        DataModel.versionKey: dataBase.version.toString(),
      },
    );
    DataModelCache.remove(id);
  }

  @override
  Future<void> updateList(List<String> idList, Map<String, Object?> value, {api.Transaction? tx}) async {
    if (idList.isEmpty) return;
    await withTransaction(tx, (tx) async {
      for (String id in idList) {
        await update(id, value, tx: tx);
      }
    });
  }

  /// 更新，同时移除缓存
  @override
  Future<void> updateWhere(api.Filter filter, Map<String, Object?> value, {api.Transaction? tx}) async {
    List<String> removeIdList = [];
    await withTransaction(tx, (tx) async {
      List<String> idList = await store.findKeys(tx.getTx(), finder: Finder(filter: await convertors.filterConvertor.to(filter))) as List<String>;
      if (idList.isEmpty) return;
      // 换成id的过滤条件，简化一下
      Finder finder = Finder(filter: sembast.Filter.inList(DataModel.idKey, idList));
      // 更新
      await store.update(
        tx.getTx(),
        {
          ...value,
          DataModel.timestampKey: convertors.attributeConvertor.datetime.getValue(DateTime.now()),
          DataModel.versionKey: dataBase.version.toString(),
        },
        finder: finder,
      );
      removeIdList = idList;
    });
    for (var id in removeIdList) {
      DataModelCache.remove(id);
    }
  }

  /// 逻辑移除
  @override
  Future<void> remove(T model, {api.Transaction? tx, bool? isLogicDelete}) async {
    bool logicDelete = isLogicDelete ?? this.isLogicDelete;
    if (logicDelete) {
      model.isDelete.value = true;
      DateTime now = DateTime.now();
      model.deleteTime.value = now;
      model.timestamp.value = now;
      model.version.value = dataBase.version.toString();
      await store
          .record(model.id.value)
          .update(api.Transaction.getOr(tx, dataBase), await convertors.modelConvertor.getValue(model, tx: tx, isLogicDelete: logicDelete));
      DataModelCache.remove(model.id.value);
      return;
    }
    await store.record(model.id.value).delete(api.Transaction.getOr(tx, dataBase));
    DataModelCache.remove(model.id.value);
    model.state = States.delete;
  }

  /// 逻辑移除
  @override
  Future<void> removeAll({api.Transaction? tx}) async {
    await store.delete(api.Transaction.getOr(tx, dataBase));
    DataModelCache.clear();
  }

  /// 移除
  @override
  Future<void> removeList(List<T> modelList, {api.Transaction? tx, bool? isLogicDelete}) async {
    if (modelList.isEmpty) return;
    await withTransaction(tx, (tx) async {
      for (T model in modelList) {
        await remove(model, tx: tx, isLogicDelete: isLogicDelete);
      }
    });
  }

  /// 移除，同时移除缓存
  @override
  Future<void> removeWhere(api.Filter filter, {api.Transaction? tx, bool? isLogicDelete}) async {
    List<String> removeIdList = [];
    await withTransaction(tx, (tx) async {
      bool logicDelete = isLogicDelete ?? this.isLogicDelete;
      // 删除前留下ID，便于后面删除缓存
      List<String> idList = await store.findKeys(tx.getTx(), finder: Finder(filter: await convertors.filterConvertor.to(filter))) as List<String>;
      if (idList.isEmpty) return;
      // 换成id的过滤条件，简化一下
      Finder finder = Finder(filter: sembast.Filter.inList(DataModel.idKey, idList));
      if (logicDelete) {
        DateTime now = DateTime.now();
        // 逻辑删除
        await store.update(
          tx.getTx(),
          {
            DataModel.isDeleteKey: true,
            DataModel.deleteTimeKey: convertors.attributeConvertor.datetime.getValue(now),
            DataModel.timestampKey: convertors.attributeConvertor.datetime.getValue(now),
            DataModel.versionKey: dataBase.version.toString(),
          },
          finder: finder,
        );
      } else {
        // 永久删除
        await store.delete(tx.getTx(), finder: finder);
      }
      removeIdList = idList;
    });
    // 移除缓存
    for (var id in removeIdList) {
      DataModelCache.remove(id);
    }
  }

  @override
  Future<void> removeRaw(Map<String, Object?> model, {api.Transaction? tx, bool? isLogicDelete}) async {
    bool logicDelete = isLogicDelete ?? this.isLogicDelete;
    String id = model[DataModel.idKey]! as String;
    if (logicDelete) {
      DateTime now = DateTime.now();
      int nowValue = convertors.attributeConvertor.datetime.getValue(now);
      model[DataModel.isDeleteKey] = true;
      model[DataModel.deleteTimeKey] = nowValue;
      model[DataModel.timestampKey] = nowValue;
      model[DataModel.versionKey] = dataBase.version.toString();
      await store.record(id).update(api.Transaction.getOr(tx, dataBase), model);
      DataModelCache.remove(id);
      return;
    }
    await store.record(id).delete(api.Transaction.getOr(tx, dataBase));
    DataModelCache.remove(id);
  }

  /// 恢复，同时修改状态为query
  @override
  Future<void> recover(T model, {api.Transaction? tx}) async {
    if (model.isDelete.value == false) return;
    model.isDelete.value = false;
    model.deleteTime.value = null;
    model.timestamp.value = DateTime.now();
    model.version.value = dataBase.version.toString();
    // 直接替换数据
    await store.record(model.id.value).put(
          api.Transaction.getOr(tx, dataBase),
          await convertors.modelConvertor.getValue(
            model,
            tx: tx,
            isLogicDelete: false,
          ),
        );
    model.state = States.query;
    DataModelCache.put(model);
  }

  @override
  Future<void> recoverList(List<T> modelList, {api.Transaction? tx}) async {
    if (modelList.isEmpty) return;
    await withTransaction(tx, (tx) async {
      for (T model in modelList) {
        await recover(model, tx: tx);
      }
    });
  }

  /// 恢复，同时移除缓存
  @override
  Future<void> recoverWhere(api.Filter filter, {api.Transaction? tx}) async {
    List<String> recoverIdList = [];
    await withTransaction(tx, (tx) async {
      // 删除前留下ID，便于后面删除缓存
      List<String> idList = await store.findKeys(tx.getTx(), finder: Finder(filter: await convertors.filterConvertor.to(filter))) as List<String>;
      if (idList.isEmpty) return;
      // 换成id的过滤条件，简化一下
      Finder finder = Finder(filter: sembast.Filter.inList(DataModel.idKey, idList));
      await store.update(
        tx.getTx(),
        {
          DataModel.isDeleteKey: false,
          DataModel.deleteTimeKey: null,
          DataModel.timestampKey: convertors.attributeConvertor.datetime.getValue(DateTime.now()),
          DataModel.versionKey: dataBase.version.toString(),
        },
        finder: finder,
      );
      recoverIdList = idList;
    });
    // 按照同样的条件查询一下id，防止缓存和数据库不一致
    for (var id in recoverIdList) {
      DataModelCache.remove(id);
    }
  }

  /// 通过ID查询
  @override
  Future<T?> findByID(String id, {api.Transaction? tx, bool? isLogicDelete}) async {
    List<T> newModelList = await find(
      tx: tx,
      filter: api.SingleFilter.equals(field: DataModel.idKey, value: id),
      isLogicDelete: isLogicDelete,
    );
    if (newModelList.isEmpty) return null;
    return newModelList[0];
  }

  /// 通过ID列表查询
  @override
  Future<List<T>> findByIDList(List<String> idList, {api.Transaction? tx, bool? isLogicDelete}) async {
    List<T> modelList = await find(
      tx: tx,
      filter: api.SingleFilter.inList(field: DataModel.idKey, value: idList),
      isLogicDelete: isLogicDelete,
    );
    if (modelList.isEmpty) return [];
    // 下面的步骤是为了保证modelList的顺序与idList的顺序一致，毕竟是list，不是set
    Map<String, T> idMap = {};
    for (T model in modelList) {
      idMap[model.id.value] = model;
    }
    List<T> modelListOrder = [];
    for (String id in idList) {
      if (!idMap.containsKey(id)) continue;
      modelListOrder.add(idMap[id]!);
    }
    return modelListOrder;
  }

  @override
  Future<List<Map<String, Object?>>> findRaw({
    api.Transaction? tx,
    api.Filter? filter,
    List<api.Sort>? sorts,
    int? limit,
    int? offset,
    Boundary? start,
    Boundary? end,
    bool? isLogicDelete,
  }) async {
    bool logicDelete = isLogicDelete ?? this.isLogicDelete;
    api.Filter? logicFilter = _getLogicFilter(filter, logicDelete);
    List<SortOrder> sortOrders = [];
    if (sorts != null) {
      for (var one in sorts) {
        SortOrder? oneSortOrder = await convertors.sortConvertor.to(one);
        if (null == oneSortOrder) continue;
        sortOrders.add(oneSortOrder);
      }
    }
    Finder finder = Finder(
      filter: await convertors.filterConvertor.to(logicFilter),
      sortOrders: sortOrders,
      limit: limit,
      offset: offset,
      start: start,
      end: end,
    );
    List<Map<String, Object?>> modelList = [];
    await withTransaction(tx, (tx) async {
      List<RecordSnapshot> recordList = await store.find(tx.getTx(), finder: finder);
      for (RecordSnapshot record in recordList) {
        Map<String, Object?> map = json.decode(json.encode(record.value)) as Map<String, Object?>;
        modelList.add(map);
      }
    });
    return modelList;
  }

  /// 自定义查询
  @override
  Future<List<T>> find({
    api.Transaction? tx,
    api.Filter? filter,
    List<api.Sort>? sorts,
    int? limit,
    int? offset,
    Boundary? start,
    Boundary? end,
    bool? isLogicDelete,
  }) async {
    bool logicDelete = isLogicDelete ?? this.isLogicDelete;
    api.Filter? logicFilter = _getLogicFilter(filter, logicDelete);
    List<SortOrder> sortOrders = [];
    if (sorts != null) {
      for (var one in sorts) {
        SortOrder? oneSortOrder = await convertors.sortConvertor.to(one);
        if (null == oneSortOrder) continue;
        sortOrders.add(oneSortOrder);
      }
    }
    Finder finder = Finder(
      filter: await convertors.filterConvertor.to(logicFilter),
      sortOrders: sortOrders,
      limit: limit,
      offset: offset,
      start: start,
      end: end,
    );
    List<T> modelList = [];
    await withTransaction(tx, (tx) async {
      List<RecordSnapshot> record = await store.find(tx.getTx(), finder: finder);
      modelList = await _merge(record, tx, logicDelete);
    });
    return modelList;
  }

  /// 获取逻辑删除条件
  api.Filter? _getLogicFilter(api.Filter? filter, bool isLogicDelete) {
    if (!isLogicDelete) {
      return filter;
    }
    api.Filter logicFindFilter;
    if (null == filter) {
      logicFindFilter = api.SingleFilter.notEquals(field: DataModel.isDeleteKey, value: true);
    } else {
      logicFindFilter = api.GroupFilter.and([
        api.SingleFilter.notEquals(field: DataModel.isDeleteKey, value: true),
        filter,
      ]);
    }
    return logicFindFilter;
  }

  /// 查询首个
  @override
  Future<T?> findFirst({
    api.Transaction? tx,
    api.Filter? filter,
    List<api.Sort>? sorts,
    int? limit,
    int? offset,
    Boundary? start,
    Boundary? end,
    bool? isLogicDelete,
  }) async {
    bool logicDelete = isLogicDelete ?? this.isLogicDelete;
    api.Filter? logicFilter = _getLogicFilter(filter, logicDelete);
    List<SortOrder> sortOrders = [];
    if (sorts != null) {
      for (var one in sorts) {
        SortOrder? oneSortOrder = await convertors.sortConvertor.to(one);
        if (null == oneSortOrder) continue;
        sortOrders.add(oneSortOrder);
      }
    }
    Finder finder = Finder(
      filter: await convertors.filterConvertor.to(logicFilter),
      sortOrders: sortOrders,
      limit: limit,
      offset: offset,
      start: start,
      end: end,
    );
    T? data;
    await withTransaction(tx, (tx) async {
      RecordSnapshot? record = await store.findFirst(tx.getTx(), finder: finder);
      if (null != record) {
        List<T> newModelList = await _merge([record], tx, logicDelete);
        data = newModelList[0];
      }
    });
    return data;
  }

  /// 计数
  @override
  Future<int> count({api.Filter? filter, api.Transaction? tx, bool? isLogicDelete}) async {
    api.Filter? logicFilter = _getLogicFilter(filter, isLogicDelete ?? this.isLogicDelete);
    int num = await store.count(api.Transaction.getOr(tx, dataBase), filter: await convertors.filterConvertor.to(logicFilter));
    return num;
  }

  /// 查询
  Future<List<T>> _merge(List<RecordSnapshot> recordList, api.Transaction? tx, bool isLogicDelete) async {
    // 为空 返回空数组
    if (recordList.isEmpty) return <T>[];
    // 最终的返回结果
    List<T> resultList = [];
    // 讲recordList转换位mapList，便于对数据进行修改
    List<Map<String, Object?>> mapList = [];
    // 遍历查询出的数据，有缓存使用缓存中的数据
    for (RecordSnapshot record in recordList) {
      // 单个数据转换为map
      Map<String, Object?> map = json.decode(json.encode(record.value)) as Map<String, Object?>;
      // 获取dataModel的主键
      String id = map[DataModel.idKey] as String;
      // 查询缓存是否存在当前dataModel
      DataModelCacheNode<T>? cacheNode = DataModelCache.get(id);
      // 缓存不存在，将转换后的结果收集
      if (cacheNode == null) {
        mapList.add(map);
        // 获取一个新的对象
        T newModel = ConstructorCache.get(T);
        // 修改对象的id
        newModel.id.value = id;
        // 未转换的Model先放入undone缓存
        DataModelCache.put(newModel, DataModelCacheType.undone);
        continue;
      }
      // 缓存存在
      // 不需要关心缓存是几级缓存，直接赋值即可，多级缓存只是为了解决循环依赖
      T cacheModel = cacheNode.model;
      resultList.add(cacheModel);
    }
    if (mapList.isNotEmpty) {
      // 填充数据
      List<T> fillList = await _convert(mapList, tx, isLogicDelete);
      // 收集填充后的数据
      resultList.addAll(fillList);
    }
    for (T model in resultList) {
      model.state = States.query;
    }
    return resultList;
  }

  /// 填充数据
  Future<List<T>> _convert(List<Map<String, Object?>> mapList, api.Transaction? tx, bool isLogicDelete) async {
    List<T> modelList = [];
    await withTransaction(tx, (tx) async {
      for (var map in mapList) {
        String id = map[DataModel.idKey] as String;
        // 在merge中，fill之前，已经将mode放入undone缓存中，这里直接取即可
        DataModelCacheNode<T>? cacheNode = DataModelCache.get(id);
        if (cacheNode == null) {
          log("[$runtimeType]:id为$id的数据没有存入缓存");
          continue;
        }
        await convertors.modelConvertor.getModelByModel(cacheNode.model, map, tx: tx, isLogicDelete: isLogicDelete);
        // 转换完成的model缓存升级
        DataModelCache.levelUp(id);
        // 放入数据收集中
        modelList.add(cacheNode.model);
      }
    });
    // 填充后操作
    return modelList;
  }
}
