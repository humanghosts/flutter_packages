import 'package:flutter/widgets.dart';

/// 云文件
@immutable
class CloudFile {
  late final String fileName;
  late final DateTime dateTime;
  static const String _pattern = "__";

  CloudFile(this.fileName) {
    dateTime = DateTime.now();
  }

  CloudFile.fromCloud(String cloudFileName, bool isMultiVersion) {
    if (isMultiVersion) {
      List<String> list = cloudFileName.split(_pattern);
      assert(list.length == 2);
      fileName = list[0];
      dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(list[1]));
    } else {
      CloudFile(cloudFileName);
    }
  }

  String getCloudFileName(bool isMultiVersion) => isMultiVersion ? "$fileName$_pattern${dateTime.millisecondsSinceEpoch}" : fileName;

  int compareTo(CloudFile other) {
    return dateTime.compareTo(other.dateTime);
  }
}
