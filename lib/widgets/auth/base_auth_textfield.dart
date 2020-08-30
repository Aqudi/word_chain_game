import 'package:flutter/material.dart';

class BaseAuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  final TextStyle textStyle;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  final bool obscureText;
  final String hintText;
  final Icon prefixIcon;

  final FormFieldValidator<String> validator;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;

  const BaseAuthTextField({
    Key key,
    this.textStyle,
    this.textInputAction,
    this.prefixIcon,
    this.hintText,
    this.controller,
    this.validator,
    this.onEditingComplete,
    this.keyboardType,
    this.obscureText,
    this.focusNode,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,
      maxLines: 1,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autocorrect: false,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: controller,
      onSaved: (value) => controller..text = value.trim(),
      validator: validator,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode ?? null,
    );
  }
}
