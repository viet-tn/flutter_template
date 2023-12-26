import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../snack_bar/snack_bar.dart';
import 'string.dart';

extension AsyncValueUi on AsyncValue<Object> {
  void showLoadingDialog(BuildContext context, AsyncValue<dynamic>? previous) {
    if (isLoading) {
      showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (context) => const PopScope(
          canPop: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if ((previous?.isLoading ?? false) && !isLoading) {
      Navigator.of(context).pop();
    }
  }

  void showSuccess({
    required String content,
    VoidCallback? onSuccess,
  }) {
    if (!isRefreshing && hasValue) {
      XSnackBar.showSuccess(content: content);
      onSuccess?.call();
    }
  }

  void showError({String? errorMessage}) {
    if (isRefreshing || !hasError) return;

    XSnackBar.showFailure(
      errorMessage: errorMessage ?? 'Đã xảy ra lỗi, vui lòng thử lại!'.raw,
    );
  }
}
