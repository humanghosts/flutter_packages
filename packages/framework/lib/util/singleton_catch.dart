/// 单例模式缓存，用于简化单例模式写法
class SingletonCache {
  SingletonCache._();

  /// 缓存
  static final Map<String, Object> _cache = {};

  /// 添加单例缓存
  static T putIfAbsent<T extends Object>(T obj, {String? key}) {
    return _cache.putIfAbsent(key ?? T.toString(), () => obj) as T;
  }

  /// 获取单例缓存
  static T? get<T extends Object>({String? key}) {
    return _cache[key ?? T.toString()] as T?;
  }

  /// 再确定可以获取到缓存的情况下再使用，否则会报错
  /// 只是为了减少代码中的?
  static T getNonNull<T extends Object>({String? key}) {
    return _cache[key ?? T.toString()] as T;
  }
}
