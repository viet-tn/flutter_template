import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/dashboard/presentation/dashboard_wrapper.dart';
import '../features/dashboard/presentation/home_screen.dart';

import '../features/profile/presentation/profile_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import 'route_names.dart';

part 'app_router.g.dart';

@riverpod
class AppRouter extends _$AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static BuildContext? get context => _rootNavigatorKey.currentContext;

  @override
  GoRouter build() {
    final router = GoRouter(
      initialLocation: RouteNames.home.path,
      debugLogDiagnostics: kDebugMode,
      navigatorKey: _rootNavigatorKey,
      observers: <NavigatorObserver>[],
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
          builder: (_, __, navigationShell) =>
              DashBoardWrapper(navigationShell: navigationShell),
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.home.path,
                  name: RouteNames.home.name,
                  builder: (_, __) => const HomeScreen(),
                  routes: <RouteBase>[
                    GoRoute(
                      path: RouteNames.settings.subPath,
                      name: RouteNames.settings.name,
                      builder: (_, __) => const SettingsScreen(),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.profile.path,
                  name: RouteNames.profile.name,
                  builder: (_, __) => const ProfileScreen(),
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
}
