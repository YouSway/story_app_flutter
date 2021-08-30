import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color fontBlack = Color(0xDE000000);
  static const Color logoBlue = Color(0xFF245f97);
  static const Color textFieldBackground = Color(0x1E000000);
  static const Color hintColor = Color(0x99000000);
  static const Color statusBarColor = Color(0x1e000000);
  static const Color radioButtonColor = Color(0xFFA77FFF);
  static const Color textFieldBackgroundBlack = Color(0x10000000);
}

class CustomTheme {
  static ThemeData mainTheme = ThemeData(
    // Default brightness and colors.
    brightness: Brightness.light,
    primaryColor: CustomColor.logoBlue,
    accentColor: Colors.cyan[600],

    // Default font family.
    fontFamily: 'Roboto',

    // Default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and etc.
    textTheme: TextTheme(
      headline: GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 38.0,
        letterSpacing: 1.0,
      ),
      title: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 25.0,
      ),
      body1: GoogleFonts.pTSans(
        color: Colors.white70,
        fontSize: 20.0,
      ),
      body2: GoogleFonts.roboto(
        fontSize: 16.0,
        color: Colors.white,
      ),
      button: TextStyle(
        color: CustomColor.white,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 2,
      ),
    ),
  );
}
