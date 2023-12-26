import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../router/route_names.dart';

enum NavigationBarItems {
  home(
    route: RouteNames.home,
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
  ),
  profile(
    route: RouteNames.profile,
    icon: Icons.person_outline,
    selectedIcon: Icons.person,
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

  String get label => switch (this) {
        NavigationBarItems.home => L10n.text.home,
        NavigationBarItems.profile => L10n.text.profile,
      };

  static NavigationBarItems fromRoute(RouteNames route) =>
      NavigationBarItems.values.firstWhere(
        (element) => element.route == route,
        orElse: () => NavigationBarItems.home,
      );
}
