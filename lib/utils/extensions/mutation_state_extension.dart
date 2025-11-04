import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';

import '../snack_bar.dart';
import 'string_extension.dart';

extension MutationStateExtension<T> on MutationState<T> {
  void showLoading(BuildContext context, MutationState<T>? previous) async {
    if (this is MutationPending<T>) {
      await showAdaptiveDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: Dialog(
              constraints: BoxConstraints.loose(const Size.square(100)),
              child: const Center(child: CircularProgressIndicator.adaptive()),
            ),
          );
        },
      );
      return;
    }
    if (previous is MutationPending<T>) {
      Navigator.of(context).pop();
    }
  }

  void showSuccess(
    BuildContext context,
    String content, {
    void Function()? onSuccess,
  }) {
    if (this is MutationSuccess<T>) {
      XSnackBar.showSuccess(context, content: content);
      onSuccess?.call();
    }
  }

  void showError(BuildContext context, String content) {
    if (this is MutationError<T>) {
      XSnackBar.showFailure(context, errorMessage: 'Có lỗi xảy ra'.hc);
    }
  }

  void showState(
    BuildContext context,
    MutationState<T>? previous, {
    String? successMsg,
    String? errorMsg,
    void Function()? onSuccess,
  }) {
    showLoading(context, previous);
    showSuccess(context, successMsg ?? 'Thành công!'.hc, onSuccess: onSuccess);
    showError(context, successMsg ?? 'Có lỗi xảy ra!'.hc);
  }
}
