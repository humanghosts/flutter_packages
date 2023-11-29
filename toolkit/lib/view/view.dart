import 'package:flutter/material.dart';
import 'package:ohohoo_toolkit/ohohoo_toolkit.dart';

/// 模型
abstract class ViewModel<T extends ViewManager> {
  /// key
  final String key;

  ViewModel({required this.key});

  final Map<String, Widget> views = {};

  Widget getView({String? key}) {
    final String viewKey = key ?? this.key;
    return instanceUtil.factory(viewKey, () => buildView(viewKey));
  }

  Widget buildView(String key);

  T getManager() {
    return instanceUtil.singleton(() => buildManager());
  }

  T buildManager();
}

/// 控制器
abstract class ViewManager<T> {
  final T model;

  const ViewManager(this.model);
}

abstract class StatelessView<T extends ViewModel<M>, M extends ViewManager<T>> extends StatelessWidget {
  /// 模型
  final T model;

  /// 控制器
  M get manager => model.getManager();

  const StatelessView(this.model, {super.key});
}

abstract class StatefulView<T extends ViewModel<M>, M extends ViewManager<T>> extends StatefulWidget {
  /// 模型
  final T model;

  const StatefulView(this.model, {super.key});

  @override
  StatefulViewState<T, M> createState();
}

abstract class StatefulViewState<T extends ViewModel<M>, M extends ViewManager<T>> extends State<StatefulView<T, M>> {
  T get model => widget.model;

  /// 控制器
  M get manager => model.getManager();
}
