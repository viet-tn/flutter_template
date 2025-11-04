import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controllers/auth_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            return FilledButton(
              onPressed: ref.read(authControllerProvider.notifier).logout,
              child: const Text('Đăng xuất'),
            );
          },
        ),
      ),
    );
  }
}
