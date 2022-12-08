/// 自定义attribute的value
abstract class CustomValue {
  /// 是否为空
  bool get isNull;

  /// 拷贝
  CustomValue clone();

  /// 合并
  CustomValue merge(CustomValue value);

  /// 转换为Map
  Future<Object?> toMap({Map<String, Object?>? args});

  /// 从Map转换
  Future<CustomValue> fromMap(Object? value, {Map<String, Object?>? args});
}
