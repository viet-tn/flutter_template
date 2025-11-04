import 'package:flutter/material.dart';

abstract class XSnackBar {
  static void showExitWarning(
    BuildContext context, {
    Duration duration = const Duration(seconds: 2),
  }) => const SnackBar(
    content: Text('Nhấn lần nữa để thoát'),
    showCloseIcon: true,
  ).show(context);

  static void showSuccess(BuildContext context, {required String content}) =>
      _success(context, content: content).show(context);

  static void showFailure(
    BuildContext context, {
    required String errorMessage,
  }) => _failure(context, errorMessage: errorMessage).show(context);

  static void showWarning(
    BuildContext context, {
    required String content,
    void Function()? undo,
  }) => _warning(context, content: content, undo: undo).show(context);

  static SnackBar _failure(
    BuildContext context, {
    required String errorMessage,
  }) => SnackBar(
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    closeIconColor: Theme.of(context).colorScheme.onError,
    backgroundColor: Theme.of(context).colorScheme.error,
    content: Text(
      errorMessage,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.onError,
      ),
    ),
    duration: const Duration(seconds: 8),
  );

  static SnackBar _success(BuildContext context, {required String content}) =>
      SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        content: Text(
          content,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      );

  static SnackBar _warning(
    BuildContext context, {
    required String content,
    void Function()? undo,
  }) => SnackBar(
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    closeIconColor: Theme.of(context).colorScheme.onErrorContainer,
    backgroundColor: Theme.of(context).colorScheme.errorContainer,
    content: Text(
      content,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onErrorContainer,
      ),
    ),
    action: undo == null
        ? null
        : SnackBarAction(
            label: 'Hoàn tác',
            textColor: Theme.of(context).colorScheme.onErrorContainer,
            onPressed: () => undo.call(),
          ),
  );
}

extension on SnackBar {
  void show(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(this);
  }
}
