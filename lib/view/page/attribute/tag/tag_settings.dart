import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';

import '../attribute_settings.dart';

/// 逻辑
class TagSettingsLogic extends AttributeSettingsLogic<AttributeTagListConfig> {
  @override
  AttributeTagListConfigService get service => AttributeTagListConfigService.instance;
}

/// 页面
class TagSettings extends AttributeSettings<AttributeTagListConfig, TagSettingsLogic> {
  TagSettings({
    required String key,
    required AttributeSettingsArgs args,
  }) : super(key: key, args: args, newLogic: TagSettingsLogic());

  @override
  List<Widget> get content => [];

  @override
  String get title => Tag.modelTitle;
}
