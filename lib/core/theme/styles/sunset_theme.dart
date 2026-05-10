import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme_extensions.dart';

class SunsetTheme {
  SunsetTheme._();

  static const _bg = Color(0xFF130800);
  static const _surface = Color(0xFF1C0E02);
  static const _amber = Color(0xFFFBBF24);
  static const _orange = Color(0xFFFF6B35);
  static const _text = Color(0xFFFFE0C8);

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: _orange,
      onPrimary: _bg,
      secondary: _amber,
      onSecondary: _bg,
      surface: _surface,
      onSurface: _text,
      surfaceContainerHighest: const Color(0xFF2D1605),
    ),
    scaffoldBackgroundColor: _bg,
    textTheme: GoogleFonts.bebasNeueTextTheme(const TextTheme(
      displayLarge: TextStyle(fontSize: 40, letterSpacing: 1.2),
      headlineMedium: TextStyle(fontSize: 24, letterSpacing: 1.0),
      titleLarge: TextStyle(fontSize: 18, letterSpacing: 0.8),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    )).apply(
      bodyColor: _text,
      displayColor: _orange,
    ),
    extensions: [
      const SunsetExtras(
        emberColor: _amber,
        flameColor: _orange,
        sharpRadius: 4.0,
      ),
    ],
  );

  static final ThemeData light = dark; // Sunset is primarily a dark theme
}
