import 'package:flutter/material.dart';

class AppTheme {
  static const Color verde = Color(0xFF315C45);
  static const Color terracota = Color(0xFFC66A4A);
  static const Color crema = Color(0xFFFAF7F0);
  static const Color tinta = Color(0xFF26352D);

  static ThemeData get theme {
    final esquema = ColorScheme.fromSeed(
      seedColor: verde,
      brightness: Brightness.light,
    ).copyWith(
      primary: verde,
      secondary: terracota,
      surface: Colors.white,
      primaryContainer: const Color(0xFFE2EDE4),
      secondaryContainer: const Color(0xFFF6E4DA),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: esquema,
      scaffoldBackgroundColor: crema,
      textTheme: ThemeData.light().textTheme.apply(
        bodyColor: tinta,
        displayColor: tinta,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: crema,
        foregroundColor: tinta,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: tinta,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0.5,
        shadowColor: tinta.withValues(alpha: 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFFECE9E0)),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: verde,
          foregroundColor: Colors.white,
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: verde,
          minimumSize: const Size(0, 50),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          side: const BorderSide(color: Color(0xFFD5DED5)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE8E5DC)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE8E5DC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: verde, width: 1.5),
        ),
      ),
    );
  }
}
