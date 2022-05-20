import 'package:hg_framework/entity/export.dart';
import 'package:hg_framework/service/model_service.dart';

class ThemeTemplateService extends DataModelService<ThemeTemplate> {
  ThemeTemplateService._();

  static ThemeTemplateService? _instance;

  static ThemeTemplateService get instance => _instance ??= ThemeTemplateService._();
}

class ThemeConfigService extends SimpleModelService<ThemeConfig> {
  ThemeConfigService._();

  static ThemeConfigService? _instance;

  static ThemeConfigService get instance => _instance ??= ThemeConfigService._();
}
