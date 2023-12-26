import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  const DialogPage({required this.child, super.key});
  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
        context: context,
        settings: this,
        builder: (context) => Dialog(
          child: child,
        ),
      );
}
