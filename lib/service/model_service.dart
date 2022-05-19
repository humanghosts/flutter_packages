import 'package:get/get.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_orm/hg_orm.dart';

abstract class DataModelService<M extends DataModel> extends GetxService {
  /// 获取模型
  M get sampleModel => ConstructorCache.get(M);

  /// 获取dao
  DataDao<M> get dao => DaoCache.getByType(M) as DataDao<M>;
}

abstract class SimpleModelService<M extends SimpleModel> extends GetxService {
  /// 获取模型
  M get sampleModel => ConstructorCache.get(M);

  /// 获取dao
  SimpleDao<M> get dao => DaoCache.getByType(M) as SimpleDao<M>;

  /// 查询
  Future<M> find({Transaction? tx}) async {
    List<M> resultLst = [];
    await dao.withTransaction(tx, (tx) async {
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
}
