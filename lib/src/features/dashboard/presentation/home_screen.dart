import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/l10n.dart';
import '../../../router/route_names.dart';
import '../../../utils/extensions/materials/build_context.dart';
import '../../../utils/extensions/materials/text_style.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.text.appName),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: Center(
        child: TextButton(
          onPressed: () => context.pushNamed(RouteNames.settings.name),
          child: Text(
            L10n.text.settings,
            style: context.text.bodyLarge?.bold,
          ),
        ),
      ),
    );
  }
}
