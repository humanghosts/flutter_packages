import 'package:flutter/material.dart';
import 'package:hgs_starter/starter.dart';

import 'home.dart';

void main() {
  AppHelper().run(const StarterApp(), DefaultAppConfig());
}

class StarterApp extends App {
  const StarterApp({Key? key}) : super(key: key);

  @override
  Widget buildHome(BuildContext context) {
    return DefaultHomeView(key: "default_home_view");
  }
}
