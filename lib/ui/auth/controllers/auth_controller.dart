import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../data/repositories/auth/auth_repository_impl.dart';
import '../../../data/repositories/token/token_repository.dart';
import '../../../data/repositories/token/token_repository_impl.dart';
import '../../../data/services/api/models/auth/login_request.dart';
import '../../../domain/models/app_exception/app_error.dart';
import '../../../utils/loggers/logger.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true, dependencies: [authRepository, tokenRepository])
class AuthController extends _$AuthController {
  late final AuthRepository _authRepository = ref.watch(authRepositoryProvider);
  late final TokenRepository _tokenRepository = ref.watch(
    tokenRepositoryProvider,
  );

  @override
  Future<AuthStatus> build() async {
    state = const AsyncData(AuthStatus.unknown);
    final result = await _authStatus.run();
    return result.match((l) {
      Log.e('Failed to get auth status', err: l);
      return AuthStatus.unauthenticated;
    }, (isLoggedIn) => isLoggedIn);
  }

  void loginWithEmailAndPassword(
    Map<String, Object?>? data, {
    required void Function() onSuccess,
  }) async {
    if (state is AsyncLoading) {
      return;
    }
    state = const AsyncLoading();
    if (data == null) {
      state = AsyncError(
        AppError.validation(message: 'Invalid login data'),
        Trace.current().terse,
      );
      return;
    }
    final req = LoginRequest.fromJson(data);
    final result = await _authRepository.loginWithEmailAndPassword(req).run();
    result.match(
      (l) {
        state = AsyncError(l, l.stackTrace ?? Trace.current().terse);
      },
      (_) {
        state = const AsyncData(AuthStatus.authenticated);
        onSuccess();
      },
    );
  }

  void logout() async {
    TaskEither<AppError, Unit> logoutAndExpire() {
      return TaskEither.Do(($) async {
        await $(_authRepository.logout());
        await $(_tokenRepository.deleteToken());
        return unit;
      });
    }

    await logoutAndExpire().run().then((result) {
      result.match(
        (l) {
          Log.e('Failed to logout', err: l);
          state = AsyncError(l, l.stackTrace ?? Trace.current().terse);
        },
        (_) {
          state = const AsyncData(AuthStatus.unauthenticated);
        },
      );
    });
  }

  TaskEither<AppError, AuthStatus> get _authStatus {
    return _tokenRepository.getUsableToken().flatMap(
      (maybeToken) => maybeToken.match(
        () => TaskEither.right(AuthStatus.unauthenticated),
        (t) => TaskEither.right(AuthStatus.authenticated),
      ),
    );
  }
}
