import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../../domain/models/app_exception/app_error.dart';

part 'secure_storage_service.g.dart';

@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(Ref ref) {
  return const SecureStorageService(
    FlutterSecureStorage(
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
      webOptions: WebOptions(
        wrapKey: 'farm_management_app_wrap_key',
        wrapKeyIv: 'farm_management_app_wrap_key_iv',
      ),
    ),
  );
}

class SecureStorageService {
  const SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  TaskEither<AppError, Unit> write(String key, String value) {
    return TaskEither.tryCatch(
      () async {
        await _storage.write(key: key, value: value);
        return unit;
      },
      (err, st) => AppError.database(
        code: AppErrorCode.databaseWrite,
        message: 'Failed to write to secure storage for key: $key',
        originalError: err,
        stackTrace: Trace.from(st).terse,
      ),
    );
  }

  TaskEither<AppError, Option<String>> read(String key) {
    return TaskEither.tryCatch(
      () async {
        return Option.fromNullable(await _storage.read(key: key));
      },
      (err, st) => AppError.database(
        code: AppErrorCode.databaseRead,
        message: 'Failed to read from secure storage for key: $key',
        originalError: err,
        stackTrace: Trace.from(st).terse,
      ),
    );
  }

  TaskEither<AppError, Unit> delete(String key) {
    return TaskEither.tryCatch(
      () async {
        await _storage.delete(key: key);
        return unit;
      },
      (err, st) => AppError.database(
        code: AppErrorCode.databaseDelete,
        message: 'Failed to delete from secure storage for key: $key',
        originalError: err,
        stackTrace: Trace.from(st).terse,
      ),
    );
  }
}
