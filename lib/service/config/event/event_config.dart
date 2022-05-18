import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_orm/hg_orm.dart';

/// 时间设置服务
class EventConfigService extends SimpleModelService<EventConfig> {
  EventConfigService._();

  static EventConfigService? _instance;

  static EventConfigService get instance => _instance ??= EventConfigService._();

  static final TagService _tagService = TagService.instance;

  /// 查询不在主页的标签列表
  Future<List<Tag>> findNotHomeList(List<Tag> tagList, {Transaction? tx}) async {
    List<String> homeTagIdList = tagList.map((e) => e.id.value).toList();
    Filter filter = SingleFilter.notInList(field: DataModel.idKey, value: homeTagIdList);
    List<Tag> notInList = await _tagService.dao.find(filter: filter, tx: tx);
    return notInList;
  }
}
