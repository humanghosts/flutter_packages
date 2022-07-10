import 'package:flutter/material.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:local_notifier/local_notifier.dart';

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
            LocalNotification notification = LocalNotification(
              identifier: "123",
              title: "local_notifier_example",
              body: "hello flutter!",
            );
            notification.onShow = () {
              print('onShow ${notification.identifier}');
            };
            notification.onClose = (closeReason) {
              // Only supported on windows, other platforms closeReason is always unknown.
              switch (closeReason) {
                case LocalNotificationCloseReason.userCanceled:
                  // do something
                  break;
                case LocalNotificationCloseReason.timedOut:
                  // do something
                  break;
                default:
              }
              print('onClose ${notification.identifier} - $closeReason');
            };
            notification.onClick = () {
              print('onClick ${notification.identifier}');
            };
            notification.onClickAction = (actionIndex) {
              print('onClickAction ${notification.identifier} - $actionIndex');
            };

            notification.show();
          },
          child: const Text('\u{1f600}'),
        ),
      ),
    );
  }
}
