import 'package:hg_entity/hg_entity.dart';

import '../entities.dart';

/// 事件属性
abstract class EventAttribute extends DataModel {
  late final Attribute<String?> name;
  static const String nameKey = "name";

  late final CustomAttribute<IconValue> icon;
  static const String iconKey = "icon";

  late final StringAttribute<String?> content;
  static const String contentKey = "content";

  EventAttribute() {
    name = attributes.stringNullable(name: nameKey, title: "名称");
    icon = attributes.custom<IconValue>(name: iconKey, title: "图标");
    content = attributes.stringNullable(name: contentKey, title: "描述");
  }

  @override
  String toString() {
    return name.value ?? "未命名";
  }
}
