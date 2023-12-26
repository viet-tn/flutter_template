import 'package:flutter/material.dart';

import '../../constants/duration/durations.dart';
import '../../router/app_router.dart';
import '../extensions/string.dart';

class XSnackBar {
  const XSnackBar._();

  static final BuildContext _context = AppRouter.context!;
  static ThemeData? get _theme {
    final context = AppRouter.context;
    if (context == null) return null;
    return Theme.of(context);
  }

  static void showExitWarning() {
    final snackBar = SnackBar(
      duration: CDurations.exitWarning,
      content: Text('Nhấn lần nữa để thoát'.raw),
      showCloseIcon: true,
    );
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  static void showSuccess({required String content}) {
    _success(content: content).show(_context);
  }

  static void showFailure({required String errorMessage}) {
    _failure(errorMessage: errorMessage).show(_context);
  }

  static void showWarning({required String content, void Function()? undo}) {
    _warning(
      content: content,
      undo: () => undo?.call(),
    ).show(_context);
  }

  static SnackBar _failure({required String errorMessage}) => SnackBar(
        showCloseIcon: true,
        closeIconColor: _theme?.colorScheme.onError,
        backgroundColor: _theme?.colorScheme.error,
        content: Text(
          errorMessage,
          style: _theme?.textTheme.labelLarge?.copyWith(
            color: _theme?.colorScheme.onError,
          ),
        ),
        duration: const Duration(seconds: 8),
      );

  static SnackBar _success({required String content}) => SnackBar(
        showCloseIcon: true,
        content: Text(
          content,
          style: _theme?.textTheme.labelLarge
              ?.copyWith(color: _theme?.colorScheme.onPrimary),
        ),
      );

  static SnackBar _warning({required String content, void Function()? undo}) =>
      SnackBar(
        showCloseIcon: true,
        closeIconColor: _theme?.colorScheme.onErrorContainer,
        backgroundColor: _theme?.colorScheme.errorContainer,
        content: Text(
          content,
          style: _theme?.textTheme.bodyMedium?.copyWith(
            color: _theme?.colorScheme.onErrorContainer,
          ),
        ),
        action: SnackBarAction(
          label: 'Hoàn tác'.raw,
          textColor: _theme?.colorScheme.onErrorContainer,
          onPressed: () => undo?.call(),
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
