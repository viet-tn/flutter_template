import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n.dart';
import '../../navigation/route_names.dart';
import '../../utils/extensions/build_context.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.home)),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(context.l10n.home)],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Text(
                context.l10n.home,
                style: context.text.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            ListTile(
              title: Text(context.l10n.home),
              onTap: () {
                context.pop();
              },
            ),
            ListTile(
              title: Text(context.l10n.settings),
              onTap: () {
                context.goNamed(RouteNames.settings.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}
