import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';

class MyAppConfig extends AppConfig {
  MyAppConfig._();

  static MyAppConfig? _instance;

  static MyAppConfig get instance => _instance ??= MyAppConfig._();

  @override
  String get appName => "样例";

  @override
  String get appVersion => "1";
}

void main() {
  AppRunner().run(const MyApp(), MyAppConfig.instance);
}

class MyApp extends App {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget buildHome(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Clickable(
          onPressed: () {},
          tooltip: "tap it",
          child: const Text('hello'),
        ),
      ),
    );
  }
}
