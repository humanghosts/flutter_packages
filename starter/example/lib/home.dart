import 'package:flutter/material.dart';
import 'package:hgs_starter/starter.dart';

/// 主页控制器
class DefaultHomeLogic extends ViewLogicOnly {}

/// 主页
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
