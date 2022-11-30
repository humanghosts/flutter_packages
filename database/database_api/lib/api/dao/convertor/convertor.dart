/// 数据转换器
/// [F]是来源类型
/// [T]是目标类型
abstract class Convertor<F, T> {
  /// 转换为目标类型
  Future<T?> to(F? value);

  /// 转换为来源类型
  Future<F?> from(T? value);
}
