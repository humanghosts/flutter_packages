part of 'orm.dart';

/// 数据库工具
class DbUtil {
  DbUtil._();

  factory DbUtil() => instanceUtil.singleton(DbUtil._);

  Database? _database;

  Database? get database => _database;

  /// 打开数据库
  void open(String path) {
    _database = sqlite3.open(path);
  }

  /// 打开数据库
  void openInMemory() {
    _database = sqlite3.openInMemory();
  }
}
