import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/route.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../core/themes/dimens.dart';

enum CurrentPage { login, signUp }

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.method,
  });

  final VoidCallback onPressed;
  final CurrentPage method;

  String get _buttonLabel {
    return switch (method) {
      CurrentPage.login => 'Đăng nhập',
      CurrentPage.signUp => 'Đăng ký',
    };
  }

  String get _alreadyDescription {
    return switch (method) {
      CurrentPage.login => 'Chưa có tài khoản ',
      CurrentPage.signUp => 'Đã có tài khoản ',
    };
  }

  String get _alreadyButtonLabel {
    return switch (method) {
      CurrentPage.signUp => 'Đăng nhập',
      CurrentPage.login => 'Đăng ký',
    };
  }

  void _handler(BuildContext context) {
    return switch (method) {
      CurrentPage.signUp => context.goNamed(XRoute.login.name),
      CurrentPage.login => context.pushNamed(XRoute.signUp.name),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Dimens.paddingVertical / 2,
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton(onPressed: onPressed, child: Text(_buttonLabel)),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium, // base style
            children: [
              TextSpan(text: _alreadyDescription),
              TextSpan(
                text: _alreadyButtonLabel,
                style: TextStyle(
                  color: context.color.primary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _handler(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
