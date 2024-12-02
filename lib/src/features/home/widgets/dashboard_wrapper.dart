import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'bottom_navigation_bar.dart';

class DashBoardWrapper extends StatefulWidget {
  const DashBoardWrapper({
    required this.navigationShell,
    super.key = const ValueKey<String>('DashBoardWrapper'),
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<DashBoardWrapper> createState() => _DashBoardWrapperState();
}

class _DashBoardWrapperState extends State<DashBoardWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.navigationShell),
      bottomNavigationBar: BottomNavigationBarX(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
