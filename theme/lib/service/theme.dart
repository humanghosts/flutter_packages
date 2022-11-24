import 'package:hg_framework/hg_framework.dart';

import '../entity/export.dart';

class ThemeTemplateService extends DataModelService<ThemeTemplate> {
  ThemeTemplateService._();

  static ThemeTemplateService? _instance;

  factory ThemeTemplateService() => _instance ??= ThemeTemplateService._();

  Future<void> removeById(String id, {Transaction? tx}) async {
    await dao.removeWhere(SingleFilter.equals(field: DataModel.idKey, value: id), tx: tx);
  }

  Future<void> removeByIdList(List<String> idList, {Transaction? tx}) async {
    await dao.removeWhere(SingleFilter.inList(field: DataModel.idKey, value: idList), tx: tx);
  }
}

class ThemeConfigService extends SimpleModelService<ThemeConfig> {
  ThemeConfigService._();

  static ThemeConfigService? _instance;

  factory ThemeConfigService() => _instance ??= ThemeConfigService._();
}
