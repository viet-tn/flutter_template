import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/home/home_screen.dart';
import '../features/home/widgets/dashboard_wrapper.dart';
import '../features/settings/settings_screen.dart';
import 'route_names.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final appRouter = GoRouter(
  initialLocation: RouteNames.home.path,
  debugLogDiagnostics: kDebugMode,
  navigatorKey: _rootNavigatorKey,
  observers: [],
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (_, __, navigationShell) =>
              DashBoardWrapper(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.home.path,
              name: RouteNames.home.name,
              builder: (_, __) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.settings.path,
              name: RouteNames.settings.name,
              builder: (_, __) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
