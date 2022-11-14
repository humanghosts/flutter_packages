import 'dart:convert';

import 'package:hg_framework/ability/database/database.dart';
import 'package:hg_framework/ability/entity/entity.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast.dart' as sembast;

import '../../api/api.dart' as api;

/// 公共的规范与实现
class SembastSimpleDao<T extends SimpleModel> extends api.SimpleDao<T> {
  /// 获取实体所在存储库的名称
  late StoreRef store;

  /// 获取数据库实例
  sembast.Database get dataBase => (DatabaseHelper().database as SembastDatabase).database;

  /// 数据库地址
  late String _storeName;

  SembastSimpleDao({String? storeName}) : super(convertors: SembastConvertors.instance) {
    _storeName = storeName ?? T.toString();
    store = stringMapStoreFactory.store("simple");
  }

  @override
  SembastConvertors get convertors => super.convertors as SembastConvertors;

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

  /// 保存，存在更新，不存在插入
  @override
  Future<void> save(T model, {api.Transaction? tx}) async {
    States oldStates = model.state;
    await store.record(_storeName).put(api.Transaction.getOr(tx, dataBase), await convertors.modelConvertor.getValue(model, tx: tx, isLogicDelete: true));
    if (oldStates == States.none) {
      model.state = States.insert;
    } else {
      model.state = States.update;
    }
  }

  @override
  Future<void> saveRaw(Map<String, Object?> model, {api.Transaction? tx}) async {
    await store.record(_storeName).put(api.Transaction.getOr(tx, dataBase), model);
  }

  @override
  Future<void> remove(T model, {api.Transaction? tx}) async {
    await store.record(_storeName).delete(api.Transaction.getOr(tx, dataBase));
    model.state = States.delete;
  }

  @override
  Future<void> removeAll({api.Transaction? tx}) async {
    await store.delete(api.Transaction.getOr(tx, dataBase));
  }

  @override
  Future<void> removeRaw(Map<String, Object?> model, {api.Transaction? tx}) async {
    await store.record(_storeName).delete(api.Transaction.getOr(tx, dataBase));
  }

  @override
  Future<void> update(String id, Map<String, Object?> value, {api.Transaction? tx}) async {
    await store.record(_storeName).update(api.Transaction.getOr(tx, dataBase), value);
  }

  @override
  Future<List<Map<String, Object?>>> findRaw({api.Transaction? tx}) async {
    List<Map<String, Object?>> modelList = [];
    await withTransaction(tx, (tx) async {
      Object? value = await store.record(_storeName).get(tx.getTx());
      if (null == value) return;
      Map<String, Object?> map = json.decode(json.encode(value)) as Map<String, Object?>;
      modelList.add(map);
    });
    return modelList;
  }

  @override
  Future<List<T>> find({api.Transaction? tx}) async {
    List<T> modelList = [];
    await withTransaction(tx, (tx) async {
      Object? value = await store.record(_storeName).get(tx.getTx());
      if (null == value) return;
      Map<String, Object?> map = json.decode(json.encode(value)) as Map<String, Object?>;
      T t = ConstructorCache.get(T);
      await convertors.modelConvertor.getModelByModel(t, map, tx: tx, isLogicDelete: true);
      t.state = States.query;
      modelList.add(t);
    });
    for (T model in modelList) {
      model.state = States.query;
    }
    return modelList;
  }
}
