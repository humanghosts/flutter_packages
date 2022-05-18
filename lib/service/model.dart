import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_orm/hg_orm.dart';

abstract class DataModelService<M extends DataModel> extends GetxService {
  M sampleModel = ConstructorCache.get(M);

  /// 获取dao
  DataDao<M> get dao => DaoCache.getByType(M) as DataDao<M>;

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

  Future<void> remove(M model, {Transaction? tx}) async {
    await dao.remove(model, tx: tx);
  }
}

abstract class SimpleModelService<M extends SimpleModel> extends GetxService {
  M get sampleModel => ConstructorCache.get(M);

  /// 获取dao
  SimpleDao<M> get dao => DaoCache.getByType(M) as SimpleDao<M>;

  Future<M> find({Transaction? tx}) async {
    List<M> resultLst = [];
    await dao.withTransaction(tx, (tx) async {
      List<M> modelList = await dao.find(tx: tx);
      if (modelList.isEmpty) {
        M model = ConstructorCache.get(M);
        await save(model, tx: tx);
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
