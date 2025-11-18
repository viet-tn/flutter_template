import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../routing/route.dart';
import '../../../../utils/extensions/string_extension.dart';
import '../../../../utils/snack_bar.dart';
import '../../../core/themes/dimens.dart';
import '../../../core/ui/logo.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/email_field.dart';
import '../../widgets/form_switcher.dart';
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
    AuthController.loginMut.run(ref, (tsx) async {
      await Future.delayed(const Duration(milliseconds: 2000));
      await tsx
          .get(authControllerProvider.notifier)
          .loginWithEmailAndPassword(_formKey.currentState?.value)
          .match(
            (l) => XSnackBar.showFailure(
              context,
              errorMessage: l.message ?? 'Đã có lỗi xảy ra',
            ),

            (r) =>
                XSnackBar.showSuccess(context, content: 'Đăng nhập thành công'),
          )
          .run();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Consumer(
                    builder: (context, ref, child) {
                      final loginState = ref.watch(AuthController.loginMut);
                      return FormBuilder(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: Dimens.paddingVertical,
                          children: [
                            EmailField(enabled: !loginState.isPending),
                            PasswordField(
                              passwordHint: false,
                              onSubmitted: (_) => _submit(),
                              enabled: !loginState.isPending,
                            ),
                            SubmitButton(
                              onPressed: _submit,
                              label: 'Đăng nhập'.hc,
                              isLoading: loginState.isPending,
                            ),
                            AuthFormSwitcher(
                              description: 'Chưa có tài khoản?',
                              actionLabel: 'Đăng ký',
                              onPressed: () {
                                context.pushNamed(XRoute.signUp.name);
                              },
                            ),
                          ],
                        ),
                      );
                    },
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
