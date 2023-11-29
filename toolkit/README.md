# IDEA的Live Template

```dart
import 'package:flutter/material.dart';
import 'package:ohohoo_toolkit/ohohoo_toolkit.dart';

/// 模型
@immutable
class $name$Model extends ViewModel<$name$Manager> {
  $name$Model({required super.key});

  @override
  $name$View buildView(String key) {
    return $name$View(this, key: ValueKey(key));
  }

  @override
  $name$Manager buildManager() {
    return $name$Manager(this);
  }
}

/// 控制器
class $name$Manager extends ViewManager<$name$Model> {
  $name$Manager(super.model);
}

/// 视图
class $name$View extends StatelessView<$name$Model, $name$Manager> {
  const $name$View(super.vm, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

```