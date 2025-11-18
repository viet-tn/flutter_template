import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controllers/auth_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _logout(WidgetRef ref) {
    AuthController.logoutMut.run(ref, (tsx) async {
      await Future.delayed(const Duration(milliseconds: 2000));
      await tsx.get(authControllerProvider.notifier).logout().run();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final isLoading = ref.watch(
              AuthController.logoutMut.select((state) => state.isPending),
            );
            return FilledButton(
              onPressed: isLoading ? null : () => _logout(ref),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  const Text('Đăng xuất'),
                  if (isLoading) const CircularProgressIndicator.adaptive(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
