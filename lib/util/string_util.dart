/// 字符串工具类
class StringUtils {
  StringUtils._();

  /// 比较大小
  static int compare(String? a, String? b) {
    if (a == null) {
      if (b == null) {
        return 0;
      } else {
        return -1;
      }
    } else {
      if (b == null) {
        return 1;
      } else {
        return a.compareTo(b);
      }
    }
  }
}
