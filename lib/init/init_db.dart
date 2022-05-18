import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/ability/shared_preferences/shared.dart';
import 'package:hg_logger/ability/shared_preferences/shared_key.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../entity/daos.dart';
import '../entity/entities.dart';
import '../entity/init_data.dart';

/// 数据库初始化
Future<void> dbInit() async {
  await SharedPreferencesHelper.init();
  DatabaseListener listener = DatabaseListener(afterDaoRegister: initData);
  await DatabaseHelper.start(
    path: AppConfig.dbConfig.dbFileName,
    databaseType: DatabaseType.sembast,
    getConstructorMap: getEntitiesMap,
    getDaoMap: getDaoMap,
    listener: listener,
  );
}

const String initDbDataKey = SharedPreferencesKeys.isInitAppDatabaseData;

/// 首次启动初始化数据
Future<void> initData() async {
  SharedPreferences prefs = SharedPreferencesHelper.sharedPreferences;
  bool? isInitData = prefs.getBool(initDbDataKey);
  if (isInitData == true) return;
  Map<Type, List<DataModel> Function()> dataMap = getDataModelInitData();
  Map<Type, SimpleModel Function()> sampleDataMap = getSimpleModelInitData();

  await DatabaseHelper.transaction((tx) async {
    for (Type key in dataMap.keys) {
      DataDao dataDao = DaoCache.getByType(key) as DataDao;
      List<DataModel> value = dataMap[key]!.call();
      await dataDao.saveList(value, tx: tx);
    }

    for (Type key in sampleDataMap.keys) {
      SimpleDao simpleDao = DaoCache.getByType(key) as SimpleDao;
      SimpleModel value = sampleDataMap[key]!.call();
      await simpleDao.save(value, tx: tx);
    }
  });

  await prefs.setBool(initDbDataKey, true);
}
