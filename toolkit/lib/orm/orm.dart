import 'dart:convert';

import 'package:ohohoo_toolkit/model/model.dart';
import 'package:ohohoo_toolkit/registry/registry.dart';
import 'package:ohohoo_toolkit/utils/utils.dart';
import 'package:sqlite3/common.dart';
import 'sqlite/sqlite.dart' if (dart.library.html) 'sqlite/web.dart' if (dart.library.io) 'sqlite/native.dart' as sqlite;

part 'scheme/condition.dart';

part 'scheme/query.dart';

part 'scheme/update.dart';

part 'scheme/extension.dart';

part 'scheme/delete.dart';

part 'scheme/insert.dart';

part 'scheme/create.dart';

part 'scheme/scheme.dart';

part 'database_util.dart';

part 'repository.dart';

part 'transaction.dart';

DbUtil dbUtil = DbUtil();
