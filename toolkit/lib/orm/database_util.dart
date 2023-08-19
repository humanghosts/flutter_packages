part of 'orm.dart';

/// 数据库工具
class DbUtil {
  DbUtil._();

  factory DbUtil() => instanceUtil.singleton(DbUtil._);

  CommonDatabase? _database;

  CommonDatabase? get database => _database;

  late CommonSqlite3 sqlite3;

  Future<void> init() async {
    sqlite3 = await sqlite.open();
  }

  /// 打开数据库
  void open(String path) {
    _database = sqlite3.open(path);
  }

  /// 打开数据库
  void openInMemory() {
    _database = sqlite3.openInMemory();
  }
}
