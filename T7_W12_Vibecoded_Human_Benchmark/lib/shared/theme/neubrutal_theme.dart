import 'package:flutter/material.dart';

class NeubrutalTheme {
  static const Color ink = Color(0xFF101010);
  static const Color canvas = Color(0xFFFFF4E5);
  static const Color accent = Color(0xFFFFB703);
  static const Color accentTwo = Color(0xFF90E0EF);
  static const Color accentThree = Color(0xFFEF476F);
  static const Color card = Color(0xFFFFFFFF);

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: canvas,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: Brightness.light,
      ).copyWith(
        primary: accent,
        secondary: accentTwo,
        error: accentThree,
        surface: card,
        onSurface: ink,
        onPrimary: ink,
        onSecondary: ink,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: canvas,
        foregroundColor: ink,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          color: ink,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: ink,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: ink,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ink,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ink,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: ink,
        ),
      ),
    );
  }

  static BoxDecoration cardDecoration({Color? color}) {
    return BoxDecoration(
      color: color ?? card,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: ink, width: 2),
      boxShadow: const [
        BoxShadow(
          color: ink,
          offset: Offset(4, 4),
          blurRadius: 0,
        ),
      ],
    );
  }
}
