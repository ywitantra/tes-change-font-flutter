import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextStyle {
  String fontName;

  MyTextStyle({
    this.fontName = "Inter",
  });

  FontStyle fontStyle = FontStyle.normal;
  FontWeight bold700 = FontWeight.w700;
  FontWeight medium600 = FontWeight.w600;
  FontWeight regular400 = FontWeight.w400;

  late TextStyle _font16 = TextStyle(
      fontWeight: bold700,
      fontFamily: fontName,
      fontStyle: fontStyle,
      fontSize: 16.0
  );
  TextStyle get font16 => _font16;
  setMyFont(TextStyle newFontFamily) {
    print("called setMyFont");
    _font16 = _font16.copyWith(
      fontFamily: newFontFamily.fontFamily,
      color: Colors.blueAccent,
    );
  }
}