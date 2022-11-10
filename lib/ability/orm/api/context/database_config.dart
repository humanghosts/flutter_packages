import 'package:hg_framework/ability/orm/orm.dart';

/// 数据库配置
abstract class DatabaseConfig {
  /// 数据库
  final Database database;

  DatabaseConfig(this.database);
}
