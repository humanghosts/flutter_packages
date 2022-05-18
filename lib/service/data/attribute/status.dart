import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_orm/hg_orm.dart';

class StatusService extends EventAttributeService<Status> {
  StatusService._();

  static StatusService? _instance;

  static StatusService get instance => _instance ??= StatusService._();

  static final AttributeStatusListConfigService _configService = AttributeStatusListConfigService.instance;

  @override
  Future<AttributeListConfig<Status>> getConfig({Transaction? tx}) async {
    return await _configService.find(tx: tx);
  }

  /// 查询状态，包括删除的
  Future<List<Status>> findByIdListWithRemoved(List<String> idList, {Transaction? tx}) async {
    return await dao.findByIDList(idList, tx: tx, isLogicDelete: false);
  }
}
