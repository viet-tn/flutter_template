import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../snack_bar.dart';

extension AsyncValueX<T> on AsyncValue<T> {
  void showLoadingAndError(BuildContext context, AsyncValue<T>? previous) {
    if (this is AsyncLoading) {
      // TODO: show loading
      return;
    }
    if (this is AsyncError) {
      XSnackBar.showFailure(context, errorMessage: error.toString());
      return;
    }
    if (previous is AsyncLoading) {
      // TODO: hide loading
      return;
    }
  }
}
