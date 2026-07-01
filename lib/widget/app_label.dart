import 'package:coupon/widget/app_text_style.dart';
import 'package:flutter/material.dart';

class AppLabel extends StatelessWidget {
  final String text;
  final String fontFamily;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double lineHeight;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final Color decorationColor;
  final TextOverflow overflow;
  final int? maxLines;
  final double? letterSpacing;
  final TextDecoration decoration;

  const AppLabel({
    super.key,
    required this.text,
    required this.fontSize,
    this.color = const Color(0xff000000),
    this.fontWeight = FontWeight.normal,
    this.lineHeight = 1.3,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none,
    this.decorationColor = const Color(0xff000000),
    this.overflow = TextOverflow.fade,
    this.maxLines,
    this.fontFamily = "Poppins",
    this.letterSpacing = 0.0,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: AppTextStyle().textSizeS(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        lineHeight: lineHeight,
        decoration: textDecoration,
        decorationColor: decorationColor,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
