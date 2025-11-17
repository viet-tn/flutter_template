import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../../domain/models/app_exception/app_error.dart';

part 'shared_preferences_service.g.dart';

@Riverpod(keepAlive: true)
SharedPreferencesWithCache sharedPreferencesWithCache(Ref ref) {
  // Initialize this on app startup then overwrite this provider's value
  throw UnimplementedError();
}

@Riverpod(keepAlive: true, dependencies: [sharedPreferencesWithCache])
SharedPreferencesService sharedPreferencesService(Ref ref) {
  final prefs = ref.watch(sharedPreferencesWithCacheProvider);
  return SharedPreferencesService(prefs);
}

class SharedPreferencesService {
  const SharedPreferencesService(this._pref);

  final SharedPreferencesWithCache _pref;

  TaskEither<AppError, Unit> write(String key, String value) {
    return TaskEither.tryCatch(
      () async {
        await _pref.setString(key, value);
        return unit;
      },
      (e, st) => AppError.database(
        code: AppErrorCode.databaseWrite,
        message: 'failed to set $key key: $e',
        originalError: e,
        stackTrace: Trace.from(st).terse,
      ),
    );
  }

  Option<String> read(String key) {
    return Option.fromNullable(_pref.getString(key));
  }

  TaskEither<AppError, Unit> delete(String key) {
    return TaskEither.tryCatch(
      () async {
        await _pref.remove(key);
        return unit;
      },
      (e, st) => AppError.database(
        code: AppErrorCode.databaseDelete,
        message: 'failed to remove $key key: $e',
        originalError: e,
        stackTrace: Trace.from(st).terse,
      ),
    );
  }

  TaskEither<AppError, Unit> reloadCache() {
    return TaskEither.tryCatch(
      () async {
        await _pref.reloadCache();
        return unit;
      },
      (e, st) => AppError.database(
        code: AppErrorCode.databaseOperation,
        message: 'failed to reload cache: $e',
        originalError: e,
        stackTrace: Trace.from(st).terse,
      ),
    );
  }
}
