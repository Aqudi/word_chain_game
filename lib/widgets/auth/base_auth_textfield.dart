import 'package:flutter/material.dart';
import 'package:wordchaingame/validator.dart';

class BaseAuthTextField extends StatelessWidget {
  final TextStyle textStyle;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;
  final Icon prefixIcon;
  final Function validator;
  final Function onEditingComplete;

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
      onSaved: (value) => controller
        ..text = value.trim(),
      validator: Validator.validatePassword,
      onEditingComplete: onEditingComplete,
    );
  }
}
