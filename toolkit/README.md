

# IDEA的Live Template
```dart
import 'package:flutter/material.dart';
import 'package:ohohoo_toolkit/view_manager/view_manager.dart';

/// 模型
@immutable
class $name$Model extends ViewModel {
  const $name$Model({required super.key});

  @override
  $name$View toView({Key? key}) {
    return $name$View($name$Manager(this), key: key);
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