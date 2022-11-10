import 'dart:math';

class PathUtil {
  PathUtil._();

  /// 随机数产生器
  static final Random _random = Random();

  /// 生成path的种子
  static final List<String> _pathSeed = (() {
    List<String> seed = [];
    // 数字0-9
    for (int i = 48; i <= 57; i++) {
      seed.add(String.fromCharCode(i));
    }
    // A-Z
    for (int i = 65; i <= 90; i++) {
      seed.add(String.fromCharCode(i));
    }
    // a-z
    for (int i = 97; i <= 97; i++) {
      seed.add(String.fromCharCode(i));
    }
    return seed;
  })();

  /// 生成Path字符串
  static String genPath({int length = 4}) {
    StringBuffer sb = StringBuffer();
    // 产生指定长度的随机字符串
    for (int i = 0; i < length; i++) {
      int index = _random.nextInt(_pathSeed.length);
      sb.write(_pathSeed[index]);
    }
    return sb.toString();
  }
}
