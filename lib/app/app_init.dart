import 'package:hg_entity/hg_entity.dart';
import 'package:hg_framework/ability/shared_preferences/prefs.dart';
import 'package:hg_framework/app/app_config.dart';
import 'package:hg_framework/app/app_logic.dart';
import 'package:hg_framework/entity/entities.dart';
import 'package:hg_orm/hg_orm.dart';

import '../ability/export.dart';

/// 初始化
class AppInit {
  AppInit._();

  /// 初始化
  static Future<void> init(AppConfig config) async {
    // 设备信息初始化
    await DeviceInfoHelper.init();
    // 数据库初始化
    await _databaseInit(config.databaseConfig);
    // 当前包下的模型和dao注册
    getEntitiesMap().forEach(ConstructorCache.put);
    getDaoMap().forEach(DaoCache.put);
    // 传入的模型和dao注册
    config.entityAndDao?.entityMap.forEach(ConstructorCache.put);
    config.entityAndDao?.daoMap.forEach(DaoCache.put);
    // 预置数据
    await _presetDataInit(config.presetData);
    // 主题等数据加载
    await AppLogic.instance.onAppInit(config);
    // 初始化通知服务
    await NotificationHelper.init();
  }
}

/// 数据库初始化
Future<void> _databaseInit(DatabaseConfig config) async {
  await PrefsHelper.init();
  await DatabaseHelper.open(config: config);
}

typedef EntityConstructor = Object Function([Map<String, dynamic>? args]);

/// 所有的模型构造方法和Dao注册
/// Entity注册的时候需要注意依赖关系，被依赖的先注册
/// 如果相互依赖，在先注册entity的构造方法中手动构建后注册的对象，默认对于Model类型的时候通过类型去构造器缓存中取
class EntityAndDao {
  late final Map<Type, EntityConstructor> entityMap;
  late final Map<Type, Dao> daoMap;

  EntityAndDao({Map<Type, EntityConstructor>? entityMap, Map<Type, Dao>? daoMap}) {
    this.entityMap = entityMap ?? {};
    this.daoMap = daoMap ?? {};
  }
}

/// 预置数据
class PresetData {
  final Map<Type, List<DataModel> Function()>? dataModelMap;
  final Map<Type, SimpleModel Function()>? simpleModelMap;

  PresetData({this.dataModelMap, this.simpleModelMap});
}

/// 首次启动初始化预置数据
Future<void> _presetDataInit(PresetData? presetData) async {
  String key = "is_preset_data_init";
  bool? isInitData = DatabaseHelper.database.kv.get(key);
  if (isInitData == true) return;
  Map<Type, List<DataModel> Function()> dataModelMap = presetData?.dataModelMap ?? {};
  Map<Type, SimpleModel Function()> simpleModelMap = presetData?.simpleModelMap ?? {};
  dataModelMap.addAll(getDataModelInitData());
  simpleModelMap.addAll(getSimpleModelInitData());
  // 插入数据
  await DatabaseHelper.transaction((tx) async {
    for (Type key in dataModelMap.keys) {
      DataDao dataDao = DaoCache.getByType(key) as DataDao;
      List<DataModel> value = dataModelMap[key]!.call();
      await dataDao.saveList(value, tx: tx);
    }
    for (Type key in simpleModelMap.keys) {
      SimpleDao simpleDao = DaoCache.getByType(key) as SimpleDao;
      SimpleModel value = simpleModelMap[key]!.call();
      await simpleDao.save(value, tx: tx);
    }
  });
  await DatabaseHelper.database.kv.putSave(key, true);
}

/// 任务初始化
Future<void> workInit() async {
  // 暂时不需要
  // await BackgroundWorkHelper.init();
  // 前台人物初始化
  await ForegroundWorkHelper.init();
}
