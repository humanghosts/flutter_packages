part of 'utils.dart';

/// 日志助手实现
class LogUtil {
  LogUtil._();

  factory LogUtil() => instanceUtil.singleton(LogUtil._);

  final _Filter _filter = _Filter();
  final _Printer _printer = _Printer();
  late final Logger _logger = Logger(filter: _filter, printer: _printer);

  /// 设置可以被输出的日志级别
  /// 设置为空就是不输出日志
  Future<void> setOutputLevel(List<Level>? levels) async {
    // TODO 持久化
    _filter.setLevel(levels);
  }

  void verbose(dynamic message, [dynamic error, StackTrace? stackTrace]) => log(Level.verbose, message, error, stackTrace);

  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) => log(Level.debug, message, error, stackTrace);

  void info(dynamic message, [dynamic error, StackTrace? stackTrace]) => log(Level.info, message, error, stackTrace);

  void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) => log(Level.warning, message, error, stackTrace);

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) => log(Level.error, message, error, stackTrace);

  void terrible(dynamic message, [dynamic error, StackTrace? stackTrace]) => log(Level.wtf, message, error, stackTrace);

  void log(Level level, dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(level, message, error, stackTrace);
  }
}

/// 日志过滤器
class _Filter extends LogFilter {
  _Filter._();

  factory _Filter() => instanceUtil.singleton(() => _Filter._());

  /// 输出等级
  final Set<Level> levels = {};

  @override
  bool shouldLog(LogEvent event) {
    return levels.contains(event.level);
  }

  /// 设置输出等级
  void setLevel(List<Level>? levels) async {
    this.levels.clear();
    if (null != levels) this.levels.addAll(levels);
  }
}

class _Printer extends LogPrinter {
  static final levelColors = {
    Level.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
    Level.debug: AnsiColor.none(),
    Level.info: AnsiColor.fg(12),
    Level.warning: AnsiColor.fg(208),
    Level.error: AnsiColor.fg(196),
    Level.wtf: AnsiColor.fg(199),
  };

  int stackTraceBeginIndex = 0;
  int methodCount = 0;
  int errorMethodCount = 8;
  bool colors = true;
  bool printTime = false;

  _Printer();

  @override
  List<String> log(LogEvent event) {
    // 信息字符串
    List<String> messageStr = _formatMessage(event.message);
    // 调用栈字符串
    String? stackTraceStr = _formatStackTrace(StackTrace.current, event.stackTrace == null ? methodCount : errorMethodCount);
    // 错误字符串
    var errorStr = event.error?.toString();
    // 时间字符串
    String? timeStr = printTime ? _formatTime(event.time) : null;

    return _format(event.level, messageStr, timeStr, errorStr, stackTraceStr);
  }

  String? _formatStackTrace(StackTrace? stackTrace, int methodCount) {
    if (methodCount <= 0) return null;
    List<String> lines = stackTrace.toString().split('\n').where((line) => line.isNotEmpty).toList();
    List<String> formatted = [];
    for (int count = 0; count < min(lines.length, methodCount); count++) {
      var line = lines[count];
      if (count < stackTraceBeginIndex) {
        continue;
      }
      formatted.add('#$count   ${line.replaceFirst(RegExp(r'#\d+\s+'), '')}');
    }

    return formatted.isEmpty ? null : formatted.join('\n');
  }

  /// 获取时间
  String _formatTime(DateTime time) {
    String threeDigits(int n) {
      if (n >= 100) return '$n';
      if (n >= 10) return '0$n';
      return '00$n';
    }

    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    var now = time;
    var h = twoDigits(now.hour);
    var min = twoDigits(now.minute);
    var sec = twoDigits(now.second);
    var ms = threeDigits(now.millisecond);
    return '$h:$min:$sec.$ms';
  }

  /// 字符串化日志
  List<String> _formatMessage(dynamic message) {
    if (null == message) return [""];
    final dynamic finalMessage = message is Function ? message() : message;
    if (null == finalMessage) return [""];
    if (finalMessage is Iterable) {
      return finalMessage.map((e) => e.toString()).toList();
    }
    if (finalMessage is Map) {
      List<String> buffer = ['{'];
      finalMessage.forEach((key, value) {
        buffer.add("    $key : $value ,");
      });
      buffer.add('}');
      return buffer;
    }
    return [finalMessage.toString()];
  }

  /// 获取日志颜色
  AnsiColor _getLevelColor(Level level) {
    if (colors) {
      return levelColors[level]!;
    } else {
      return AnsiColor.none();
    }
  }

  /// 格式化日志
  List<String> _format(
    Level level,
    List<String> message,
    String? time,
    String? error,
    String? stacktrace,
  ) {
    List<String> buffer = [];
    AnsiColor color = _getLevelColor(level);
    String prefix = '[${level.name.toLowerCase()}]';
    // 时间
    if (time != null) prefix += '[$time]';
    // 内容
    buffer.add(color('$prefix: ${message.join('\n')}'));
    // 错误信息
    error?.split('\n').forEach((line) => buffer.add(color(line)));
    // 调用栈
    stacktrace?.split('\n').forEach((line) => buffer.add(color(line)));
    return buffer;
  }
}
