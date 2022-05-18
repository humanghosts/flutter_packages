import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';

import '../attribute_settings.dart';

/// 逻辑 选择继承而不是直接传服务的原因是更方便自定义扩展
class PrioritySettingsLogic extends AttributeSettingsLogic<AttributePriorityListConfig> {
  @override
  AttributePriorityListConfigService get service => AttributePriorityListConfigService.instance;
}

/// 页面
class PrioritySettings extends AttributeSettings<AttributePriorityListConfig, PrioritySettingsLogic> {
  PrioritySettings({required String key, required AttributeSettingsArgs args})
      : super(
          key: key,
          args: args,
          newLogic: PrioritySettingsLogic(),
        );

  @override
  List<Widget> get content => [];

  @override
  String get title => Priority.modelTitle;
}
