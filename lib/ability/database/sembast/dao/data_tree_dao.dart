import 'package:hg_framework/ability/database/cache/data_model_cache.dart';
import 'package:hg_framework/ability/entity/entity.dart';
import 'package:sembast/sembast.dart';

import '../../api/api.dart' as api;
import 'data_dao.dart';

/// 树形公共的规范与实现
class SembastDataTreeDao<T extends DataTreeModel> extends SembastDataDao<T> implements api.DataTreeDao<T> {
  SembastDataTreeDao({bool? isLogicDelete}) : super(isLogicDelete: isLogicDelete);

  @override
  Future<void> save(T model, {api.Transaction? tx, bool? isLogicDelete}) async {
    // 子节点
    List<T> children = <T>[];
    if (model.children.value.isNotEmpty) {
      for (DataModel child in model.children.value) {
        children.add(child as T);
      }
    }
    await withTransaction(tx, (tx) async {
      await saveList(children, tx: tx, isLogicDelete: isLogicDelete);
      await super.save(model, tx: tx, isLogicDelete: isLogicDelete);
    });
  }

  @override
  Future<void> remove(T model, {api.Transaction? tx, bool? isLogicDelete, bool isRemoveChildren = true}) async {
    List<T> children = <T>[];
    if (model.children.value.isNotEmpty) {
      for (DataModel child in model.children.value) {
        children.add(child as T);
      }
    }
    await withTransaction(tx, (tx) async {
      if (isRemoveChildren) await removeList(children, tx: tx, isLogicDelete: isLogicDelete);
      await super.remove(model, tx: tx, isLogicDelete: isLogicDelete);
    });
  }

  /// 删除的时候同时删除他们的下级
  /// 上级保存的下级惰性删除即可
  @override
  @override
  Future<void> removeWhere(api.Filter filter, {api.Transaction? tx, bool? isLogicDelete}) async {
    List<String> removeIdList = [];
    await withTransaction(tx, (tx) async {
      List<String> idList = await _getTreeIdList(filter, tx, isLogicDelete: isLogicDelete) as List<String>;
      if (idList.isEmpty) {
        return;
      }
      // 换成id的过滤条件，简化一下
      Finder finder = Finder(filter: Filter.inList(DataModel.idKey, idList));
      bool logicDelete = isLogicDelete ?? this.isLogicDelete;
      if (logicDelete) {
        // 逻辑删除
        await store.update(
            tx.getTx(),
            {
              DataModel.isDeleteKey: true,
              DataModel.deleteTimeKey: convertors.attributeConvertor.datetime.getValue(DateTime.now()),
              DataModel.timestampKey: convertors.attributeConvertor.datetime.getValue(DateTime.now()),
            },
            finder: finder);
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

  Future<List> _getTreeIdList(api.Filter filter, api.Transaction tx, {bool? isLogicDelete}) async {
    // 查询要删除的模型,这理不需要翻译，不用使用find方法
    List<RecordSnapshot> recordList = await store.find(tx.getTx(), finder: Finder(filter: await convertors.filterConvertor.to(filter)));
    // 没有要删除的返回空
    if (recordList.isEmpty) {
      return [];
    }
    List<String> idList = [];
    List<Filter> filters = [];
    for (RecordSnapshot record in recordList) {
      Map<String, Object?> map = record.value as Map<String, Object?>;
      idList.add(map[DataModel.idKey] as String);
      // 全路径 肯定存在，不存在就算了
      Object? fullPathValue = map[DataTreeModel.fullPathKey];
      if (null == fullPathValue) {
        continue;
      }
      String fullPath = fullPathValue as String;
      // 下级过滤条件
      filters.add(Filter.matches(DataTreeModel.fullPathKey, "^(${fullPath.replaceAll("|", "\\|")}\\|)[0-9a-zA-Z|]+\$"));
    }
    filters.insert(0, Filter.inList(DataModel.idKey, idList));
    return await store.findKeys(tx.getTx(), finder: Finder(filter: Filter.or(filters)));
  }

  @override
  Future<void> recover(T model, {api.Transaction? tx}) async {
    List<T> children = <T>[];
    if (model.children.value.isNotEmpty) {
      for (DataModel child in model.children.value) {
        children.add(child as T);
      }
    }
    await withTransaction(tx, (tx) async {
      await recoverList(children, tx: tx);
      await super.recover(model, tx: tx);
    });
    model.state = States.update;
  }

  /// 恢复的时候同时恢复下级
  @override
  Future<void> recoverWhere(api.Filter filter, {api.Transaction? tx, bool? isLogicDelete}) async {
    List<String> recoverIdList = [];
    await withTransaction(tx, (tx) async {
      List<String> idList = await _getTreeIdList(filter, tx, isLogicDelete: isLogicDelete) as List<String>;
      if (idList.isEmpty) return;
      // 换成id的过滤条件，简化一下
      Finder finder = Finder(filter: Filter.inList(DataModel.idKey, idList));
      await store.update(
          tx.getTx(),
          {
            DataModel.isDeleteKey: false,
            DataModel.deleteTimeKey: null,
            DataModel.timestampKey: convertors.attributeConvertor.datetime.getValue(DateTime.now()),
          },
          finder: finder);
      recoverIdList = idList;
    });
    // 按照同样的条件查询一下id，防止缓存和数据库不一致
    for (var id in recoverIdList) {
      DataModelCache.remove(id);
    }
  }

  /// 按树查找
  /// 先全查回来，然后组装成树
  @override
  Future<List<T>> findTree({
    api.Transaction? tx,
    api.Filter? filter,
    List<api.Sort>? sorts,
    int? limit,
    int? offset,
    Boundary? start,
    Boundary? end,
    bool? isLogicDelete,
  }) async {
    List<T> modelList = await find(
      filter: filter,
      sorts: sorts,
      limit: limit,
      offset: offset,
      start: start,
      end: end,
      tx: tx,
      isLogicDelete: isLogicDelete,
    );
    return listToTree(modelList);
  }

  @override
  List<T> listToTree(List<T> modelList) {
    if (modelList.isEmpty) return modelList;
    // fullPath:Model
    Map<String, T> modelMap = {};
    List<String> fullPathList = [];
    for (T model in modelList) {
      modelMap[model.fullPath.value] = model;
      fullPathList.add(model.fullPath.value);
    }
    // 按照长度排序
    fullPathList.sort((a, b) => a.length.compareTo(b.length));
    // 如果某个节点的上级在，这个节点不应该存在，无论是否为直接上级
    modelMap.removeWhere((key, value) {
      for (String fullPath in fullPathList) {
        if (key.length <= fullPath.length) {
          break;
        }
        if (key.contains("$fullPath|")) {
          fullPathList.remove(key);
          return true;
        }
      }
      return false;
    });
    // 填返回根节点
    return modelMap.values.toList();
  }

  @override
  List<T> treeToList(List<T> modelTree) {
    List<T> modelList = [];
    for (T model in modelTree) {
      modelList.addAll(_treeNodeToList(model));
    }
    return modelList;
  }

  List<T> _treeNodeToList(T model) {
    List<T> modelList = [model];
    if (model.children.isNull) return modelList;
    List<T> children = model.children.value as List<T>;
    for (T child in children) {
      modelList.addAll(_treeNodeToList(child));
    }
    return modelList;
  }
}
