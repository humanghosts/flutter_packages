import 'package:hg_entity/context/constructor_cache.dart';
import 'package:hg_logger/entity/entities.dart';

/// 主题类型
class ThemeType<T extends ThemeTemplateData> {
  /// 名称
  final String name;

  /// 值
  final String value;

  const ThemeType._({required this.name, required this.value});

  /// 转换为模板数据
  T? toThemeTemplateData(Map<String, Object?>? mapData) {
    T newT = ConstructorCache.get(T);
    newT.fromMap(mapData);
    return newT;
  }

  /// 转换为Map数据
  Map<String, Object?> toMapData(T templateData) {
    return templateData.toMap();
  }

  /// 转换为map数据存储
  String toMap() => value;

  /// 静态转换
  static ThemeType? fromMap(String? value) => map[value];

  static const String _neumorphicValue = "neumorphic";

  /// 新拟态
  static const ThemeType<NeumorphicThemeTemplateData> neumorphic = ThemeType._(name: "新拟态", value: _neumorphicValue);

  /// 列表
  static const List<ThemeType> list = [neumorphic];

  /// 映射
  static const Map<String, ThemeType> map = {_neumorphicValue: neumorphic};
}
