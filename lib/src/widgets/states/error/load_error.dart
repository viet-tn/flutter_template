import 'package:flutter/material.dart';

import '../../../utils/extensions/string.dart';

class LoadError extends StatelessWidget {
  const LoadError(this.error, this.stackTrace, {super.key});

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Có lỗi khi tải dữ liệu'.raw,
        textAlign: TextAlign.center,
      ),
    );
  }
}
