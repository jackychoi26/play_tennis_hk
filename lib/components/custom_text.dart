import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    this.textType = CustomTextType.content,
    this.style,
    this.textColor,
    this.maxLines = 3,
    this.overflow = TextOverflow.ellipsis,
    super.key,
  });

  final String? text;
  final CustomTextType textType;
  final TextStyle? style;
  final Color? textColor;
  final int maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: textType.toTextStyle(textColor: textColor),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

enum CustomTextType { title, subtitle, content }

extension CustomTextTypeStyle on CustomTextType {
  TextStyle toTextStyle({Color? textColor}) {
    getColor() {
      const defaultColor = Colors.black;
      return textColor == null ? textColor : defaultColor;
    }

    switch (this) {
      case CustomTextType.title:
        return GoogleFonts.notoSans(fontSize: 28, color: getColor());
      case CustomTextType.subtitle:
        return GoogleFonts.notoSans(fontSize: 20, color: getColor());
      case CustomTextType.content:
        return GoogleFonts.notoSans(fontSize: 16, color: getColor());
    }
  }
}
