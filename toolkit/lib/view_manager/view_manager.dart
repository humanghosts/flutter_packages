import 'package:flutter/material.dart';

/// 模型 不可变模型
/// model view viewModel 一一对应
@immutable
abstract class ViewModel {
  /// key
  final String key;

  const ViewModel({required this.key});

  StatelessView toView({Key? key});

  ViewManager? getVM() => ViewManager.getVM(this);
}

/// 控制器
abstract class ViewManager<T extends ViewModel> {
  /// key
  String get key => model.key;

  /// 控制器的外部数据源
  final T model;

  /// VM缓存
  static final Map<String, ViewManager> _vmCache = {};

  ViewManager(this.model) {
    _vmCache['${T}_$key'] = this;
  }

  /// 快速获取VM
  static ViewManager? getVM(ViewModel model) => _vmCache['${model.runtimeType}_${model.key}'];
}

/// 页面组件
abstract class StatelessView<T extends ViewModel, M extends ViewManager<T>> extends StatelessWidget {
  const StatelessView(this.vm, {Key? key}) : super(key: key);

  /// vm
  final M vm;

  T get model => vm.model;
}

abstract class StatefulView<T extends ViewModel, M extends ViewManager<T>> extends StatefulWidget {
  const StatefulView(this.vm, {super.key});

  /// vm
  final M vm;

  @override
  StatefulViewState<T, M> createState();
}

abstract class StatefulViewState<T extends ViewModel, M extends ViewManager<T>> extends State<StatefulView<T, M>> {
  T get model => widget.vm.model;

  M get vm => widget.vm;
}
