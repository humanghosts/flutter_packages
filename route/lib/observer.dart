import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';
import 'package:get/get_navigation/src/router_report.dart';

/// 需要监听路由的组件
/// 存在的主要原因是要监听手势返回
abstract class ObserverWidget {
  /// 路由变化回调
  void observe(ObserverRouting? routing);
}

/// 路由监听器
class Observer extends GetObserver {
  final Function(ObserverRouting?)? observerRouting;
  final ObserverRouting? observerRouteSend;

  Observer([this.observerRouting, this.observerRouteSend])
      : super(
          (routing) {
            observerRouting?.call(routing as ObserverRouting);
          },
          observerRouteSend,
        );

  @override
  void didPop(Route route, Route? previousRoute) {
    final currentRoute = _RouteData.ofRoute(route);
    final newRoute = _RouteData.ofRoute(previousRoute);

    if (currentRoute.isBottomSheet || currentRoute.isDialog) {
      log("CLOSE ${currentRoute.name}");
    } else if (currentRoute.isGetPageRoute) {
      log("CLOSE TO ROUTE ${currentRoute.name}");
    }
    if (previousRoute != null) {
      RouterReportManager.reportCurrentRoute(previousRoute);
    }
    observerRouteSend?.update((value) {
      value.current = _extractRouteName(route) ?? '';
      value.currentRoute = route;
      value.previousRoute = route;
      value.args = route.settings.arguments;
      value.route = route;
      value.isBack = true;
      value.removed = '';
      value.previous = newRoute.name ?? '';
      value.isBottomSheet = newRoute.isBottomSheet;
      value.isDialog = newRoute.isDialog;
    });
    observerRouting?.call(observerRouteSend);
  }
}

/// 提取路由名称
String? _extractRouteName(Route? route) {
  if (route?.settings.name != null) {
    return route!.settings.name;
  }

  if (route is GetPageRoute) {
    return route.routeName;
  }

  if (route is GetDialogRoute) {
    return 'DIALOG ${route.hashCode}';
  }

  if (route is GetModalBottomSheetRoute) {
    return 'BOTTOMSHEET ${route.hashCode}';
  }

  return null;
}

class _RouteData {
  final bool isGetPageRoute;
  final bool isBottomSheet;
  final bool isDialog;
  final String? name;

  _RouteData({
    required this.name,
    required this.isGetPageRoute,
    required this.isBottomSheet,
    required this.isDialog,
  });

  factory _RouteData.ofRoute(Route? route) {
    return _RouteData(
      name: _extractRouteName(route),
      isGetPageRoute: route is GetPageRoute,
      isDialog: route is GetDialogRoute,
      isBottomSheet: route is GetModalBottomSheetRoute,
    );
  }
}

class ObserverRouting extends Routing {
  Route? currentRoute;
  Route? previousRoute;

  ObserverRouting({
    String current = '',
    String previous = '',
    dynamic args,
    String removed = '',
    Route<dynamic>? route,
    this.currentRoute,
    this.previousRoute,
    bool? isBack,
    bool? isBottomSheet,
    bool? isDialog,
  }) : super(
          current: current,
          previous: previous,
          args: args,
          removed: removed,
          route: route,
          isBack: isBack,
          isBottomSheet: isBottomSheet,
          isDialog: isDialog,
        );

  @override
  void update(void Function(ObserverRouting value) fn) {
    fn(this);
  }
}
