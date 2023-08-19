import 'package:ohohoo_toolkit/model/model.dart';
import 'package:ohohoo_toolkit/orm/orm.dart';
import 'package:ohohoo_toolkit/utils/utils.dart';

part 'model.dart';

part 'repository.dart';

/// 注册表
/// 因为flutter中不可以使用反射，所以导致ORM比较难实现。
/// 又因为比较反感代码生成。
/// 因此使用注册表形式处理。
abstract class Registry<R> {
  /// 注册内容
  final Map<String, R> _recordMap = {};

  Registry put(Type type, R record) {
    String typeStr = type.toString();
    String realTypeStr;
    // 判断是否可空类型
    if (type.toString().endsWith("?")) {
      realTypeStr = typeStr.substring(0, typeStr.length - 1);
    } else {
      realTypeStr = typeStr;
    }
    String realTypeStrNullable = "$realTypeStr?";
    _recordMap[realTypeStr] = record;
    _recordMap[realTypeStrNullable] = record;
    return this;
  }

  T? getByType<T extends R>(Type type) => _recordMap[type.toString()] as T?;

  T? getByString<T extends R>(String type) => _recordMap[type] as T?;
}
