import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(this.text, {super.key});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(text ?? "");
  }
}
