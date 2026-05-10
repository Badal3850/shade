import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme_extensions.dart';

class PaperTheme {
  PaperTheme._();

  static const _bg = Color(0xFFF5F0E8);
  static const _surface = Color(0xFFEBE4D8);
  static const _sienna = Color(0xFF8B4513);
  static const _ink = Color(0xFF2A1F0F);
  static const _muted = Color(0xFF7A6A56);

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: _sienna,
      onPrimary: _bg,
      secondary: _muted,
      onSecondary: _bg,
      surface: _bg,
      onSurface: _ink,
      surfaceContainerHighest: _surface,
    ),
    scaffoldBackgroundColor: _bg,
    textTheme: GoogleFonts.playfairDisplayTextTheme(const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
      headlineMedium: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    )).apply(
      bodyColor: _ink,
      displayColor: _sienna,
    ),
    extensions: [
      const PaperExtras(
        inkColor: _ink,
        parchmentColor: _bg,
        siennaAccent: _sienna,
        pageMargin: 24.0,
      ),
    ],
  );

  static final ThemeData dark = light; // Paper is primarily a light theme
}
