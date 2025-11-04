import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../utils/extensions/build_context_extension.dart';
import 'label.dart';

class XTextFormField extends StatefulWidget {
  const XTextFormField({
    super.key,
    required this.name,
    this.isRequired = true,
    this.obscureText = false,
    this.autofocus = false,
    required this.labelText,
    this.helperText,
    this.hintText,
    this.validator,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.keyboardType,
    this.autofillHints,
    this.onSubmitted,
  });

  final String name;
  final bool isRequired;
  final bool obscureText;
  final bool autofocus;
  final String labelText;
  final String? helperText;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final void Function(String?)? onSubmitted;

  @override
  State<XTextFormField> createState() => _XTextFormFieldState();
}

class _XTextFormFieldState extends State<XTextFormField> {
  final ValueNotifier<String?> text = ValueNotifier<String?>(null);
  late final ValueNotifier<bool> isObscured;
  final textFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  void initState() {
    super.initState();
    isObscured = ValueNotifier(widget.obscureText);
  }

  @override
  void dispose() {
    text.dispose();
    isObscured.dispose();
    super.dispose();
  }

  void _toggleIsObscuring() {
    isObscured.value = !isObscured.value;
  }

  @override
  Widget build(BuildContext context) {
    Widget suffixIcon(isObscured) => ExcludeFocus(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.obscureText
              ? isObscured
                    ? IconButton(
                        onPressed: _toggleIsObscuring,
                        icon: const Icon(Icons.visibility_off_outlined),
                      )
                    : IconButton(
                        onPressed: _toggleIsObscuring,
                        icon: const Icon(Icons.visibility_outlined),
                      )
              : ValueListenableBuilder<String?>(
                  valueListenable: text,
                  child: IconButton(
                    onPressed: () => textFieldKey.currentState?.didChange(null),
                    tooltip: 'Clear',
                    icon: const Icon(Icons.clear),
                  ),
                  builder: (context, value, child) =>
                      (value?.isEmpty ?? true) ? const SizedBox() : child!,
                ),
        ],
      ),
    );

    return ValueListenableBuilder<bool>(
      valueListenable: isObscured,
      builder: (context, value, child) {
        return FormBuilderTextField(
          name: widget.name,
          key: textFieldKey,
          onChanged: (value) {
            text.value = value;
          },
          decoration: InputDecoration(
            label: XLabel(
              label: widget.labelText,
              isRequired: widget.isRequired,
            ),
            helper: widget.helperText != null
                ? Text(
                    widget.helperText!,
                    maxLines: 3,
                    style: context.text.labelMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : null,
            hintText: widget.hintText,
            suffixIcon: suffixIcon(value),
          ),
          validator: FormBuilderValidators.compose([
            ?widget.validator,
            if (widget.isRequired)
              FormBuilderValidators.required(
                errorText: 'Vui lòng nhập ${widget.labelText}',
              ),
          ]),
          errorBuilder: (context, errorText) => Text(
            errorText,
            maxLines: 3,
            style: context.text.labelMedium?.copyWith(
              color: context.color.error,
            ),
          ),
          obscureText: value,
          autofocus: widget.autofocus,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          textCapitalization: widget.textCapitalization,
          inputFormatters: widget.inputFormatters,
          autocorrect: false,
          keyboardType: widget.keyboardType,
          autofillHints: widget.autofillHints,
          onSubmitted: widget.onSubmitted,
        );
      },
    );
  }
}
