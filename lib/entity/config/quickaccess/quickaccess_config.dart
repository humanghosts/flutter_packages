import 'package:hg_entity/hg_entity.dart';

import '../../../view/export.dart';
import '../../entities.dart';

class QuickAccessConfig extends SimpleModel {
  late final ListAttribute<PageValue> homePages;

  QuickAccessConfig() {
    homePages = attributes.customList(name: "快速访问功能", comment: "固定到快速访问的功能页面");
  }

  static QuickAccessConfig get initData {
    return QuickAccessConfig()
      ..homePages.value = [
        PageValue(page: HomePages.schedule),
        PageValue(page: HomePages.focus),
      ];
  }
}
