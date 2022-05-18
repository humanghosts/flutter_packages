import 'package:flutter/material.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';

import '../attribute_detail.dart';
import '../attribute_list.dart';
import '../attribute_settings.dart';
import 'priority_detail.dart';
import 'priority_settings.dart';

class PriorityListLogic extends AttributeListLogic<Priority> {
  @override
  PriorityService get service => PriorityService.instance;
}

class PriorityList extends AttributeList<Priority, PriorityListLogic> {
  PriorityList({required String key, required AttributeListArgs args})
      : super(
          key: key,
          args: args,
          newLogic: PriorityListLogic(),
        );

  @override
  int get detailNavigatorId => "priority_detail".hashCode;

  @override
  int get settingsNavigatorId => "priority_settings".hashCode;

  @override
  Widget buildDetailPage(String key, AttributeDetailArgs<Priority> args, AttributeDetailDataSource<Priority> dataSource) {
    return PriorityDetail(key: key, args: args, dataSource: dataSource);
  }

  @override
  Widget buildSettings(String key, AttributeSettingsArgs args) {
    return PrioritySettings(key: key, args: args);
  }
}
