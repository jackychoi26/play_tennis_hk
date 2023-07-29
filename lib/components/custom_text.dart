import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    this.textType = CustomTextType.content,
    this.style,
    this.textColor,
    this.fontWeight,
    this.maxLines = 3,
    this.overflow = TextOverflow.ellipsis,
    super.key,
  });

  final String? text;
  final CustomTextType textType;
  final TextStyle? style;
  final Color? textColor;
  final FontWeight? fontWeight;
  final int maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: textType.toTextStyle(
        textColor: textColor,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

enum CustomTextType {
  title,
  subtitle,
  content,
  subContent,
}

extension CustomTextTypeStyle on CustomTextType {
  TextStyle toTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
  }) {
    getColor() {
      const defaultColor = Colors.black;
      return textColor ?? defaultColor;
    }

    getFontWeight() {
      const defaultFontWeight = FontWeight.normal;
      return fontWeight ?? defaultFontWeight;
    }

    switch (this) {
      case CustomTextType.title:
        return GoogleFonts.notoSans(
          fontSize: 28,
          color: getColor(),
          fontWeight: getFontWeight(),
        );
      case CustomTextType.subtitle:
        return GoogleFonts.notoSans(
          fontSize: 20,
          color: getColor(),
          fontWeight: getFontWeight(),
        );
      case CustomTextType.content:
        return GoogleFonts.notoSans(
          fontSize: 16,
          color: getColor(),
          fontWeight: getFontWeight(),
        );
      case CustomTextType.subContent:
        return GoogleFonts.notoSans(
          fontSize: 14,
          color: getColor(),
          fontWeight: getFontWeight(),
        );
    }
  }
}
