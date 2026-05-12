import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme_extensions.dart';

class ForestTheme {
  ForestTheme._();

  static const _bg = Color(0xFF0A1A0C);
  static const _surface = Color(0xFF122314);
  static const _mint = Color(0xFF86EFCA);
  static const _leaf = Color(0xFF4ADE80);
  static const _moss = Color(0xFF2D4C31);
  static const _text = Color(0xFFD4F0E0);

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: _leaf,
      onPrimary: _bg,
      secondary: _mint,
      onSecondary: _bg,
      tertiary: _moss,
      surface: _surface,
      onSurface: _text,
      surfaceContainerHighest: const Color(0xFF1A2E1D),
    ),
    scaffoldBackgroundColor: _bg,
    textTheme: GoogleFonts.playfairDisplayTextTheme(const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    )).apply(
      bodyColor: _text,
      displayColor: _leaf,
    ),
    extensions: [
      const ForestExtras(
        leafAccent: _leaf,
        mossColor: _moss,
      ),
    ],
  );

  static final ThemeData light = dark; // Forest is primarily a dark theme
}
