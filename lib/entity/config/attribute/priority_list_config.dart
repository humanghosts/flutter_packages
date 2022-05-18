import '../../entities.dart';

/// 优先级列表的设置
class AttributePriorityListConfig extends AttributeListConfig<Priority> {
  @override
  List<String> get sortFieldList => ["name", "weight"];

  static AttributePriorityListConfig get initData {
    return AttributePriorityListConfig();
  }
}
