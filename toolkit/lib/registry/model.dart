part of 'registry.dart';

ModelRegistry modelRegistry = ModelRegistry();

typedef NewModel = Model Function();

/// 模型注册表
class ModelRegistry extends Registry<NewModel> {
  ModelRegistry._();

  factory ModelRegistry() => instanceUtil.singleton(ModelRegistry._);
}
