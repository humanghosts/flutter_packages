import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_orm/hg_orm.dart';

/// 存储事件主页的标签及其顺序
abstract class AttributeListConfig<T extends EventAttribute> extends SimpleModel {
  late final CustomAttribute<SortValue> sort;

  Type get eventAttributeType => T;

  AttributeListConfig() {
    sort = attributes.custom(
      name: "sort",
      title: "列表排序设置",
      dvalue: SortValue()..sort = Sort(field: "name"),
      comment: "用于事件属性页面，属性列表排序",
    );
  }

  List<String> get sortFieldList => ["name"];
}
