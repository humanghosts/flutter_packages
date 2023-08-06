part of 'entity.dart';

/// 模型
abstract class Model {
  /// 主键
  late final Attribute<int?> id;

  /// 模型属性
  late final Attributes attributes;

  Model({int? id}) {
    instanceUtil.creator(runtimeType, create);
    attributes = Attributes(this);
    this.id = attributes.add('id', id);
  }

  /// 构建
  Model create();

  /// 设置值
  void set(String key, dynamic value) => attributes.get(key)?.value = value;

  /// 获取值
  T? get<T>(String key) => attributes.get(key)?.value as T?;
}
