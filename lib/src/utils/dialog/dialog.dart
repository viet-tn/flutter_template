import 'package:flutter/material.dart';

import '../../widgets/buttons/destruction_button.dart';
import '../extensions/string.dart';

class XDialog {
  const XDialog._();

  static Future<void> showDiscardWarning({
    required bool didPop,
    required BuildContext context,
  }) async {
    if (didPop) return;
    final navigator = Navigator.maybeOf(context);
    final shouldPop = await showAlert(
      context: context,
      title: 'Xác nhận thoát'.raw,
      content:
          'Những thông tin bạn đã nhập sẽ không được lưu. Tiếp tục thoát?'.raw,
      cancelActionText: 'Huỷ'.raw,
      defaultActionText: 'Thoát'.raw,
    );
    if (shouldPop ?? false) {
      navigator?.pop();
    }
  }

  static Future<bool?> showAlert({
    required BuildContext context,
    required String title,
    String? content,
    String? cancelActionText,
    String defaultActionText = 'OK',
    VoidCallback? onConfirmPressed,
    VoidCallback? onCancelPressed,
    bool isDestructionAction = false,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: isDestructionAction
            ? Icon(
                Icons.dangerous_outlined,
                color: Theme.of(context).colorScheme.error,
                size: 50,
              )
            : null,
        title: Text(title),
        content: content != null ? Text(content) : null,
        actions: [
          if (cancelActionText != null)
            TextButton(
              child: Text(cancelActionText),
              onPressed: () {
                Navigator.of(context).pop(false);
                onCancelPressed?.call();
              },
            ),
          if (isDestructionAction)
            DestructionButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                onConfirmPressed?.call();
              },
              label: defaultActionText,
            )
          else
            TextButton(
              child: Text(
                defaultActionText,
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
                onConfirmPressed?.call();
              },
            ),
        ],
      ),
    );
  }
}
