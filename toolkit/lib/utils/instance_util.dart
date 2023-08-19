part of 'utils.dart';

InstanceUtil instanceUtil = InstanceUtil();

/// 实例工具
class InstanceUtil {
  static InstanceUtil? _instance;

  InstanceUtil._();

  factory InstanceUtil() => _instance ??= InstanceUtil._();

  /// 单例模式的key
  final _singletonKey = "singleton";

  /// 工厂实例缓存
  final Map<dynamic, Map<String, dynamic>> _factoryMap = {};

  /// 工厂模式
  T factory<T>(String key, T Function() create) => _factoryMap.putIfAbsent(T, () => {}).putIfAbsent(key, create) as T;

  /// 单例模式
  T singleton<T>(T Function() create) => factory(_singletonKey, create);
}
