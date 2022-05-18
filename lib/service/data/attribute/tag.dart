import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_orm/dao/api/export.dart';

class TagService extends EventAttributeService<Tag> {
  TagService._();

  static TagService? _instance;

  static TagService get instance => _instance ??= TagService._();

  static final AttributeTagListConfigService _configService = AttributeTagListConfigService.instance;

  @override
  Future<AttributeListConfig<Tag>> getConfig({Transaction? tx}) async {
    return await _configService.find(tx: tx);
  }
}
