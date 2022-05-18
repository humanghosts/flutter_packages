import 'dart:convert';

import 'package:hg_logger/entity/data/focus.dart';
import 'package:hg_logger/service/model.dart';
import 'package:hg_orm/hg_orm.dart';

class FocusService extends DataModelService<Focus> {
  FocusService._();

  static FocusService? _instance;

  static FocusService get instance => _instance ??= FocusService._();

  static const focusTempKey = "temp_focus";
  static const countDownKey = "temp_count_down";

  @override
  Future<List<Focus>> find({Transaction? tx, bool isLogicDelete = true}) async {
    return await dao.find(tx: tx, isLogicDelete: isLogicDelete);
  }

  /// 专注缓存清空
  Future<void> focusTempClear() async {
    await DatabaseHelper.kv.removeSave(focusTempKey);
  }

  /// 倒计时缓存清空
  Future<void> countDownTempClear() async {
    await DatabaseHelper.kv.removeSave(countDownKey);
  }

  /// 专注缓存保存
  Future<void> focusTempSave(Focus focus) async {
    Map<String, Object?>? value = await dao.convertors.modelConvertor.getValue(focus, tx: null, isLogicDelete: dao.isLogicDelete, isCache: dao.isCache);
    await DatabaseHelper.kv.putSave(focusTempKey, json.encode(value));
  }

  /// 倒计时缓存保存
  Future<void> countDownTempSave(int milliseconds) async {
    await DatabaseHelper.kv.putSave(countDownKey, milliseconds);
  }

  /// 专注缓存读取缓存
  Future<Focus?> focusTempGet() async {
    String? valueStr = DatabaseHelper.kv.get(focusTempKey);
    if (valueStr == null || valueStr.isEmpty) return null;
    Object value = json.decode(valueStr);
    return (await dao.convertors.modelConvertor.getModelByModel(Focus(), value, tx: null, isLogicDelete: dao.isLogicDelete, isCache: dao.isCache)) as Focus;
  }

  /// 倒计时缓存读取
  int? countDownTempGet() {
    return DatabaseHelper.kv.get(countDownKey);
  }
}
