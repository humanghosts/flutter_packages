library state_manager;

import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'dart:collection';

part 'list.dart';

part 'map.dart';

part 'set.dart';

part 'extension.dart';

part 'number.dart';

/// 极简状态管理工具
class Rx<T> {
  /// 实际值
  T _value;

  Rx(T value) : _value = value;

  set value(T value) {
    this._value = value;
    react();
  }

  T get value => this._value;

  /// 所有订阅
  final _subscriptions = <String, ValueChanged<T>>{};

  /// 添加订阅
  void addListener(String key, ValueChanged<T> listener) {
    _subscriptions[key] = listener;
  }

  /// 移除订阅
  void removeListener(String key) {
    _subscriptions.remove(key);
  }

  /// 更新
  void react() {
    for (ValueChanged<T> listener in _subscriptions.values) {
      listener(_value);
    }
  }
}

/// 构建器
extension RxBuilder<T> on Rx<T> {
  /// 构建
  Widget obx(Widget Function(BuildContext _) builder) {
    return _RxWidget(id: ValueKey<String>(const Uuid().v1()), rxList: [this], builder: builder);
  }
}

/// 多构建器
extension ListRxBuilder on List<Rx> {
  Widget obx(Widget Function(BuildContext _) builder) {
    return _RxWidget(id: ValueKey<String>(const Uuid().v1()), rxList: this, builder: builder);
  }
}

/// 动态组件
class _RxWidget extends StatefulWidget {
  final List<Rx> rxList;
  final Widget Function(BuildContext context) builder;
  final ValueKey<String> id;

  const _RxWidget({
    required this.id,
    required this.rxList,
    required this.builder,
  }) : super(key: id);

  @override
  State<_RxWidget> createState() => _RxWidgetState();
}

class _RxWidgetState extends State<_RxWidget> {
  // 刷新组件
  void update() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    for (Rx rx in widget.rxList) {
      rx.addListener(widget.id.value, (value) {
        update();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (Rx rx in widget.rxList) {
      rx.removeListener(widget.id.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
