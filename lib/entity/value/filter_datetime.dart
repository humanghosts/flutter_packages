import 'package:flutter/cupertino.dart';
import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/enum/filter_datetime_type.dart';
import 'package:hg_logger/util/datetime_util.dart';
import 'package:hg_orm/dao/api/export.dart';

@immutable
class FilterDateTimeReturn {
  final DateTime start;
  final DateTime? end;
  final SingleFilterOp op;

  const FilterDateTimeReturn(this.op, this.start, this.end);
}

/// 用于过滤条件的时间模型
class FilterDateTime extends CustomValue {
  /// 日期时间类型
  FilterDateTimeTypeEnum? type;
  static const String _typeKey = "type";

  /// 时间
  DateTime? time;
  static const String _timeKey = "time";

  /// 自定义日期
  DateTime? customDate;
  static const String _customDateKey = "custom_data";

  FilterDateTime({this.type, this.time, this.customDate});

  /// 是否为空 只判断类型和自定义日期
  @override
  bool get isNull {
    if (type == null) return true;
    if (type == FilterDateTimeTypeEnum.custom) {
      return customDate == null;
    }
    return false;
  }

  /// 转换为正常的时间
  /// [op]是当前操作服
  /// [isFirst]是是否是操作符的第一个值
  FilterDateTimeReturn? toDateTime(SingleFilterOp op, bool isFirst, [DateTime? now]) {
    if (isNull) return null;
    FilterDateTimeTypeReturn typeValue = type!.toDateTime(customDate, time, now);
    // 有时间 按照等于匹配，没有时间按照区间匹配
    if (op == SingleFilterOp.equals) {
      return FilterDateTimeReturn(typeValue.end == null ? SingleFilterOp.equals : SingleFilterOp.between, typeValue.start, typeValue.end);
    }
    // 开始和结束间隔24小时 如1-13 00:00到1-14 00：00 开始属于当天，结束不属于
    // 小于最小值
    if (op == SingleFilterOp.lessThan) return FilterDateTimeReturn(op, typeValue.start, null);
    // 小于最大值
    if (op == SingleFilterOp.lessThanOrEquals) return FilterDateTimeReturn(SingleFilterOp.lessThan, typeValue.end ?? typeValue.start, null);
    // 大于最大值
    if (op == SingleFilterOp.greaterThan) return FilterDateTimeReturn(op, typeValue.end ?? typeValue.start, null);
    // 大于等于最小值
    if (op == SingleFilterOp.greaterThanOrEquals) return FilterDateTimeReturn(op, typeValue.start, null);
    // 大于等于最小值，小于最大值
    if (op == SingleFilterOp.between) {
      if (isFirst) {
        return FilterDateTimeReturn(SingleFilterOp.between, typeValue.start, null);
      } else {
        return FilterDateTimeReturn(SingleFilterOp.between, typeValue.end ?? typeValue.start, null);
      }
    }
    return FilterDateTimeReturn(op, typeValue.start, typeValue.end);
  }

  /// 复制
  @override
  FilterDateTime clone() {
    return FilterDateTime(
      type: type,
      time: time,
      customDate: customDate,
    );
  }

  /// 合并
  @override
  FilterDateTime merge(Object value) {
    if (value is! FilterDateTime) return this;
    type = value.type;
    time = value.time;
    customDate = value.customDate;
    return this;
  }

  /// 转换为map
  @override
  Future<Map<String, Object?>?> toMap({Map<String, Object?>? args}) async {
    if (isNull) return null;
    Map<String, Object?> map = {};
    map[_typeKey] = type?.toMap();
    map[_timeKey] = time?.millisecondsSinceEpoch;
    map[_customDateKey] = customDate?.millisecondsSinceEpoch;
    return map;
  }

  /// 从map转换
  @override
  Future<FilterDateTime> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! Map) return this;
    type = FilterDateTimeTypeEnum.fromMap(value[_typeKey]);
    if (null != value[_timeKey]) {
      time = DateTime.fromMillisecondsSinceEpoch(value[_timeKey]);
    }
    if (null != value[_customDateKey]) {
      customDate = DateTime.fromMillisecondsSinceEpoch(value[_customDateKey]);
    }
    return this;
  }

  /// 转换为字符串
  @override
  String toString() {
    String str = "";
    if (type == null) {
      return str;
    }
    if (type == FilterDateTimeTypeEnum.custom) {
      str += DateTimeUtil.dateFormat(customDate);
    } else {
      str += type!.name;
    }
    str += " ";
    if (null != time) {
      str += DateTimeUtil.timeFormat(time);
    }
    return str;
  }
}
