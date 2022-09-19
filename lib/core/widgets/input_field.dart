import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? label;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final bool? enable;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final InputDecoration? inputDecoration;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsets? padding;
  const InputField({
    this.label,
    this.validator,
    this.controller,
    this.inputDecoration,
    this.enable = true,
    this.maxLines = 1,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.only(
            right: 22,
            left: 22,
            bottom: 20,
          ),
      child: TextFormField(
        controller: controller,
        decoration: inputDecoration ??
            InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              labelText: label,
              alignLabelWithHint: true,
            ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        obscureText: obscureText!,
        cursorColor: Theme.of(context).primaryColor,
        enabled: enable,
      ),
    );
  }
}
