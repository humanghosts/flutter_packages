import 'package:hg_entity/hg_entity.dart';
import 'package:hg_logger/entity/entities.dart';

/// 主题类型
class ThemeDataValue extends CustomValue {
  /// 主题类型
  ThemeType? themeType;

  /// 主题数据
  ThemeTemplateData? themeData;

  ThemeDataValue({this.themeType, this.themeData});

  @override
  CustomValue clone() {
    return ThemeDataValue(themeType: themeType, themeData: themeData);
  }

  @override
  bool get isNull => themeType == null || themeData == null;

  @override
  CustomValue merge(CustomValue value) {
    if (value is! ThemeDataValue) return this;
    themeType = value.themeType;
    return this;
  }

  @override
  Future<Map<String, Object?>?> toMap({Map<String, Object?>? args}) async {
    if (isNull) return null;
    return {
      "type": themeType!.toMap(),
      "data": themeData!.toMap(),
    };
  }

  @override
  Future<CustomValue> fromMap(Object? value, {Map<String, Object?>? args}) async {
    if (value is! Map) return this;
    themeType = ThemeType.fromMap(value["type"]);
    themeData = themeType!.toThemeTemplateData(value["data"]);
    return this;
  }
}
