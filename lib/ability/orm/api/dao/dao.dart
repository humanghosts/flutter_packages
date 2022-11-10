import 'package:hg_framework/ability/orm/orm.dart';
import 'package:hg_framework/ability/entity/entity.dart';

/// dao的基类
abstract class Dao<T extends Model> {
  /// 类型转换
  late final Convertors _convertors;

  /// 转换器
  Convertors get convertors => _convertors;

  Dao({required Convertors convertors}) : _convertors = convertors;

  /// 新建一个事务
  Future<void> transaction(Future<void> Function(Transaction tx) action);

  /// 有事务使用当前事务，没有事务新建一个事务
  Future<void> withTransaction(Transaction? tx, Future<void> Function(Transaction tx) action);

  /// 保存
  Future<void> save(T model, {Transaction? tx});

  /// 更新
  Future<void> update(String id, Map<String, Object?> value, {Transaction? tx});

  /// 删除
  Future<void> remove(T model, {Transaction? tx});

  /// 删除全部
  Future<void> removeAll({Transaction? tx});

  /// 查询
  Future<List<T>> find({Transaction? tx});

  // === 操作原生map数据 ===

  /// 保存
  Future<void> saveRaw(Map<String, Object?> model, {Transaction? tx});

  /// 删除
  Future<void> removeRaw(Map<String, Object?> model, {Transaction? tx});

  /// 查询原生数据
  Future<List<Map<String, Object?>>> findRaw({Transaction? tx});
}

/// 用于数据模型(通过id作为数据标识)的dao基类
abstract class DataDao<T extends DataModel> extends Dao<T> {
  /// 是否开启逻辑删除
  late final bool _isLogicDelete;

  DataDao({
    bool? isLogicDelete,
    required Convertors convertors,
  }) : super(convertors: convertors) {
    _isLogicDelete = isLogicDelete ?? DatabaseHelper.instance.database.isLogicDelete;
  }

  bool get isLogicDelete => _isLogicDelete;

  /// 保存
  @override
  Future<void> save(T model, {Transaction? tx, bool? isLogicDelete});

  /// 存储列表
  Future<void> saveList(List<T> modelList, {Transaction? tx, bool? isLogicDelete});

  /// 更新
  @override
  Future<void> update(String id, Map<String, Object?> value, {Transaction? tx});

  /// 更新列表
  Future<void> updateList(List<String> idList, Map<String, Object?> value, {Transaction? tx});

  /// 条件更新
  Future<void> updateWhere(Filter filter, Map<String, Object?> value, {Transaction? tx});

  /// 删除
  @override
  Future<void> remove(T model, {Transaction? tx, bool? isLogicDelete});

  /// 移除列表
  Future<void> removeList(List<T> modelList, {Transaction? tx, bool? isLogicDelete});

  /// 条件删除
  Future<void> removeWhere(Filter filter, {Transaction? tx, bool? isLogicDelete});

  /// 删除恢复
  Future<void> recover(T model, {Transaction? tx});

  /// 恢复列表
  Future<void> recoverList(List<T> modelList, {Transaction? tx});

  /// 条件恢复
  Future<void> recoverWhere(Filter filter, {Transaction? tx});

  /// 查找
  @override
  Future<List<T>> find({Filter? filter, List<Sort>? sorts, Transaction? tx, bool? isLogicDelete});

  /// 查找符合条件的第一个
  Future<T?> findFirst({Filter? filter, List<Sort>? sorts, Transaction? tx, bool? isLogicDelete});

  /// 通过ID查询
  Future<T?> findByID(String id, {Transaction? tx, bool? isLogicDelete});

  /// 通过ID查询
  Future<List<T>> findByIDList(List<String> id, {Transaction? tx, bool? isLogicDelete});

  /// 计数
  Future<int> count({Filter? filter, Transaction? tx, bool? isLogicDelete});

  /// 保存
  @override
  Future<void> saveRaw(Map<String, Object?> model, {Transaction? tx, bool? isLogicDelete});

  /// 删除
  @override
  Future<void> removeRaw(Map<String, Object?> model, {Transaction? tx, bool? isLogicDelete});

  /// 查询原生数据
  @override
  Future<List<Map<String, Object?>>> findRaw({Filter? filter, List<Sort>? sorts, Transaction? tx, bool? isLogicDelete});
}

abstract class DataTreeDao<T extends DataTreeModel> extends DataDao<T> {
  DataTreeDao({
    bool? isLogicDelete,
    required Convertors convertors,
  }) : super(isLogicDelete: isLogicDelete, convertors: convertors);

  /// [isRemoveChildren] 指是否同时删除子事件
  @override
  Future<void> remove(T model, {Transaction? tx, bool? isLogicDelete, bool isRemoveChildren = true});

  /// 按树查找
  Future<List<T>> findTree({Filter? filter, List<Sort>? sorts, Transaction? tx, bool? isLogicDelete});

  /// 列表变树
  List<T> listToTree(List<T> modelList);

  /// 树变列表
  List<T> treeToList(List<T> modelList);
}

/// 用于普通模型(只有一个模型)的dao
abstract class SimpleDao<T extends SimpleModel> extends Dao<T> {
  SimpleDao({required Convertors convertors}) : super(convertors: convertors);
}
