import 'package:flutter/material.dart';

extension StyledTextExtension on String {
  Text styledText({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    TextAlign? textAlign,
  }) {
    return Text(
      this,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  // Helper for size e.g., "ali".size(24)
  _TextStyleBuilder get size => _TextStyleBuilder(this);
}

class _TextStyleBuilder {
  final String text;
  double _fontSize = 14;

  _TextStyleBuilder(this.text);

  _TextStyleBuilder call(double size) {
    _fontSize = size;
    return this;
  }

  Text w100() => _build(FontWeight.w100);
  Text w200() => _build(FontWeight.w200);
  Text w300() => _build(FontWeight.w300);
  Text w400() => _build(FontWeight.w400);
  Text w500() => _build(FontWeight.w500);
  Text w600() => _build(FontWeight.w600);
  Text w700() => _build(FontWeight.w700);
  Text w800() => _build(FontWeight.w800);
  Text w900() => _build(FontWeight.w900);

  Text _build(FontWeight weight) {
    return Text(
      text,
      style: TextStyle(fontSize: _fontSize, fontWeight: weight),
    );
  }
}
