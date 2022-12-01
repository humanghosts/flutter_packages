import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';

void main() {
  /// 传入应用和应用配置来运行应用
  AppRunner().run(const Marde(), MardeConfig());
}

/// 应用配置
class MardeConfig extends AppConfig {
  /// 单例模式代码
  MardeConfig._();

  static MardeConfig? _instance;

  factory MardeConfig() => _instance ??= MardeConfig._();

  @override
  String get appName => "码得";

  @override
  String get appVersion => "0.0.1";
}

class Marde extends App {
  const Marde({Key? key}) : super(key: key);

  @override
  Widget buildHome(BuildContext context) {
    return MyHomeView(key: "marde_home");
  }
}

class MyHomeLogic extends ViewLogicOnly {
  Timer? timer;
  RxDouble countdown = 3.0.obs;
}

class MyHomeView extends View<MyHomeLogic> {
  MyHomeView({required String key}) : super(key: key, logic: MyHomeLogic());

  @override
  Widget buildView(BuildContext context) {
    // 返回应用主页
    return Scaffold(
      appBar: AppBar(
        title: Text("${appConfig.appName}_${appConfig.appVersion}"),
      ),
      body: Center(
        child: Icon(IconParks.addWeb.toIconData(), size: 200, color: Colors.blue),
      ),
    );
  }
}
