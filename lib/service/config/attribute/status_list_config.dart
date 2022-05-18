import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/model.dart';

/// 主页标签设置服务
class AttributeStatusListConfigService extends SimpleModelService<AttributeStatusListConfig> {
  AttributeStatusListConfigService._();

  static AttributeStatusListConfigService? _instance;

  static AttributeStatusListConfigService get instance => _instance ??= AttributeStatusListConfigService._();
}
