import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../utils/extensions/async_value.dart';
import '../../../../utils/snack_bar.dart';
import '../../../core/themes/dimens.dart';
import '../../../core/ui/logo.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/email_field.dart';
import '../../widgets/password_field.dart';
import '../../widgets/submit_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    final isValidate = _formKey.currentState?.saveAndValidate();
    if (isValidate != true) return;
    FocusScope.of(context).unfocus();
    ref
        .read(authControllerProvider.notifier)
        .loginWithEmailAndPassword(
          _formKey.currentState?.value,
          onSuccess: () {
            XSnackBar.showSuccess(context, content: 'Đăng nhập thành công');
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(authControllerProvider, (previous, next) {
      next.showLoadingAndError(context, previous);
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: MaxWidthBox(
            maxWidth: 1000,
            child: Column(
              children: [
                const Logo(),
                Padding(
                  padding: Dimens.edgeInsetsScreenSymmetric,
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: Dimens.paddingVertical,
                      children: [
                        const EmailField(),
                        PasswordField(
                          passwordHint: false,
                          onSubmitted: (_) => _submit(),
                        ),
                        SubmitButton(
                          onPressed: _submit,
                          method: CurrentPage.login,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
