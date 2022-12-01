import 'package:flutter/material.dart';
import 'package:hgs_framework/framework.dart';
import 'package:hgs_toast/toast.dart';

import 'config.dart';

void main() {
  AppHelper().run(const DefaultApp(), DefaultAppConfig());
}

class DefaultApp extends App {
  const DefaultApp({Key? key}) : super(key: key);

  @override
  Widget buildHome(BuildContext context) {
    return DefaultHomeView(key: "default_home_view");
  }
}

class DefaultHomeLogic extends ViewLogicOnly {}

class DefaultHomeView extends View<DefaultHomeLogic> {
  DefaultHomeView({required String key}) : super(key: key, logic: DefaultHomeLogic());

  @override
  Widget buildView(BuildContext context) {
    // 返回应用主页
    return Scaffold(
      appBar: AppBar(
        title: Text("${appConfig.appName}_${appConfig.appVersion}"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            ToastHelper().toast(msg: "oho");
          },
          child: const Text("humanghosts"),
        ),
      ),
    );
  }
}
