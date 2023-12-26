import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.text.settings),
      ),
      body: Center(
        child: Text(L10n.text.settings),
      ),
    );
  }
}
