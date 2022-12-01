import 'package:hgs_database_api/database_api.dart';

/// dao的缓存，相当于一个dao的单例池
class DaoCache {
  DaoCache._();

  /// 缓存池
  static final Map<String, Dao> _cache = {};

  /// 存放缓存
  static void put(Type type, Dao dao) {
    String typeStr = type.toString();
    String realTypeStr;
    if (typeStr.endsWith("?")) {
      realTypeStr = typeStr.substring(0, typeStr.length - 1);
    } else {
      realTypeStr = typeStr;
    }
    String realTypeStrNullable = "$realTypeStr?";
    _cache[realTypeStr] = dao;
    _cache[realTypeStrNullable] = dao;
  }

  /// 通过类型获取Dao
  static Dao getByType<T extends Dao>(Type type) {
    return getByStr(type.toString());
  }

  /// 通过类型字符串取，需要先在cache中注册
  static Dao getByStr(String type) {
    assert(_cache.containsKey(type), "register ${type.toString()}'s first");
    return _cache[type]!;
  }
}
