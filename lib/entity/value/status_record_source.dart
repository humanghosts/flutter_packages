import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/enum/status_record_source_type.dart';

class StatusRecordSource extends CustomValue {
  /// 动作来源类型
  late StatusRecordSourceType? sourceType;

  StatusRecordSource({this.sourceType});

  /// 是否为空 缺一不可
  @override
  bool get isNull => false;

  /// 转换为map
  @override
  Future<String?> toMap({Map<String, Object?>? args}) async => sourceType?.value;

  /// 从map转换
  @override
  Future<StatusRecordSource> fromMap(Object? value, {Map<String, Object?>? args}) async {
    sourceType = StatusRecordSourceType.fromMap(value as String?);
    return this;
  }

  /// 拷贝
  @override
  StatusRecordSource clone() {
    StatusRecordSource source = StatusRecordSource();
    source.sourceType = sourceType;
    return source;
  }

  /// 合并
  @override
  StatusRecordSource merge(Object value) {
    if (value is! StatusRecordSource) return this;
    sourceType = value.sourceType;
    return this;
  }
}
