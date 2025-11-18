import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../ui/auth/controllers/auth_controller.dart';
import '../ui/auth/login/widgets/login_screen.dart';
import '../ui/auth/sign_up/widgets/sign_up_screen.dart';
import '../ui/home/widgets/home_screen.dart';
import '../ui/settings/widgets/settings_screen.dart';
import 'auth_state_listenable.dart';
import 'route.dart';
import 'widgets/dashboard_wrapper.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final authStateListenable = ref.watch(authStateListenableProvider);
  final router = GoRouter(
    initialLocation: XRoute.home.path,
    debugLogDiagnostics: kDebugMode,
    navigatorKey: _rootNavigatorKey,
    observers: [],
    refreshListenable: authStateListenable,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      if (authState == AuthState.authenticated) {
        if (XRoute.noAuthRoutePaths().contains(state.matchedLocation)) {
          return XRoute.home.path;
        }
      }
      if (authState == AuthState.unauthenticated ||
          authState == AuthState.expired) {
        if (!XRoute.noAuthRoutePaths().contains(state.matchedLocation)) {
          return XRoute.login.path;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: XRoute.login.path,
        name: XRoute.login.name,
        builder: (_, _) => const LoginScreen(),
      ),
      GoRoute(
        path: XRoute.signUp.path,
        name: XRoute.signUp.name,
        builder: (_, _) => const SignUpScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) =>
            DashboardWrapper(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: XRoute.home.path,
                name: XRoute.home.name,
                builder: (_, _) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: XRoute.settings.path,
                name: XRoute.settings.name,
                builder: (_, _) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  ref.onDispose(router.dispose);

  return router;
}
