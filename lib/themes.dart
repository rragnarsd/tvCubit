import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static const _primaryColor = Color(0xff211F1C);
  static const _secondaryColor = Color(0xff605C56);

  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: _primaryColor,
      secondary: _secondaryColor,
    ),
    iconTheme: const IconThemeData(
      color: _secondaryColor,
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.lato(
        fontSize: 32.0,
      ),
      headline2: GoogleFonts.lato(
        fontSize: 30.0,
      ),
      headline3: GoogleFonts.lato(
        fontSize: 24.0,
      ),
      headline4: GoogleFonts.lato(
        fontSize: 20.0,
      ),
      headline5: GoogleFonts.lato(
        fontSize: 18.0,
      ),
      headline6: GoogleFonts.lato(
        fontSize: 16.0,
      ),
      bodyText2: GoogleFonts.lato(
        fontSize: 14.0,
      ),
      bodyText1: GoogleFonts.lato(
        fontSize: 12.0,
      ),
    ),
    scaffoldBackgroundColor: const Color(0xff605C56),
  );
}
