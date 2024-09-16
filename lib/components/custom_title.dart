import 'package:flutter/material.dart';

import '../utilities/constants.dart';


class CustomTitle extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final int? maxLines;
  final double? wordSpacing;
  final TextOverflow? overflow;
  final TextDirection? textDirection;

  const CustomTitle(
      {super.key,
      required this.text,
      this.color,
      required this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.decoration = TextDecoration.none,
      this.maxLines,
      this.overflow,
      this.wordSpacing,
      this.decorationColor, this.textDirection});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: textDirection,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: decoration,
          decorationColor: decorationColor,
          wordSpacing: wordSpacing,
          color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
