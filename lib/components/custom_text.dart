import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    this.textType = CustomTextType.content,
    this.style,
    this.maxLines = 3,
    this.overflow = TextOverflow.ellipsis,
    super.key,
  });

  final String? text;
  final CustomTextType textType;
  final TextStyle? style;
  final int maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: textType.toTextStyle(),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

enum CustomTextType { title, subtitle, content }

extension CustomTextTypeStyle on CustomTextType {
  TextStyle toTextStyle() {
    switch (this) {
      case CustomTextType.title:
        return GoogleFonts.notoSans(fontSize: 28);
      case CustomTextType.subtitle:
        return GoogleFonts.notoSans(fontSize: 20);
      case CustomTextType.content:
        return GoogleFonts.notoSans(fontSize: 16);
    }
  }
}
