import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'flavors.dart';
import 'routing/router.dart';
import 'ui/auth/controllers/auth_controller.dart';
import 'ui/core/localization/app_localizations.dart';
import 'ui/core/themes/themes.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await ref.read(authControllerProvider.notifier).initialize();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: F.title,
      routerConfig: ref.watch(goRouterProvider),
      locale: const Locale('vi', 'VN'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: Builder(
          builder: (context) {
            return ResponsiveScaledBox(
              width: ResponsiveValue<double?>(
                context,
                conditionalValues: [
                  const Condition.equals(name: MOBILE, value: 450),
                  const Condition.between(start: 800, end: 1366, value: 800),
                  const Condition.between(start: 1920, end: 4096, value: 1920),
                ],
              ).value,
              child: ClampingScrollWrapper.builder(context, child!),
            );
          },
        ),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}
