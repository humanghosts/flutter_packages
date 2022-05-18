import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/entities.dart';

/// 主题配置
class ThemeConfig extends SimpleModel {
  /// 已有模板
  late final ListAttribute<ThemeTemplate> templateList;

  /// 浅色模式模板
  late final Attribute<ThemeTemplate> light;

  /// 深色模式模板
  late final Attribute<ThemeTemplate> dark;

  ThemeConfig() {
    templateList = attributes.dataModelList(name: "template_list", title: "模板列表");
    light = attributes.dataModel(name: "light", title: "浅色模式");
    dark = attributes.dataModel(name: "dark", title: "深色模式");
  }

  /// 预制数据
  static ThemeConfig get initData {
    List<ThemeTemplate> initTemplate = ThemeTemplate.initData;
    return ThemeConfig()
      ..templateList.value = initTemplate
      ..light.value = initTemplate[0]
      ..dark.value = initTemplate[1];
  }
}

/// 主题模板
class ThemeTemplate extends DataModel {
  /// 模板名称
  late final Attribute<String?> name;

  /// 模版数据
  late final Attribute<ThemeDataValue> data;

  ThemeTemplate({String? name}) {
    this.name = attributes.stringNullable(name: "name", title: "名称", value: name);
    data = attributes.custom(name: "data", title: "数据");
  }

  /// 预制数据
  static List<ThemeTemplate> get initData {
    ThemeTemplate defaultLight = ThemeTemplate(name: "默认浅色主题")
      ..id.value = "neumorphic_light_default"
      ..data.value = ThemeDataValue(
        themeType: ThemeType.neumorphic,
        themeData: NeumorphicThemeTemplateData(
          shadowDarkColor: Colors.black.value,
          shadowDarkColorEmboss: Colors.black.value,
          defaultTextColor: Colors.black.value,
          disabledColor: Colors.grey.value,
          defaultIconColor: Colors.black.value,
          borderWidth: 0,
          depth: 4,
        ),
      );
    ThemeTemplate defaultDark = ThemeTemplate(name: "默认深色主题")
      ..id.value = "neumorphic_dark_default"
      ..data.value = ThemeDataValue(
        themeType: ThemeType.neumorphic,
        themeData: NeumorphicThemeTemplateData(
          baseColor: NeumorphicColors.darkBackground.value,
          shadowLightColor: Colors.black45.value,
          shadowDarkColor: Colors.black87.value,
          shadowDarkColorEmboss: Colors.black45.value,
          shadowLightColorEmboss: Colors.black87.value,
          borderColor: Colors.black.value,
          defaultIconColor: Colors.white.value,
          defaultTextColor: Colors.white.value,
          disabledColor: Colors.grey.value,
        ),
      );
    ThemeTemplate white = ThemeTemplate(name: "黑白扁平主题")
      ..id.value = "white_black"
      ..data.value = ThemeDataValue(
        themeType: ThemeType.neumorphic,
        themeData: NeumorphicThemeTemplateData(
          baseColor: Colors.white.value,
          depth: 0,
          shadowLightColor: Colors.white.value,
          shadowDarkColor: Colors.black.value,
          shadowDarkColorEmboss: Colors.black.value,
          shadowLightColorEmboss: Colors.white.value,
          borderColor: Colors.black.value,
          defaultIconColor: Colors.black.value,
          defaultTextColor: Colors.black.value,
          disabledColor: Colors.grey.value,
          intensity: 0.5,
        ),
      );
    return [defaultLight, defaultDark, white];
  }
}

/// 主题模板数据
abstract class ThemeTemplateData extends SimpleModel {
  /// 从map中恢复数据
  void fromMap(Map<String, Object?>? map);

  /// 生成Material主题数据
  ThemeData toThemeData();

  /// 转换为map数据
  Map<String, Object?> toMap();
}
