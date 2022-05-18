import 'package:flutter/material.dart';
import 'package:hg_logger/entity/entities.dart';
import 'package:hg_logger/service/services.dart';

import '../attribute_detail.dart';
import '../attribute_list.dart';
import '../attribute_settings.dart';
import 'status_detail.dart';
import 'status_settings.dart';

class StatusListLogic extends AttributeListLogic<Status> {
  @override
  StatusService get service => StatusService.instance;
}

class StatusList extends AttributeList<Status, StatusListLogic> {
  StatusList({required String key, required AttributeListArgs args})
      : super(
          key: key,
          args: args,
          newLogic: StatusListLogic(),
        );

  @override
  int get detailNavigatorId => "status_detail".hashCode;

  @override
  int get settingsNavigatorId => "status_settings".hashCode;

  @override
  Widget buildDetailPage(String key, AttributeDetailArgs<Status> args, AttributeDetailDataSource<Status> dataSource) {
    return StatusDetail(key: key, args: args, dataSource: dataSource);
  }

  @override
  Widget buildSettings(String key, AttributeSettingsArgs args) {
    return StatusSettings(key: key, args: args);
  }
}
