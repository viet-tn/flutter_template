import 'package:flutter/material.dart';

import '../../../navigation/navigation_bar_items.dart';

class BottomNavigationBarX extends StatelessWidget {
  const BottomNavigationBarX({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: NavigationBarItems.values
          .map(
            (e) => NavigationDestination(
              icon: Icon(e.icon),
              label: context.label(e),
              selectedIcon:
                  e.selectedIcon != null ? Icon(e.selectedIcon) : null,
            ),
          )
          .toList(),
    );
  }
}
