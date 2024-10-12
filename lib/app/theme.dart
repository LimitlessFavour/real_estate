import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFFFFA726);
  static const Color secondaryColor = Color(0xFFA5957E);
  static const Color backgroundColor = Color(0xFFFFF3E0);
  static const Color fontColor = Color(0xFF232220);
  static const Color grey = Color(0xff747474);

  // Typography
  static final TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 28.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: primaryColor,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      // color: Colors.red,
      color: secondaryColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 16.sp,
      color: primaryColor,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: primaryColor,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Euclid Circular A',
      fontSize: 10.sp,
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
