import 'dart:async';

import 'package:sembast/sembast.dart';

import '../../api/api.dart' as api;
import 'database.dart';

/// 数据库配置
class SembastConfig extends api.DatabaseConfig {
  SembastConfig({
    required String path,
    bool? isLogicDelete,
    int version = 1,
    FutureOr<dynamic> Function(Database db, int oldIndex, int newIndex)? onVersionChanged,
  }) : super(
          SembastDatabase(
            path: path,
            isLogicDelete: isLogicDelete,
            version: version,
            onVersionChanged: onVersionChanged,
          ),
        );
}
