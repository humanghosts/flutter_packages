import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_orm/hg_orm.dart';

abstract class DataModelService<M extends DataModel> extends GetxService {
  /// 获取模型
  M get sampleModel => ConstructorCache.get(M);

  /// 获取dao
  DataDao<M> get dao => DaoCache.getByType(M) as DataDao<M>;

  Future<void> withTransaction(Transaction? tx, Future<void> Function(Transaction tx) action) async {
    await dao.withTransaction(tx, action);
  }

  Future<void> transaction(Future<void> Function(Transaction tx) action) async {
    await dao.transaction(action);
  }

  Future<List<M>> find({Transaction? tx}) async {
    return await dao.find(tx: tx);
  }

  Future<M?> findFirst({Transaction? tx}) async {
    return await dao.findFirst(tx: tx);
  }

  Future<M?> findById(String id) async {
    return await dao.findByID(id);
  }

  Future<void> save(M model, {Transaction? tx}) async {
    await dao.save(model, tx: tx);
  }

  Future<void> saveList(List<M> modelList, {Transaction? tx}) async {
    await dao.saveList(modelList, tx: tx);
  }

  Future<void> remove(M model, {Transaction? tx}) async {
    await dao.remove(model, tx: tx);
  }
}

abstract class SimpleModelService<M extends SimpleModel> extends GetxService {
  /// 获取模型
  M get sampleModel => ConstructorCache.get(M);

  /// 获取dao
  SimpleDao<M> get dao => DaoCache.getByType(M) as SimpleDao<M>;

  Future<void> withTransaction(Transaction? tx, Future<void> Function(Transaction tx) action) async {
    await dao.withTransaction(tx, action);
  }

  Future<void> transaction(Future<void> Function(Transaction tx) action) async {
    await dao.transaction(action);
  }

  /// 查询
  Future<M> find({Transaction? tx}) async {
    List<M> resultLst = [];
    await withTransaction(tx, (tx) async {
      List<M> modelList = await dao.find(tx: tx);
      if (modelList.isEmpty) {
        M model = ConstructorCache.get(M);
        await dao.save(model, tx: tx);
        resultLst.add(model);
      } else {
        resultLst.add(modelList.first);
      }
    });
    return resultLst[0];
  }

  Future<void> save(M model, {Transaction? tx}) async {
    await dao.save(model, tx: tx);
  }
}
