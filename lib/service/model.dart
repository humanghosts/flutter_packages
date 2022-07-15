import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_orm/hg_orm.dart';

abstract class ModelService<M extends Model, D extends Dao<M>> extends GetxService {
  /// 获取模型
  M get sampleModel => ConstructorCache.get(M);

  /// 获取dao
  D get dao => DaoCache.getByType(M) as D;

  /// 转换为map数据
  Future<Map<String, Object?>?> convertToMap(M model) async {
    return await dao.convertors.modelConvertor.getValue(model);
  }

  /// 加入事务
  Future<void> withTransaction(Transaction? tx, Future<void> Function(Transaction tx) action) async {
    await dao.withTransaction(tx, action);
  }

  /// 开启事务
  Future<void> transaction(Future<void> Function(Transaction tx) action) async {
    await dao.transaction(action);
  }

  Future<List<M>> findAll();

  Future<void> save(M model, {Transaction? tx}) async {
    await dao.save(model, tx: tx);
  }

  Future<void> remove(M model, {Transaction? tx}) async {
    await dao.remove(model, tx: tx);
  }
}

class DataModelService<M extends DataModel> extends ModelService<M, DataDao<M>> {
  Future<List<M>> find({Transaction? tx}) async {
    return await dao.find(tx: tx);
  }

  Future<M?> findFirst({Transaction? tx}) async {
    return await dao.findFirst(tx: tx);
  }

  Future<M?> findById(String id) async {
    return await dao.findByID(id);
  }

  Future<void> saveList(List<M> modelList, {Transaction? tx}) async {
    await dao.saveList(modelList, tx: tx);
  }

  @override
  Future<List<M>> findAll({Transaction? tx}) async {
    return await dao.find(tx: tx);
  }
}

class SimpleModelService<M extends SimpleModel> extends ModelService<M, SimpleDao<M>> {
  /// 查询
  Future<M> find({Transaction? tx}) async {
    return (await findAll(tx: tx))[0];
  }

  @override
  Future<List<M>> findAll({Transaction? tx}) async {
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
    return resultLst;
  }
}
