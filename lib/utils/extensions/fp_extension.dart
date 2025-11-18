import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../domain/models/app_exception/app_error.dart';

const _jsonEncoder = JsonEncoder();
const _jsonDecoder = JsonDecoder();

extension FpExtension on Map<String, dynamic> {
  Either<AppError, String> jsonEncodeSafe() {
    try {
      final encoded = _jsonEncoder.convert(this);
      return Either.right(encoded);
    } catch (e, st) {
      return Either.left(
        AppError.encoding(
          data: this,
          message: 'Failed to encode data to JSON',
          originalError: e,
          stackTrace: Trace.from(st).terse,
        ),
      );
    }
  }

  static Either<AppError, T> safelyParse<T>(T Function() parser) =>
      Either.tryCatch(
        () => parser(),
        (err, st) => AppError.parse(
          code: AppErrorCode.parseFailed,
          data: null,
          message: 'Failed to parse data',
          originalError: err,
          stackTrace: Trace.from(st).terse,
        ),
      );
}

extension FpStringExtension on String {
  Either<AppError, Map<String, dynamic>> jsonDecodeSafe() {
    try {
      final decoded = _jsonDecoder.convert(this) as Map<String, dynamic>;
      return Either.right(decoded);
    } catch (e, st) {
      return Either.left(
        AppError.decoding(
          data: this,
          message: 'Failed to decode JSON string',
          originalError: e,
          stackTrace: Trace.from(st).terse,
        ),
      );
    }
  }

  Either<AppError, DateTime> toDateTimeSafe() {
    try {
      final dateTime = DateTime.parse(this);
      return Either.right(dateTime);
    } catch (e, st) {
      return Either.left(
        AppError.parse(
          data: this,
          message: 'Failed to parse DateTime from string',
          originalError: e,
          stackTrace: Trace.from(st).terse,
        ),
      );
    }
  }
}
