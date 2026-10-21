import 'package:flutter/material.dart';

class AppTheme {
  static const Color verde = Color(0xFF315C45);
  static const Color terracota = Color(0xFFC66A4A);
  static const Color crema = Color(0xFFFAF7F0);
  static const Color tinta = Color(0xFF26352D);
  static const Color maiz = Color(0xFFE5B94B);
  static const Color turquesa = Color(0xFF3E9B98);
  static const Color bugambilia = Color(0xFFB64D73);

  static ThemeData get theme {
    final esquema = ColorScheme.fromSeed(
      seedColor: verde,
      brightness: Brightness.light,
    ).copyWith(
      primary: verde,
      secondary: terracota,
      tertiary: maiz,
      surface: Colors.white,
      primaryContainer: const Color(0xFFE4EEE6),
      secondaryContainer: const Color(0xFFF7E7DF),
      tertiaryContainer: const Color(0xFFFFF2CE),
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
          side: const BorderSide(color: Color(0xFFE9E3D7)),
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
