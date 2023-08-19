part of 'common.dart';

/// 国际化字符串
class IntlString {
  final String value;

  IntlString._(this.value);

  factory IntlString(String value) => instanceUtil.factory(value, () => IntlString._(value));

  /// 获取字符串实际值
  /// [locale]是当前语言，可以通过这个枚举返回对应语音的字符串
  String intl([List<Object>? args]) {
    return Intl.message(value, name: value, args: args);
  }
}

/// 字符串国际化扩展
extension IntlEx on String {
  /// 构建国际化字符串
  IntlString get intl => IntlString(this);
}
