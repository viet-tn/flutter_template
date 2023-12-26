import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/navigation_bar_items.dart';

class BottomNavigationBarX extends ConsumerWidget {
  const BottomNavigationBarX({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: NavigationBarItems.values
          .map(
            (e) => NavigationDestination(
              icon: Icon(e.icon),
              label: e.label,
              selectedIcon:
                  e.selectedIcon != null ? Icon(e.selectedIcon) : null,
            ),
          )
          .toList(),
    );
  }
}
