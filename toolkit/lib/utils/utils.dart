library util;

import 'dart:async';
import 'dart:math';

import 'package:logger/logger.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:user_agent_analyzer/user_agent_analyzer.dart';

export 'package:logger/logger.dart';

part 'package_util.dart';

part 'device_util.dart';

part 'instance_util.dart';

part 'log_util.dart';

part 'typedef.dart';

LogUtil logUtil = LogUtil();
InstanceUtil instanceUtil = InstanceUtil();
DeviceUtil deviceUtil = DeviceUtil();
PackageUtil packageUtil = PackageUtil();
