enum States {
  /// 无状态,新建的模型属于这个状态
  none,

  /// 新增,说明这个模型刚插入到数据库中
  insert,

  /// 更新,说明这个模型刚更新到数据库中
  update,

  /// 删除,说明这个模型刚被从数据库中删除
  delete,

  /// 查询,说明这个模型刚从数据库中查询出来，没有做任何操作
  query,
}
