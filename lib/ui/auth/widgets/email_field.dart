import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../core/ui/form/text_form_field.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return XTextFormField(
      name: 'email',
      labelText: 'Email',
      hintText: 'VD: ten@gmail.com',
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Vui lòng nhập Email'),
        FormBuilderValidators.email(
          errorText: 'Vui lòng nhập đúng định dạng. VD: ten@gmail.com',
        ),
      ]),
      autofillHints: [AutofillHints.username],
    );
  }
}
