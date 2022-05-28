import 'package:flutter/material.dart';
import 'package:hg_framework/ability/export.dart';
import 'package:hg_framework/hg_framework.dart';

/// 页面外部参数
@immutable
class PageArgs extends ViewArgs {
  const PageArgs();
}

/// 页面外部数据源
@immutable
class PageDataSource extends ViewDataSource {
  const PageDataSource();
}

/// 只有参数没有数据源的逻辑
abstract class PageLogicOnlyArgs<A extends PageArgs> extends PageLogic<A, PageDataSource> {}

/// 只有数据源没有参数的逻辑
abstract class PageLogicOnlyDataSource<D extends PageDataSource> extends PageLogic<PageArgs, D> {}

/// 只有逻辑
abstract class PageLogicOnly extends PageLogic<PageArgs, PageDataSource> {}

/// 页面控制器
abstract class PageLogic<A extends PageArgs, D extends PageDataSource> extends ViewLogic<A, D> {
  /// 当页面退出时调用
  void onBack() {}
}

abstract class Page<L extends PageLogic> extends View<L> with ObserverWidget {
  /// 构造
  Page({
    required String key,
    required L logic,
    ViewArgs? args,
    ViewDataSource? dataSource,
  }) : super(key: key, logic: logic, args: args, dataSource: dataSource);

  @override
  void observe(ObserverRouting? routing) {
    if (routing?.isBack == true) {
      logic.onBack();
    }
  }
}
