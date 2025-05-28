import 'package:flutter/material.dart';

class AppTheme {
  // Common Colors
  static const primaryColor = Color(0xFF0066FF);
  static const secondaryColor = Color(0xFF00C896);
  static const dangerColor = Color(0xFFFF4B4B);
  static const successColor = Color(0xFF00C853);

  // Light Theme Specific Colors
  static const lightBackground = Color(0xFFF5F5F5);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightText = Color(0xFF212121);
  static const lightSubtitle = Color(0xFF757575);

  // Dark Theme Specific Colors
  static const darkBackground = Color(0xFF121212);
  static const darkCard = Color(0xFF1E1E1E);
  static const darkText = Color(0xFFE0E0E0);
  static const darkSubtitle = Color(0xFF9E9E9E);

  // Shared Border Radius
  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(12));

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackground,
    primaryColor: primaryColor,
    cardColor: lightCard,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: darkText,
      elevation: 1,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: lightText),
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: lightText),
      bodyLarge: TextStyle(fontSize: 16, color: lightText),
      bodyMedium: TextStyle(fontSize: 14, color: lightSubtitle),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: lightCard,
      border: OutlineInputBorder(borderRadius: borderRadius),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    primaryColor: primaryColor,
    cardColor: darkCard,
    appBarTheme: const AppBarTheme(
       backgroundColor: primaryColor,
      foregroundColor: darkText,
      elevation: 1,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: darkText),
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: darkText),
      bodyLarge: TextStyle(fontSize: 16, color: darkText),
      bodyMedium: TextStyle(fontSize: 14, color: darkSubtitle),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: darkCard,
      border: OutlineInputBorder(borderRadius: borderRadius),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
  );
}
