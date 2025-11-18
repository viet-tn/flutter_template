import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../utils/extensions/build_context_extension.dart';

class AuthFormSwitcher extends StatelessWidget {
  const AuthFormSwitcher({
    super.key,
    required this.description,
    required this.actionLabel,
    required this.onPressed,
  });

  final String description;
  final String actionLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium, // base style
        children: [
          TextSpan(text: description),
          TextSpan(text: ' '),
          TextSpan(
            text: actionLabel,
            style: TextStyle(
              color: context.color.primary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onPressed,
          ),
        ],
      ),
    );
  }
}
