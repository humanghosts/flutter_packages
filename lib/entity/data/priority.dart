import 'package:flutter/material.dart';
import 'package:hg_entity/hg_entity.dart';

import '../entities.dart';

/// 优先级
class Priority extends EventAttribute {
  static const String modelTitle = "优先级";

  late final Attribute<int> weight;

  Priority() {
    name.comment = "请输入优先级名称";
    content.comment = "请输入优先级描述";
    weight = attributes.integer(name: "weight", title: "权重", comment: "判断优先级高低的实际字段，用于事件排序", dvalue: 0);
  }

  static List<Priority> get initData {
    return [
      Priority()
        ..name.value = "高优先级"
        ..content.value = "很重要，需要优先执行"
        ..icon.value = IconValue.fontIcon(iconData: Icons.flag, iconColor: Colors.red)
        ..weight.value = 3,
      Priority()
        ..name.value = "中优先级"
        ..content.value = "一般重要，可以等待执行"
        ..icon.value = IconValue.fontIcon(iconData: Icons.flag, iconColor: Colors.orange)
        ..weight.value = 2,
      Priority()
        ..name.value = "低优先级"
        ..content.value = "不太重要，甚至能不执行"
        ..icon.value = IconValue.fontIcon(iconData: Icons.flag, iconColor: Colors.blue)
        ..weight.value = 1,
    ];
  }
}
