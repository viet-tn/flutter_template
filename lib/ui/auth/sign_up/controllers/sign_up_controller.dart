import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../../../data/repositories/auth/auth_repository.dart';
import '../../../../data/repositories/auth/auth_repository_impl.dart';
import '../../../../data/services/api/models/auth/sign_up_request.dart';
import '../../../../domain/models/app_exception/app_error.dart';

part 'sign_up_controller.g.dart';

@riverpod
class SignUpController extends _$SignUpController {
  late final AuthRepository _authRepository = ref.watch(authRepositoryProvider);

  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  void signUp(
    Map<String, Object?>? data, {
    required void Function() onSuccess,
  }) async {
    if (state is AsyncLoading) {
      return;
    }
    state = const AsyncLoading();
    if (data == null) {
      state = AsyncError(
        AppError.validation(message: 'Sign up data is null'),
        Trace.current(),
      );
      return;
    }
    final req = SignUpRequest.fromJson(data);
    final result = await _authRepository.signUp(req).run();
    result.match(
      (l) {
        state = AsyncError(l, Trace.current());
      },
      (_) {
        state = const AsyncData(null);
        onSuccess();
      },
    );
  }
}
