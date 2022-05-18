class StringUtils {
  StringUtils._();
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
