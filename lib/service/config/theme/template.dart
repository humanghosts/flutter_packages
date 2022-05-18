import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/model.dart';

/// 新拟态模板服务
class ThemeTemplateService extends DataModelService<ThemeTemplate> {
  ThemeTemplateService._();

  static ThemeTemplateService? _instance;

  static ThemeTemplateService get instance => _instance ??= ThemeTemplateService._();
}
