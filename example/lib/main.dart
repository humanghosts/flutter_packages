import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
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
  AppHelper.run(const MyApp(), HgLoggerConfig.instance);
}

class MyApp extends App {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget buildHome(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: TextButton(
          onPressed: () async {
            await Window.makeTitlebarTransparent();
            await Window.enableFullSizeContentView();
            await Window.hideTitle();
            await Window.setEffect(effect: WindowEffect.aero);
          },
          child: const Text('\u{1f600}'),
        ),
      ),
    );
  }
}
