/// 构造器缓存
class ConstructorCache {
  ConstructorCache._();

  /// 构造器缓存
  static final Map<String, Object Function([Map<String, dynamic>? args])> _cache = {};

  /// 类型字符串与类型缓存
  static final Map<String, Type> _typeCache = {};

  /// 注册缓存,Type最好不要带？
  static void put(Type type, Object Function([Map<String, dynamic>? args]) constructor, {List<String> alias = const []}) {
    String typeStr = type.toString();
    String realTypeStr;
    if (type.toString().endsWith("?")) {
      realTypeStr = typeStr.substring(0, typeStr.length - 1);
    } else {
      realTypeStr = typeStr;
    }
    String realTypeStrNullable = "$realTypeStr?";
    _cache[realTypeStr] = constructor;
    _cache[realTypeStrNullable] = constructor;
    _typeCache[realTypeStr] = type;
    _typeCache[realTypeStrNullable] = type;
    for (String alia in alias) {
      _cache[alia] = constructor;
      _typeCache[alia] = type;
    }
  }

  /// 通过类型字符串获取类型
  static Type getType(String type) {
    Type? t = _typeCache[type];
    assert(null != t, "类型$type尚未注册");
    return t!;
  }

  /// 通过类型获取构造器
  static T get<T>(Type type, [Map<String, dynamic>? args]) {
    return getByStr("$type");
  }

  /// 通过类型字符串获取构造器
  static T getByStr<T>(String type, [Map<String, dynamic>? args]) {
    assert(_cache.containsKey(type), "无法使用，类型$type尚未注册");
    return _cache[type]!.call(args) as T;
  }

  /// 判断是否包含类型
  static bool containsKey(Type type) {
    return containsKeyStr("$type");
  }

  /// 通过字符串判断是否包含类型
  static bool containsKeyStr(String type) {
    return _cache.containsKey(type);
  }
}
