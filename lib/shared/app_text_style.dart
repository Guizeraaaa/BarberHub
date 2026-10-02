import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle tittle = TextStyle(
    fontSize: 24,
    fontFamily: 'Barlow',
    fontWeight: FontWeight.bold,
  );
  static TextStyle subTittle = TextStyle(
    fontSize: 16,
    fontFamily: 'Barlow',
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyHome = GoogleFonts.robotoCondensed(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static TextStyle body = TextStyle(fontSize: 12, fontFamily: 'Barlow');
  static TextStyle bodySmall = TextStyle(fontSize: 8, fontFamily: 'Barlow');
}
