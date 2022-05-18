import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/model.dart';

class QuickAccessConfigService extends SimpleModelService<QuickAccessConfig> {
  QuickAccessConfigService._();

  static QuickAccessConfigService? _instance;

  static QuickAccessConfigService get instance => _instance ??= QuickAccessConfigService._();
}
