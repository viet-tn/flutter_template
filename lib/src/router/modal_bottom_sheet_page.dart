import 'package:flutter/material.dart';

class ModelBottomSheetPage<T> extends Page<T> {
  const ModelBottomSheetPage({required this.child, super.key});
  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
        isScrollControlled: true,
        useSafeArea: true,
        settings: this,
        builder: (_) => child,
      );
}
