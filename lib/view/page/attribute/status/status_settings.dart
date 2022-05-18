import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';

import '../attribute_settings.dart';

/// 逻辑
class StatusSettingsLogic extends AttributeSettingsLogic<AttributeStatusListConfig> {
  @override
  AttributeStatusListConfigService get service => AttributeStatusListConfigService.instance;
}

/// 页面
class StatusSettings extends AttributeSettings<AttributeStatusListConfig, StatusSettingsLogic> {
  StatusSettings({required String key, required AttributeSettingsArgs args})
      : super(
          key: key,
          args: args,
          newLogic: StatusSettingsLogic(),
        );

  @override
  List<Widget> get content => [];

  @override
  String get title => Status.modelTitle;
}
