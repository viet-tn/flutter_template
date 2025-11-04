import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/snack_bar.dart';
import 'bottom_navigation_bar.dart';

class DashboardWrapper extends StatefulWidget {
  const DashboardWrapper({
    required this.navigationShell,
    super.key = const ValueKey<String>('DashboardWrapper'),
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<DashboardWrapper> createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {
  Timer? _timer;
  bool _canPop = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (didPop, _) => _onPopInvoked(context, didPop),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(child: widget.navigationShell),
        bottomNavigationBar: BottomNavigationBarX(
          currentIndex: widget.navigationShell.currentIndex,
          onTap: (index) => _onTap(context, index),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  void _onPopInvoked(BuildContext context, bool didPop) {
    if (!didPop) {
      setState(() {
        _canPop = true;
      });
      XSnackBar.showExitWarning(context);
      _timer?.cancel();
      _timer = Timer(
        const Duration(seconds: 2),
        () => setState(() {
          _canPop = false;
        }),
      );
    }
  }
}
