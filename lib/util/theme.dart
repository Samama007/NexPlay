import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFF1D3B2),
      secondary: Color(0xFF46211A),
      tertiary: Color(0xFFA43820),
    ),
    scaffoldBackgroundColor: const Color(0xFFF1D3B2),
    fontFamily: 'ProzaLibre',
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: Color(0xFF46211A),
      cursorColor: Color(0xFF46211A),
    ));

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFF46211A),
      primary: Color(0xFF46211A),
      secondary: Color(0xFFF1D3B2),
      tertiary: Color(0xFFA43820),
    ),
    scaffoldBackgroundColor: const Color(0xFF46211A),
    fontFamily: 'ProzaLibre',
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: const Color(0xFFF1D3B2),
    ));


// const backgroundColor = Color(0xFFF1D3B2);
// const foregroundColor = Color(0xFF46211A);
// const tertiaryColor = Color(0xFFA43820);
