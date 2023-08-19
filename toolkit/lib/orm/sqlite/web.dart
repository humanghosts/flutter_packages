import 'package:sqlite3/wasm.dart';

Future<CommonSqlite3> open() async {
  WasmSqlite3 sqlite = await WasmSqlite3.loadFromUrl(Uri.parse('sqlite3.wasm'));
  sqlite.registerVirtualFileSystem(
    await IndexedDbFileSystem.open(dbName: 'sqlite3'),
    makeDefault: true,
  );
  return sqlite;
}
