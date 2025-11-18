import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../data/repositories/auth/auth_repository_impl.dart';
import '../../../data/repositories/token/token_repository.dart';
import '../../../data/repositories/token/token_repository_impl.dart';
import '../../../data/services/api/models/auth/login_request.dart';
import '../../../domain/models/app_exception/app_error.dart';
import '../../../utils/extensions/fp_extension.dart';
import '../../../utils/loggers/logger.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  late final AuthRepository _authRepository = ref.watch(authRepositoryProvider);
  late final TokenRepository _tokenRepository = ref.watch(
    tokenRepositoryProvider,
  );

  static final loginMut = Mutation<void>();
  static final logoutMut = Mutation<void>();

  @override
  AuthState build() {
    return AuthState.unknown;
  }

  Future<void> initialize() async {
    final result = await _authState.run();
    state = result.match((l) {
      Log.e('Failed to get auth state', err: l);
      return AuthState.unauthenticated;
    }, (authState) => authState);
  }

  TaskEither<AppError, Unit> loginWithEmailAndPassword(
    Map<String, Object?>? data,
  ) {
    return FpExtension.safelyParse(
      () => LoginRequest.fromJson(data ?? {}),
    ).toTaskEither().flatMap((req) {
      return TaskEither.Do(($) async {
        await $(_authRepository.loginWithEmailAndPassword(req));
        state = AuthState.authenticated;
        return unit;
      });
    });
  }

  TaskEither<AppError, Unit> logout() {
    state = AuthState.unauthenticated;
    return _logoutAndExpire().mapLeft((l) {
      Log.e('Logout failed', err: l);
      return l;
    });
  }

  TaskEither<AppError, AuthState> get _authState {
    return _tokenRepository.getUsableToken().map(
      (maybeToken) => maybeToken.match(
        () => AuthState.unauthenticated,
        (_) => AuthState.authenticated,
      ),
    );
  }

  TaskEither<AppError, Unit> _logoutAndExpire() {
    return TaskEither.Do(($) async {
      await $(_authRepository.logout());
      await $(_tokenRepository.deleteToken());
      return unit;
    });
  }
}
