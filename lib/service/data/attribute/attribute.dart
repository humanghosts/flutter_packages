import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';
import 'package:hg_orm/hg_orm.dart';
import 'package:lpinyin/lpinyin.dart';

abstract class EventAttributeService<M extends EventAttribute> extends DataModelService<M> {
  @override
  Future<List<M>> find({Transaction? tx}) async {
    List<M> data = [];
    data = await dao.find(tx: tx);
    return data;
  }

  Future<List<M>> findByOrder({Transaction? tx}) async {
    List<M> data = [];
    data = await dao.find(tx: tx);
    AttributeListConfig<M> config = await getConfig(tx: tx);
    Sort? sort = config.sort.value.sort;
    if (null != sort) {
      data.sort((a, b) {
        String field = sort.field;
        Attribute aA = a.attributes.get(field)!;
        Attribute bA = b.attributes.get(field)!;
        String aAStr = aA.value == null ? "" : aA.value.toString();
        String bAStr = bA.value == null ? "" : bA.value.toString();
        // 汉字转拼音
        String tAAStr = PinyinHelper.getShortPinyin(aAStr);
        String tBAStr = PinyinHelper.getShortPinyin(bAStr);
        int res = tAAStr.compareTo(tBAStr);
        return sort.op == SortOp.desc ? -res : res;
      });
    }
    return data;
  }

  Future<AttributeListConfig<M>> getConfig({Transaction? tx});

  Future<List<M>> findByIdList(List<String> idList) async {
    return await dao.findByIDList(idList);
  }

  Future<Map<String, M>> findByIdListAsMap(List<String> idList) async {
    List<M> list = await dao.findByIDList(idList);
    Map<String, M> map = {};
    for (M tag in list) {
      map[tag.id.value] = tag;
    }
    return map;
  }
}
