part of 'registry.dart';

RepositoryRegistry repoRegistry = RepositoryRegistry();

typedef NewRepository = Repository Function();

/// 存储库注册表
class RepositoryRegistry extends Registry<NewRepository> {
  RepositoryRegistry._();

  factory RepositoryRegistry() => instanceUtil.singleton(RepositoryRegistry._);
}
