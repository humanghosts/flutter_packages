import 'package:hg_framework/hg_framework.dart';

/// 主题配置
class ThemeConfig extends SimpleModel {
  /// 已有模板
  late final ListAttribute<ThemeTemplate> templateList;

  /// 使用中模板
  late final Attribute<ThemeTemplate> templateInUse;

  ThemeConfig() {
    templateList = attributes.dataModelList(name: "template_list", title: "模板列表");
    templateInUse = attributes.dataModel(name: "template_in_use", title: "正在使用的模板");
  }

  /// 预制数据
  static ThemeConfig get initData {
    List<ThemeTemplate> initTemplate = ThemeTemplate.initData;
    return ThemeConfig()
      ..templateList.value = initTemplate
      ..templateInUse.value = initTemplate.first;
  }
}
