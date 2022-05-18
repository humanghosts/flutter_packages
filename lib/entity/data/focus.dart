import 'package:hg_entity/hg_entity.dart';

import '../entities.dart';

class Focus extends DataModel {
  late final DataModelAttribute<DeriveEvent?> event;
  static const String eventKey = "event";

  late final Attribute<int> milliseconds;
  static const String millisecondsKey = "milliseconds";

  late final CustomAttribute<FocusModeValue> mode;
  static const String modeKey = "mode";

  late final Attribute<DateTime> start;
  static const startKey = "start";

  late final Attribute<DateTime> end;
  static const endKey = "end";

  Focus() {
    event = attributes.dataModelNullable(name: eventKey, title: "事件");
    milliseconds = attributes.integer(name: millisecondsKey, title: "专注时长", dvalue: 0);
    mode = attributes.custom(name: modeKey, title: "模式");
    start = attributes.datetime(name: startKey, title: "开始时间");
    end = attributes.datetime(name: endKey, title: "结束时间");
  }
}
