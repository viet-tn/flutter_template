import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/home_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(homeControllerProvider);
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async => ref.refresh(homeControllerProvider),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                height: 1000,
                child: Column(
                  children: [
                    userAsync.when(
                      data: (data) {
                        return Text(data.toString());
                      },
                      error: (error, stackTrace) {
                        return Text(error.toString());
                      },
                      loading: CircularProgressIndicator.adaptive,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
