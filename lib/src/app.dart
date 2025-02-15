import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import 'navigation/app_router.dart';
import 'themes/themes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static const _exitDuration = Duration(seconds: 2);
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

  void _onPopInvoked(BuildContext context, bool didPop) {
    if (!didPop) {
      setState(() {
        _canPop = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ấn lần nữa để thoát'),
          duration: _exitDuration,
        ),
      );
      _timer?.cancel();
      _timer = Timer(
        _exitDuration,
        () => setState(() {
          _canPop = false;
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult:
          (didPop, result) => _onPopInvoked(context, didPop),
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        locale: const Locale('vi'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: XTheme.light,
        darkTheme: XTheme.dark,
      ),
    );
  }
}
