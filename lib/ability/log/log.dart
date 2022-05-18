import 'dart:collection';

import 'package:logger/logger.dart';

/// 日志工具
class LogHelper {
  LogHelper._();

  /// 日志输出
  static final MemoryOutput _memoryOutput = MemoryOutput(bufferSize: 100, secondOutput: ConsoleOutput());

  /// 日志工具
  static final Logger _logger = Logger(output: _memoryOutput);

  /// 日志输出
  static ListQueue<OutputEvent> get output => _memoryOutput.buffer;

  /// 长日志
  static void verbose(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.v(message, error, stackTrace);
  }

  /// 调试日志
  static void debug(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(message, error, stackTrace);
  }

  /// 信息日志
  static void info(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error, stackTrace);
  }

  /// 警告日志
  static void warning(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error, stackTrace);
  }

  /// 错误日志
  static void error(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error, stackTrace);
  }

  /// 严重错误日志
  static void wtf(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.wtf(message, error, stackTrace);
  }
}
