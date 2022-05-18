import 'package:flutter/material.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';

import '../attribute_detail.dart';
import '../attribute_list.dart';
import '../attribute_settings.dart';
import 'tag_detail.dart';
import 'tag_settings.dart';

/// 标签列表逻辑
class TagListLogic extends AttributeListLogic<Tag> {
  @override
  TagService get service => TagService.instance;
}

/// 标签列表
class TagList extends AttributeList<Tag, TagListLogic> {
  TagList({
    required String key,
    required AttributeListArgs args,
  }) : super(key: key, args: args, newLogic: TagListLogic());

  @override
  int get detailNavigatorId => "tag_detail".hashCode;

  @override
  int get settingsNavigatorId => "tag_settings".hashCode;

  @override
  Widget buildDetailPage(String key, AttributeDetailArgs<Tag> args, AttributeDetailDataSource<Tag> dataSource) {
    return TagDetail(key: key, args: args, dataSource: dataSource);
  }

  @override
  Widget buildSettings(String key, AttributeSettingsArgs args) {
    return TagSettings(key: key, args: args);
  }
}
