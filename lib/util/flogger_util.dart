import 'package:logger/logger.dart';

class FLogger {
  static FLogger? _instance; // 业务使用的实例
  final Logger _logger = Logger(
      printer: PrettyPrinter(stackTraceBeginIndex: 1)); // 底层依赖日志的实例, 过滤掉封装的这一级别

  static FLogger instance() {
    return _instance ??= FLogger._internal();
  }

  // 实例化
  FLogger._internal() {
    // 设置默认日志等级
    Logger.level = Level.debug;
  }

  // 业务初始化
  FLogger init({Level? level}) {
    Logger.level = level ?? Level.debug;
    return this;
  }

  // 打印日志
  void info(dynamic message) {
    _logger.i(message);
  }

  void warn(dynamic message) {
    _logger.w(message);
  }

  void error(dynamic message) {
    _logger.e(message);
  }

  void debug(dynamic message) {
    _logger.d(message);
  }

  void t(dynamic message) {
    _logger.t(message);
  }
}
