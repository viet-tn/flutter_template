import 'package:flutter/material.dart';

import 'route.dart';

enum NavigationBarItem {
  home(route: XRoute.home, icon: Icons.home_outlined, selectedIcon: Icons.home),
  settings(
    route: XRoute.settings,
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
  );

  const NavigationBarItem({
    required this.route,
    required this.icon,
    // ignore: unused_element
    this.selectedIcon,
  });

  final XRoute route;
  final IconData icon;
  final IconData? selectedIcon;

  static Iterable<String> get routes => values.map((e) => e.route.path);

  static NavigationBarItem fromRoute(String route) =>
      NavigationBarItem.values.firstWhere(
        (element) => element.route.path == route,
        orElse: () => NavigationBarItem.home,
      );
}

extension NavigationBarItemsContext on BuildContext {
  String label(NavigationBarItem item) => switch (item) {
    NavigationBarItem.home => 'Trang chủ',
    NavigationBarItem.settings => 'Cài đặt',
  };
}
