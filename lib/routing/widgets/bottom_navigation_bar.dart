import 'package:flutter/material.dart';

import '../../utils/extensions/build_context_extension.dart';
import '../navigation_bar_item.dart';

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
    final labelStyle = context.text.bodySmall?.copyWith(
      color: context.color.onSurface,
      fontWeight: FontWeight.w400,
    );
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
        (states) => states.contains(WidgetState.selected)
            ? labelStyle?.copyWith(
                fontWeight: FontWeight.w900,
                color: context.color.primary,
              )
            : labelStyle,
      ),
      destinations: NavigationBarItem.values
          .map(
            (e) => NavigationDestination(
              icon: Icon(e.icon),
              label: context.label(e),
              selectedIcon: e.selectedIcon != null
                  ? Icon(e.selectedIcon)
                  : null,
            ),
          )
          .toList(),
    );
  }
}
