library entity;

import 'dart:async';

import 'package:hg_framework/hg_framework.dart';

import '../cache/export.dart';

export 'package:get/get.dart';

export '../attribute/export.dart';
export '../cache/export.dart';
export '../enum/export.dart';
export '../model/export.dart';
export '../util/export.dart';

/// 实体助手，用于注册实体构造方法
class EntityHelper extends AppInitPlugin {
  EntityHelper._({this.entityRegister});

  factory EntityHelper({EntityRegister? entityRegister}) => SingletonCache.putIfAbsent(EntityHelper._(entityRegister: entityRegister));

  /// 实体注册器
  EntityRegister? entityRegister;

  @override
  FutureOr<bool> init(AppConfig config) {
    Map<Type, EntityConstructor>? entityMap = entityRegister?.entityMap;
    Map<Type, List<String>>? entityAlias = entityRegister?.entityAlias;
    entityMap?.forEach((key, value) {
      List<String>? alias = entityAlias?[key];
      ConstructorCache.put(key, value, alias: alias ?? []);
    });
    return true;
  }
}

/// 实体注册器
abstract class EntityRegister {
  /// 获取实体类型及其构造方法
  /// 需要注意依赖关系，被依赖的先注册
  /// 如果相互依赖，在先注册entity的构造方法中手动构建后注册的对象，默认对于Model类型的时候通过类型去构造器缓存中取
  Map<Type, EntityConstructor> get entityMap;

  /// 获取实体别名
  Map<Type, List<String>> get entityAlias;
}
