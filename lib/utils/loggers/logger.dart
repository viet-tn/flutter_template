import 'package:logger/logger.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../domain/models/app_exception/app_error.dart';

abstract class Log {
  static final _logger = Logger(
    printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5),
  );
  static void _log(Level level, [String? message, AppError? error]) {
    _logger.log(
      level,
      message ?? error?.message,
      error: error?.originalError,
      stackTrace: error?.stackTrace != null
          ? Trace.from(error!.stackTrace!).terse
          : null,
    );
  }

  static void d(String? message, {AppError? error}) {
    _log(Level.debug, message, error);
  }

  static void i(String? message) {
    _log(Level.info, message);
  }

  static void w(String? message, {AppError? err}) {
    _log(Level.warning, message, err);
  }

  static void e(String? message, {AppError? err}) {
    _log(Level.error, message, err);
  }

  static void f(String? message, {AppError? err}) {
    _log(Level.fatal, message, err);
  }
}
