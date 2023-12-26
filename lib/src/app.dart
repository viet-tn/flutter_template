import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/l10n.dart';
import 'router/app_router.dart';
import 'themes/themes.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      locale: ref.watch(appLocaleProvider),
      routerConfig: ref.watch(appRouterProvider),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: XTheme.light,
      darkTheme: XTheme.dark,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1.2),
          alwaysUse24HourFormat: true,
        ),
        child: child!,
      ),
    );
  }
}
