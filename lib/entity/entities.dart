import 'package:hg_entity/hg_entity.dart';
import 'package:hg_framework/entity/theme_config.dart';
import 'package:hg_framework/hg_framework.dart';
import 'package:hg_orm/hg_orm.dart';

import 'theme_custom_value.dart';
import 'theme_template.dart';

/// 注册entity
Map<Type, EntityConstructor> getEntitiesMap() {
  return {
    // custom value
    ThemeModeValue: ([args]) => ThemeModeValue(),
    FlexSchemeValue: ([args]) => FlexSchemeValue(),
    FlexSurfaceModeValue: ([args]) => FlexSurfaceModeValue(),
    SchemeColorValue: ([args]) => SchemeColorValue(),
    FlexAppBarStyleValue: ([args]) => FlexAppBarStyleValue(),
    FlexTabBarStyleValue: ([args]) => FlexTabBarStyleValue(),
    FlexInputBorderTypeValue: ([args]) => FlexInputBorderTypeValue(),
    FlexSystemNavBarStyleValue: ([args]) => FlexSystemNavBarStyleValue(),
    NavigationDestinationLabelBehaviorValue: ([args]) => NavigationDestinationLabelBehaviorValue(),
    NavigationRailLabelTypeValue: ([args]) => NavigationRailLabelTypeValue(),
    ColorValue: ([args]) => ColorValue(),
    // data model
    ThemeTemplate: ([args]) => ThemeTemplate(),
    // simple model
    ThemeConfig: ([args]) => ThemeConfig(),
  };
}

/// 注册dao
Map<Type, Dao> getDaoMap() {
  return {
    ThemeTemplate: SembastDataDao<ThemeTemplate>(),
    ThemeConfig: SembastSimpleDao<ThemeConfig>(),
  };
}

/// 数据模型的初始化数据
Map<Type, List<DataModel> Function()> getDataModelInitData() {
  return {
    ThemeTemplate: () => ThemeTemplate.initData,
  };
}

/// 简单模型的初始化数据
Map<Type, SimpleModel Function()> getSimpleModelInitData() {
  return {
    ThemeConfig: () => ThemeConfig.initData,
  };
}
