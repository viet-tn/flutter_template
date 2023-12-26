import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/duration/durations.dart';
import '../../../utils/snack_bar/snack_bar.dart';
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
  late final AppLifecycleListener _appLifecycleListener;
  Timer? _timer;
  bool _canPop = false;

  @override
  void initState() {
    super.initState();

    // Initialize the AppLifecycleListener class and pass callbacks
    _appLifecycleListener = AppLifecycleListener(
      onDetach: _onDetach,
      onHide: _onHide,
      onInactive: _onInactive,
      onPause: _onPause,
      onRestart: _onRestart,
      onResume: _onResume,
      onShow: _onShow,
      onStateChange: _onStateChanged,
      onExitRequested: _onExitRequested,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _appLifecycleListener.dispose();
    super.dispose();
  }

  void _onDetach() => log('onDetach');

  void _onHide() => log('onHide');

  void _onInactive() => log('onInactive');

  void _onPause() => log('onPause');

  void _onRestart() => log('onRestart');

  void _onResume() => log('onResume');

  void _onShow() => log('onShow');

  void _onStateChanged(AppLifecycleState state) {
    // Track state changes
    log(state.toString());
  }

  // Ask the user if they want to exit the app. If the user
  // cancels the exit, return AppExitResponse.cancel. Otherwise,
  // return AppExitResponse.exit.
  Future<AppExitResponse> _onExitRequested() async {
    final response = await showDialog<AppExitResponse>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('Are you sure you want to quit this app?'),
        content: const Text('All unsaved progress will be lost.'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(AppExitResponse.cancel);
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(AppExitResponse.exit);
            },
          ),
        ],
      ),
    );

    return response ?? AppExitResponse.exit;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvoked: _onPopInvoked,
      child: Scaffold(
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

  void _onPopInvoked(bool didPop) {
    if (!didPop) {
      setState(() {
        _canPop = true;
      });
      XSnackBar.showExitWarning();
      _timer?.cancel();
      _timer = Timer(
        CDurations.exitWarning,
        () => setState(() {
          _canPop = false;
        }),
      );
    }
  }
}
