import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

void main() async {
  AppConfigItem appConfigItem = AppConfigItem();
  FutureOr doInit = appConfigItem.doInit();
  if (doInit is Future) {
    await doInit;
  }
  print(appConfigItem.isInit);
}

/// 应用配置项
class AppConfigItem {
  /// 配置项目是否初始化
  bool _isInit = false;

  bool get isInit => _isInit;

  /// 指定初始化
  FutureOr<void> doInit() async {
    if (isInit == true) return;
    FutureOr<void> initFunc = init();
    if (initFunc is Future) {
      await initFunc;
    }
    _isInit = true;
  }

  /// 配置初始化
  FutureOr<void> init() async {
    print('hhh');
    await Future.delayed(new Duration(seconds: 3));
    throw Exception("123");
    int i = 0;
    int j = i++;
    print(i);
    print(j);
  }
}
