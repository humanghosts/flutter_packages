import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/model.dart';

/// 主题配置服务
class ThemeConfigService extends SimpleModelService<ThemeConfig> {
  ThemeConfigService._();

  static ThemeConfigService? _instance;

  static ThemeConfigService get instance => _instance ??= ThemeConfigService._();
}
