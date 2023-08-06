part of 'utils.dart';

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

  /// 构造器缓存
  final Map<String, Function()> _creatorMap = {};

  /// 注册缓存,Type最好不要带？
  void creator<T>(Type type, T Function() creator) {
    String typeStr = type.toString();
    String realTypeStr;
    if (type.toString().endsWith("?")) {
      realTypeStr = typeStr.substring(0, typeStr.length - 1);
    } else {
      realTypeStr = typeStr;
    }
    String realTypeStrNullable = "$realTypeStr?";
    _creatorMap[realTypeStr] = creator;
    _creatorMap[realTypeStrNullable] = creator;
  }

  /// 通过类型获取构造器
  T? create<T>(Type type) => _creatorMap[type.toString()]?.call();
}
