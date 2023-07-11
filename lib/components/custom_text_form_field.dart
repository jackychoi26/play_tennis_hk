import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    required this.textInputType,
    required this.labelText,
    this.onChanged,
    this.enabled = true,
    this.validator,
    this.hintText = "",
    this.maxLines = 1,
    this.borderColor = Colors.teal,
    this.isPassword = false,
    super.key,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final String? labelText;

  final Function(String)? onChanged;
  final Function(dynamic)? validator;
  final bool enabled;
  final int maxLines;
  final Color borderColor;
  final bool isPassword;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        onChanged: onChanged,
        enabled: enabled,
        maxLines: maxLines,
        obscureText: isPassword,
        enableSuggestions: !isPassword,
        autocorrect: !isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          hintText: hintText,
        ),
        controller: controller,
        keyboardType: textInputType,
      ),
    );
  }
}
