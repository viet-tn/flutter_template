import 'package:flutter/material.dart';

import '../../core/themes/dimens.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Dimens.paddingVertical / 2,
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: isLoading ? null : onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Text(label),
                if (isLoading) CircularProgressIndicator.adaptive(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
