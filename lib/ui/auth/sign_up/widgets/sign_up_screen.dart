import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/route.dart';
import '../../../../utils/extensions/async_value.dart';
import '../../../../utils/extensions/string_extension.dart';
import '../../../../utils/form/single_space_formatter.dart';
import '../../../../utils/snack_bar.dart';
import '../../../core/themes/dimens.dart';
import '../../../core/ui/form/text_form_field.dart';
import '../../../core/ui/logo.dart';
import '../../widgets/email_field.dart';
import '../../widgets/form_switcher.dart';
import '../../widgets/password_field.dart';
import '../../widgets/submit_button.dart';
import '../controllers/sign_up_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    final isValidate = _formKey.currentState?.saveAndValidate();
    if (isValidate != true) return;
    FocusScope.of(context).unfocus();
    ref
        .read(signUpControllerProvider.notifier)
        .signUp(
          _formKey.currentState?.value,
          onSuccess: () {
            context.goNamed(XRoute.login.name);
            XSnackBar.showSuccess(context, content: 'Đăng ký thành công');
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signUpControllerProvider, (previous, next) {
      next.showLoadingAndError(context, previous);
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Logo(),
              FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: Dimens.edgeInsetsScreenSymmetric,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: Dimens.paddingVertical,
                    children: [
                      XTextFormField(
                        name: 'full_name',
                        labelText: 'Họ và Tên',
                        hintText: 'VD: Nguyễn Văn A',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Vui lòng nhập Họ và Tên',
                          ),
                          FormBuilderValidators.match(
                            RegExp(
                              r"^[\p{L}]+(?:['’-][\p{L}]+)*(?: [\p{L}]+(?:['’-][\p{L}]+)*)+$",
                              unicode: true,
                            ),
                            errorText: 'Vui lòng nhập đúng họ và tên',
                          ),
                        ]),
                        autofocus: true,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [SingleSpaceFormatter()],
                      ),
                      const EmailField(),
                      const PasswordField(),
                      SubmitButton(label: 'Đăng ký'.hc, onPressed: _submit),
                      AuthFormSwitcher(
                        description: 'Đã có tài khoản?',
                        actionLabel: 'Đăng nhập',
                        onPressed: () {
                          context.goNamed(XRoute.login.name);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
