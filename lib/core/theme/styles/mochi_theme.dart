import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_extensions.dart';

class MochiTheme {
  MochiTheme._();

  static const _bg = Color(0xFF0e0b14);
  static const _surface = Color(0xFF12101a);
  static const _text = Color(0xFFe8e0f0);
  static const _textDim = Color(0xB3e8e0f0);
  static const _rose = Color(0xFFf4a0b5);
  static const _lavender = Color(0xFFc4b5fd);
  static const _mint = Color(0xFF86efca);
  static const _border = Color(0x14ffffff);

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: _lavender,
      onPrimary: _bg,
      secondary: _rose,
      onSecondary: _bg,
      tertiary: _mint,
      surface: _surface,
      onSurface: _text,
      surfaceContainerHighest: const Color(0xFF1a1625),
      outline: _border,
    ),
    scaffoldBackgroundColor: _bg,
    textTheme: GoogleFonts.instrumentSerifTextTheme(const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontStyle: FontStyle.italic),
      headlineMedium: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      titleLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.05),
      bodyLarge: TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
      bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      labelSmall: TextStyle(fontSize: 9, letterSpacing: 0.06),
    )).apply(
      bodyColor: _textDim,
      displayColor: _text,
    ),
    cardTheme: CardThemeData(
      color: _surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(color: _border),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: _border,
      thickness: 1,
    ),
    extensions: [
      MochiExtras(
        ambientGlowColors: [
          _lavender.withValues(alpha: 0.12),
          _rose.withValues(alpha: 0.10),
        ],
        ambientBlurRadius: 80,
        glassBlurIntensity: 20,
        glassOpacity: 0.04,
        glassBorderOpacity: 0.08,
        glassHighlightColor: Colors.white.withValues(alpha: 0.06),
      ),
    ],
  );

  static final ThemeData light = dark;
}
