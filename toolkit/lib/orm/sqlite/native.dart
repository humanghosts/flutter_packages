import 'package:sqlite3/sqlite3.dart';

Future<CommonSqlite3> open() async {
  return sqlite3;
}
