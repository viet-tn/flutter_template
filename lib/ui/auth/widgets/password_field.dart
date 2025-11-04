import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../core/ui/form/text_form_field.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key, this.passwordHint = true, this.onSubmitted});

  final bool passwordHint;
  final void Function(String?)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return XTextFormField(
      name: 'password',
      labelText: 'Mật khẩu',
      helperText: passwordHint ? 'Mật khẩu phải chứa ít nhất 8 kí tự' : null,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Vui lòng nhập Mật khẩu'),
        if (passwordHint)
          FormBuilderValidators.minLength(
            8,
            errorText: 'Mật khẩu phải chứa ít nhất 8 kí tự',
          ),
      ]),
      obscureText: true,
      textInputAction: TextInputAction.done,
      autofillHints: [AutofillHints.password],
      onSubmitted: onSubmitted,
    );
  }
}
