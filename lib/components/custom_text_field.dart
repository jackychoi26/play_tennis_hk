import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.textInputType,
    required this.labelText,
    required this.hintText,
    this.maxLines = 1,
    this.borderColor = Colors.teal,
    super.key,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final String? labelText;
  final String? hintText;

  final int maxLines;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          hintText: hintText,
        ),
        controller: controller,
        //
        keyboardType: textInputType,
      ),
    );
  }
}
