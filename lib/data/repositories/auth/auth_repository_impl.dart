import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/models/app_exception/app_error.dart';
import '../../services/api/models/auth/login_request.dart';
import '../../services/api/models/auth/sign_up_request.dart';
import '../../services/api/auth/auth_client.dart';
import 'auth_repository.dart';

part 'auth_repository_impl.g.dart';

@Riverpod(dependencies: [authClient])
AuthRepository authRepository(Ref ref) {
  final authClient = ref.watch(authClientProvider);
  return AuthRepositoryImpl(authClient);
}

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this._client);

  final AuthClient _client;

  @override
  TaskEither<AppError, Unit> signUp(SignUpRequest req) {
    return _client.signUp(req);
  }

  @override
  TaskEither<AppError, Unit> loginWithEmailAndPassword(LoginRequest req) {
    return _client.loginWithEmailAndPassword(req).flatMap((res) {
      return TaskEither.right(unit);
    });
  }

  @override
  TaskEither<AppError, Unit> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  TaskEither<AppError, Unit> loginWithZalo() {
    // TODO: implement loginWithZalo
    throw UnimplementedError();
  }

  @override
  TaskEither<AppError, Unit> logout() {
    return TaskEither.right(unit);
  }
}
