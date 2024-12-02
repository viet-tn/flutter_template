import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import 'route_names.dart';

enum NavigationBarItems {
  home(
    route: RouteNames.home,
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
  ),
  settings(
    route: RouteNames.settings,
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
  );

  const NavigationBarItems({
    required this.route,
    required this.icon,
    // ignore: unused_element
    this.selectedIcon,
  });

  final RouteNames route;
  final IconData icon;
  final IconData? selectedIcon;

  String get name => route.name;

  static Iterable<RouteNames> get routes => values.map((e) => e.route);

  static NavigationBarItems fromRoute(RouteNames route) =>
      NavigationBarItems.values.firstWhere(
        (element) => element.route == route,
        orElse: () => NavigationBarItems.home,
      );
}

extension NavigationBarItemsContext on BuildContext {
  String label(NavigationBarItems item) => switch (item) {
        NavigationBarItems.home => l10n.home,
        NavigationBarItems.settings => l10n.settings,
      };
}
