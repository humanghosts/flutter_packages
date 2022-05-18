import 'dart:developer';

import 'package:get_storage/get_storage.dart';

/// 系统级别的kv存储库
class GetStorageHelper {
  GetStorageHelper._();

  /// 全局容器 容器名称使用默认的"default"
  static GetStorage? _box;

  /// 初始化get_storage
  static Future<void> initialize({String name = "default"}) async {
    if (null == _box) {
      // 初始化
      bool isInit = await GetStorage.init(name);
      if (isInit) {
        // 创建容器
        _box = GetStorage(name);
      }
      log("GetStorage初始化${isInit ? "成功" : "失败"}，容器名称:$name");
    } else {
      log("GetStorage已初始化，无需重复初始化");
    }
  }

  /// 获取全局容器
  static GetStorage get box {
    assert(_box != null, "GetStorage尚未初始化");
    return _box!;
  }

  static GetStorage get() {}
}
