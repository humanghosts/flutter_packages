import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_orm/hg_orm.dart';

class PriorityService extends EventAttributeService<Priority> {
  PriorityService._();

  static PriorityService? _instance;

  static PriorityService get instance => _instance ??= PriorityService._();

  static final AttributePriorityListConfigService _configService = AttributePriorityListConfigService.instance;

  @override
  Future<AttributeListConfig<Priority>> getConfig({Transaction? tx}) async {
    return await _configService.find(tx: tx);
  }
}
