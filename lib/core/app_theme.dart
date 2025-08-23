import 'package:flutter/material.dart';

class AppTheme {
  static const Color lightPrimary = Color(0xFF3F51B5);
  static const Color lightPrimaryVariant = Color(0xFF303F9F);
  static const Color lightSecondary = Color(0xFF7986CB);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF212121);

  static const Color darkPrimary = Color(0xFF303F9F); // Indigo[800]
  static const Color darkSecondary = Color(0xFF03DAC6); // Teal accent
  static const Color darkBackground = Color(
    0xFF121212,
  ); // Typical dark mode background
  static const Color darkSurface = Color(0xFF1E1E1E); // Cards, AppBars, etc.
  static const Color darkOnPrimary = Color(0xFFFFFFFF); // White for contrast
  static const Color darkOnSecondary = Color(
    0xFF000000,
  ); // Black on light accents
  static const Color darkOnBackground = Color(0xFFE0E0E0); // Light grey text
  static const Color darkOnSurface = Color(0xFFCCCCCC); // Slightly dimmed text

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBackground,
    fontFamily: 'Quicksand',
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: lightOnBackground,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: lightOnBackground,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: lightOnBackground,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: lightOnBackground,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 14,
        color: lightOnBackground,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: lightOnBackground,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: lightPrimary,
      secondary: lightSecondary,
      surface: lightSurface,
      onPrimary: lightOnPrimary,
      onSurface: lightOnBackground,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 204, 209, 242),
      foregroundColor: lightOnPrimary,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
        foregroundColor: lightOnPrimary,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBackground,
    fontFamily: 'Quicksand',
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: darkOnBackground,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: darkOnBackground,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: darkOnBackground,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: darkOnSurface,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 14,
        color: darkOnSurface,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 12,
        color: darkOnSurface,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: darkPrimary,
      secondary: darkSecondary,
      surface: darkSurface,
      onPrimary: darkOnPrimary,
      onSecondary: darkOnSecondary,
      onSurface: darkOnSurface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: darkOnPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPrimary,
        foregroundColor: darkOnPrimary,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    cardColor: darkSurface,
    iconTheme: const IconThemeData(color: darkOnSurface),
    dividerColor: Colors.grey[700],
    dialogTheme: DialogThemeData(backgroundColor: darkSurface),
  );
}
