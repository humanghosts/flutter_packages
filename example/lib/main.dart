import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:hg_orm/hg_orm.dart';

class HgLoggerConfig extends AppConfig {
  HgLoggerConfig._();

  static HgLoggerConfig? _instance;

  static HgLoggerConfig get instance => _instance ??= HgLoggerConfig._();

  @override
  String get appName => "样例";

  @override
  DatabaseConfig get databaseConfig => SembastConfig(path: 'example_hg_framework.db');
}

void main() {
  AppHelper.run(app: const MyApp(), appConfig: HgLoggerConfig.instance);
}

class MyApp extends App {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget buildHome(BuildContext context) {
    return Home(key: "home");
  }
}

/// 逻辑
class HomeLogic extends ViewLogicOnly {}

/// 页面
class Home extends View<HomeLogic> {
  Home({required String key}) : super(key: key, logic: HomeLogic());

  @override
  Widget buildView(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text('\u{1f600}'),
    );
  }
}
