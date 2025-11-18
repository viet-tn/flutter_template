import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../ui/auth/controllers/auth_controller.dart';

part 'auth_state_listenable.g.dart';

@Riverpod(keepAlive: true)
Raw<AuthStateListenable> authStateListenable(Ref ref) {
  return AuthStateListenable(ref);
}

class AuthStateListenable extends ChangeNotifier {
  final Ref _ref;

  AuthStateListenable(this._ref) {
    _ref.listen<AuthState?>(authControllerProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }
}
