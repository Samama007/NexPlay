import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  // Primary colors
  primaryColor: const Color(0xFF6C63FF),
  hintColor: const Color(0xFFF57C00),
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  canvasColor: const Color(0xFFFFFFFF),

  // AppBar theme
  appBarTheme: AppBarTheme(
    color: const Color(0xFF6C63FF),
    elevation: 4.0,
    iconTheme: const IconThemeData(color: Colors.white),
    toolbarTextStyle: TextTheme(
      titleLarge: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ).bodyMedium,
    titleTextStyle: TextTheme(
      titleLarge: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ).titleLarge,
  ),

  // Button theme
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFF6C63FF),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  // Elevated button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFF6C63FF),
      backgroundColor: Colors.white,
      textStyle: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
    ),
  ),

  // Text theme
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      color: const Color(0xFF333333),
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.montserrat(
      color: const Color(0xFF333333),
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.lato(
      color: const Color(0xFF666666),
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.lato(
      color: const Color(0xFF888888),
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.lato(
      color: const Color(0xFFAAAAAA),
      fontSize: 12,
    ),
    labelLarge: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),

  // Icon theme
  iconTheme: const IconThemeData(
    color: Color(0xFF6C63FF),
    size: 24,
  ),

  // Card theme
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),

  // Input decoration theme (for TextFields)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF0F0F0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Color(0xFF6C63FF)),
    ),
    hintStyle: GoogleFonts.lato(
      color: const Color(0xFFAAAAAA),
      fontSize: 16,
    ),
  ),

  // FloatingActionButton theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFF57C00),
    foregroundColor: Colors.white,
    elevation: 4.0,
  ),

  // SnackBar theme
  snackBarTheme: SnackBarThemeData(
    backgroundColor: const Color(0xFF333333),
    contentTextStyle: GoogleFonts.lato(
      color: Colors.white,
      fontSize: 16,
    ),
    actionTextColor: const Color(0xFFF57C00),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
