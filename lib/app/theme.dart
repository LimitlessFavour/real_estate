import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFFFFA726);
  static const Color secondaryColor = Color(0xFFA5957E);
  static const Color backgroundColor = Color(0xFFFFF3E0);
  static const Color fontColor = Color(0xFF232220);


  // Typography
  static const TextTheme textTheme = TextTheme(
    //displayLarge: GoogleFonts.inter(
    //   fontSize: 32,
    //   fontWeight: FontWeight.bold,
    //   color: primaryColor,
    // ),
    displayLarge: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 16,
      color: primaryColor,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: primaryColor,
    ),
  );

  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: backgroundColor,
      tertiary: fontColor, // Add accent color here
    ),
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryColor),
    ),
  );
}
