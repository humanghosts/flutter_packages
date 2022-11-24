import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hg_framework/hg_framework.dart';

void main() {
  /// 传入应用和应用配置来运行应用
  AppRunner().run(const MyApp(), MyAppConfig());
}

/// 应用配置
class MyAppConfig extends AppConfig {
  /// 单例模式代码
  MyAppConfig._();

  static MyAppConfig? _instance;

  factory MyAppConfig() => _instance ??= MyAppConfig._();

  @override
  String get appName => "示例应用";

  @override
  String get appVersion => "0.0.1";
}

class MyApp extends App {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget buildHome(BuildContext context) {
    return MyHomeView(key: "my_home_view");
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
        child: [
          Clickable(
            onPressed: () {
              ToastHelper().toast(msg: "这是一个提示", duration: const Duration(seconds: 3));
            },
            clickableType: ClickableType.elevatedButton,
            child: const Text('提示'),
          ),
          Clickable(
            onPressed: () async {
              if (logic.timer != null) return;
              logic.timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
                logic.countdown.value -= 0.2;
                if (logic.countdown <= 0) {
                  logic.timer?.cancel();
                  logic.timer = null;
                  ToastHelper().closeInAppNotification("in_app");
                  logic.countdown.value = 3.0;
                }
              });
              ToastHelper().inAppNotification(
                key: "in_app",
                title: "这是一个通知 3秒之后自动消失",
                messageWidget: Obx(() {
                  double countdown = logic.countdown.value;
                  String text;
                  if (countdown <= 0) {
                    text = "完成";
                  } else {
                    text = countdown.toInt().toString();
                  }
                  return Text(text);
                }),
                leading: const Icon(Icons.notifications),
              );
            },
            clickableType: ClickableType.elevatedButton,
            forceTooltip: true,
            child: const Text('通知'),
          ),
          Clickable(
            onPressed: () {
              ToastHelper().showContextMenu(
                context,
                position: Offset.zero,
                valueList: [1, 2, 3],
                childBuilder: (value) {
                  String text;
                  switch (value) {
                    case 1:
                      text = "这是一个上下文菜单";
                      break;
                    case 2:
                      text = "桌面端使用弹出菜单";
                      break;
                    case 3:
                      text = "移动端使用苹果风格的底部弹出菜单";
                      break;
                    default:
                      text = "";
                  }
                  return Text(text);
                },
              );
            },
            clickableType: ClickableType.elevatedButton,
            child: const Text('菜单'),
          ),
        ].toFlex(direction: Axis.vertical, mainAxisAlignment: MainAxisAlignment.center),
      ),
    );
  }
}
