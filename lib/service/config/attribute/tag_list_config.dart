import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/model.dart';

/// 主页标签设置服务
class AttributeTagListConfigService extends SimpleModelService<AttributeTagListConfig> {
  AttributeTagListConfigService._();

  static AttributeTagListConfigService? _instance;

  static AttributeTagListConfigService get instance => _instance ??= AttributeTagListConfigService._();
}
