import 'package:hgs_database_api/database_api.dart';

/// 值转换器
class ValueConvertors {
  late final ModelConvertors modelConvertors;
  late final AttributeConvertors attributeConvertors;

  ValueConvertors._() {
    modelConvertors = ModelConvertors.instance;
    attributeConvertors = AttributeConvertors.instance;
    attributeConvertors.modelConvertors = modelConvertors;
    modelConvertors.attributeConvertors = attributeConvertors;
  }

  static ValueConvertors? _instance;

  static ValueConvertors get instance => _instance ??= ValueConvertors._();
}

/// 转换器
abstract class Convertors {
  final ValueConvertors _valueConvertors = ValueConvertors.instance;

  /// 模型转换器
  ModelConvertors get modelConvertor => _valueConvertors.modelConvertors;

  /// 属性转换器
  AttributeConvertors get attributeConvertor => _valueConvertors.attributeConvertors;

  /// 排序转换器
  SortConvertor get sortConvertor;

  /// 过滤器转换器
  FilterConvertor get filterConvertor;
}
