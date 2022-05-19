import 'package:hg_entity/hg_entity.dart';
import 'package:hg_orm/hg_orm.dart';

import '../ability/export.dart';

/// 初始化助手
class InitializeHelper {
  InitializeHelper._();

  /// 初始化
  static Future<void> init({
    DatabaseConfig? databaseConfig,
    PresetData? presetData,
    EntityAndDao? entityAndDao,
  }) async {
    // 设备信息初始化
    await DeviceInfoHelper.init();
    // 数据库初始化
    if (null != databaseConfig) {
      await _databaseInit(databaseConfig);
      // 模型和dao注册
      if (null != entityAndDao) {
        // 注册构造器
        entityAndDao.entityMap.forEach((key, value) => ConstructorCache.put(key, value));
        // 注册dao
        entityAndDao.daoMap.forEach((key, value) => DaoCache.put(key, value));
      }
    }
    if (null != presetData) {
      await _presetDataInit(presetData);
    }
    // 初始化通知服务
    await NotificationHelper.init();
  }
}

/// 数据库初始化
Future<void> _databaseInit(DatabaseConfig config) async {
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
Future<void> _presetDataInit(PresetData presetData) async {
  String key = "is_preset_data_init";
  bool? isInitData = DatabaseHelper.database.kv.get(key);
  if (isInitData == true) return;
  Map<Type, List<DataModel> Function()>? dataModelMap = presetData.dataModelMap;
  Map<Type, SimpleModel Function()>? simpleModelMap = presetData.simpleModelMap;
  // 插入数据
  if (null != dataModelMap || null != simpleModelMap) {
    await DatabaseHelper.transaction((tx) async {
      if (null != dataModelMap) {
        for (Type key in dataModelMap.keys) {
          DataDao dataDao = DaoCache.getByType(key) as DataDao;
          List<DataModel> value = dataModelMap[key]!.call();
          await dataDao.saveList(value, tx: tx);
        }
      }
      if (null != simpleModelMap) {
        for (Type key in simpleModelMap.keys) {
          SimpleDao simpleDao = DaoCache.getByType(key) as SimpleDao;
          SimpleModel value = simpleModelMap[key]!.call();
          await simpleDao.save(value, tx: tx);
        }
      }
    });
  }
  await DatabaseHelper.database.kv.putSave(key, true);
}

/// 任务初始化
Future<void> workInit() async {
  // 暂时不需要
  // await BackgroundWorkHelper.init();
  // 前台人物初始化
  await ForegroundWorkHelper.init();
}
