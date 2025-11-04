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
import '../utils/extensions/string_extension.dart';
import '../utils/snack_bar.dart';
import 'route.dart';
import 'widgets/dashboard_wrapper.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

@Riverpod(dependencies: [AuthController])
GoRouter router(Ref ref) {
  final router = GoRouter(
    initialLocation: XRoute.home.path,
    debugLogDiagnostics: kDebugMode,
    navigatorKey: _rootNavigatorKey,
    observers: [],
    redirect: (context, state) => _redirect(context, state, ref),
    routes: [
      GoRoute(
        path: XRoute.login.path,
        name: XRoute.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: XRoute.signUp.path,
        name: XRoute.signUp.name,
        builder: (context, state) => const SignUpScreen(),
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

  ref.listen<AsyncValue<AuthStatus>>(authControllerProvider, (_, _) {
    router.refresh();
  });
  ref.onDispose(router.dispose);

  return router;
}

Future<String?> _redirect(
  BuildContext context,
  GoRouterState state,
  Ref ref,
) async {
  final authStatus =
      ref.read(authControllerProvider).value ?? AuthStatus.unknown;
  final loggedIn = authStatus == AuthStatus.authenticated;
  if (loggedIn) {
    if (XRoute.noAuthRoutePaths().contains(state.matchedLocation)) {
      return XRoute.home.path;
    }
  } else {
    if (!XRoute.noAuthRoutePaths().contains(state.matchedLocation)) {
      bool isSessionExpired = authStatus == AuthStatus.expired;
      if (isSessionExpired) {
        XSnackBar.showWarning(
          context,
          content: 'Phiên đăng nhập đã hết hạn'.hc,
        );
      }
      return XRoute.login.path;
    }
  }

  return null;
}
