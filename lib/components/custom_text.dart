import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    this.style,
    this.maxLines = 3,
    this.overflow = TextOverflow.ellipsis,
    super.key,
  });

  final String? text;
  final TextStyle? style;
  final int maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: style,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
