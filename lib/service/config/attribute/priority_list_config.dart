import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/model.dart';

/// 主页标签设置服务
class AttributePriorityListConfigService extends SimpleModelService<AttributePriorityListConfig> {
  AttributePriorityListConfigService._();

  static AttributePriorityListConfigService? _instance;

  static AttributePriorityListConfigService get instance => _instance ??= AttributePriorityListConfigService._();
}
