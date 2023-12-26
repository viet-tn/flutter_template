import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../constants/ui/ui.dart';
import '../../utils/extensions/materials/build_context.dart';

class XTextFormField extends StatefulWidget {
  const XTextFormField({
    required this.name,
    super.key,
    this.formKey,
    this.labelText,
    this.onFocusChanged,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.valueTransformer,
    this.enabled = true,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onReset,
    this.restorationId,
    this.initialValue,
    this.readOnly = false,
    this.maxLines = 1,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20),
    this.enableInteractiveSelection = true,
    this.maxLengthEnforcement,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = false,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.keyboardType,
    this.style,
    this.textInputAction = TextInputAction.next,
    this.strutStyle,
    this.textDirection,
    this.maxLength,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.buildCounter,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.onTap,
    this.onTapOutside,
    this.enableSuggestions = true,
    this.validator,
    this.textAlignVertical,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollController,
    this.scrollPhysics,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.smartDashesType,
    this.smartQuotesType,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.autofillHints,
    this.obscuringCharacter = '•',
    this.mouseCursor,
    this.contextMenuBuilder,
    this.magnifierConfiguration,
    this.contentInsertionConfiguration,
    this.isFieldRequired = false,
    this.contentPadding,
    this.hintStyle,
  });

  final GlobalKey<FormBuilderState>? formKey;
  final String name;
  final bool isFieldRequired;
  final String? labelText;
  final void Function({required bool hasFocus})? onFocusChanged;
  final String? Function(String?)? validator;
  final InputDecoration decoration;
  final void Function(String value)? onChanged;
  final void Function(String?)? valueTransformer;
  final bool enabled;
  final void Function(String?)? onSaved;
  final AutovalidateMode? autovalidateMode;
  final void Function()? onReset;
  final String? restorationId;
  final String? initialValue;
  final bool readOnly;
  final int? maxLines;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final double cursorWidth;
  final double? cursorHeight;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final TextInputAction textInputAction;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final int? maxLength;
  final void Function()? onEditingComplete;
  final void Function(String?)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final Widget? Function(
    BuildContext, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  })? buildCounter;
  final bool expands;
  final int? minLines;
  final bool? showCursor;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool enableSuggestions;
  final TextAlignVertical? textAlignVertical;
  final DragStartBehavior dragStartBehavior;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final BoxWidthStyle selectionWidthStyle;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final BoxHeightStyle selectionHeightStyle;
  final Iterable<String>? autofillHints;
  final String obscuringCharacter;
  final MouseCursor? mouseCursor;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EdgeInsets? contentPadding;
  final TextStyle? hintStyle;

  @override
  State<XTextFormField> createState() => _XTextFormFieldState();
}

class _XTextFormFieldState extends State<XTextFormField> {
  late final TextEditingController _controller;
  late FocusNode _focusNode;
  String get text => _controller.text;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_focusListener);
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(_controllerListener);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_focusListener)
      ..dispose();
    _controller
      ..removeListener(_controllerListener)
      ..dispose();
    super.dispose();
  }

  void _focusListener() {
    widget.onFocusChanged?.call(hasFocus: _focusNode.hasFocus);

    // * Field validation on focus changed
    if (!_focusNode.hasPrimaryFocus) {
      widget.formKey?.currentState?.fields[widget.name]
          ?.validate(focusOnInvalid: false);
    }
  }

  void _controllerListener() {
    widget.onChanged?.call(text);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: _controller,
      focusNode: _focusNode,
      name: widget.name,
      decoration: widget.decoration.copyWith(
        contentPadding: widget.contentPadding ?? CGaps.contentPadding,
        hintStyle: widget.hintStyle ?? context.text.bodyMedium,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.labelText ?? ''),
            if (widget.isFieldRequired) ...[
              const Text(
                ' *',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
        suffixIcon: ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, value, child) {
            return value.text.isEmpty ? const SizedBox.shrink() : child!;
          },
          child: IconButton(
            onPressed: () {
              _controller.clear();
              _focusNode.requestFocus();
            },
            icon: const Icon(Icons.clear),
          ),
        ),
      ),
      valueTransformer: widget.valueTransformer,
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      autovalidateMode: widget.autovalidateMode,
      onReset: widget.onReset,
      restorationId: widget.restorationId,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      obscureText: widget.obscureText,
      textCapitalization: widget.textCapitalization,
      scrollPadding: widget.scrollPadding,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      textAlign: widget.textAlign,
      autofocus: widget.autofocus,
      autocorrect: widget.autocorrect,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      keyboardType: widget.keyboardType,
      style: widget.style,
      textInputAction: widget.textInputAction,
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      maxLength: widget.maxLength,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      keyboardAppearance: widget.keyboardAppearance,
      buildCounter: widget.buildCounter,
      expands: widget.expands,
      minLines: widget.minLines,
      showCursor: widget.showCursor,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      enableSuggestions: widget.enableSuggestions,
      validator: widget.validator,
      textAlignVertical: widget.textAlignVertical,
      dragStartBehavior: widget.dragStartBehavior,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      selectionWidthStyle: widget.selectionWidthStyle,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      selectionHeightStyle: widget.selectionHeightStyle,
      autofillHints: widget.autofillHints,
      obscuringCharacter: widget.obscuringCharacter,
      mouseCursor: widget.mouseCursor,
      contextMenuBuilder: widget.contextMenuBuilder,
      magnifierConfiguration: widget.magnifierConfiguration,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
    );
  }
}
