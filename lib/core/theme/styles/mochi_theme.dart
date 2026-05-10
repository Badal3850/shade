import 'package:flutter/material.dart';

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
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'serif',
        fontSize: 32,
        color: _text,
        fontStyle: FontStyle.italic,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'serif',
        fontSize: 20,
        color: _text,
        fontStyle: FontStyle.italic,
      ),
      titleLarge: TextStyle(
        fontFamily: 'sans-serif',
        fontSize: 13,
        color: _text,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.05,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'serif',
        fontSize: 17,
        color: _text,
        fontStyle: FontStyle.italic,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'sans-serif',
        fontSize: 12,
        color: _textDim,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        fontFamily: 'sans-serif',
        fontSize: 9,
        color: _textDim,
        letterSpacing: 0.06,
      ),
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

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF7c6ba0),
      onPrimary: Colors.white,
      secondary: const Color(0xFFd4879b),
      onSecondary: Colors.white,
      tertiary: const Color(0xFF6bb599),
      surface: const Color(0xFFfaf5f0),
      onSurface: const Color(0xFF2a2438),
      surfaceContainerHighest: const Color(0xFFf0ebe5),
      outline: const Color(0x1a2a2438),
    ),
    scaffoldBackgroundColor: const Color(0xFFfaf5f0),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'serif',
        fontSize: 32,
        color: Color(0xFF2a2438),
        fontStyle: FontStyle.italic,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'serif',
        fontSize: 20,
        color: Color(0xFF2a2438),
        fontStyle: FontStyle.italic,
      ),
      titleLarge: TextStyle(
        fontFamily: 'sans-serif',
        fontSize: 13,
        color: Color(0xFF2a2438),
        fontWeight: FontWeight.w700,
        letterSpacing: 0.05,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'serif',
        fontSize: 17,
        color: Color(0xFF2a2438),
        fontStyle: FontStyle.italic,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'sans-serif',
        fontSize: 12,
        color: Color(0x8A2a2438),
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        fontFamily: 'sans-serif',
        fontSize: 9,
        color: Color(0x612a2438),
        letterSpacing: 0.06,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(color: const Color(0x1a2a2438)),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: const Color(0x1a2a2438),
      thickness: 1,
    ),
    extensions: [
      MochiExtras(
        ambientGlowColors: [
          const Color(0xFFc4b5fd).withValues(alpha: 0.08),
          const Color(0xFFf4a0b5).withValues(alpha: 0.06),
        ],
        ambientBlurRadius: 80,
        glassBlurIntensity: 12,
        glassOpacity: 0.03,
        glassBorderOpacity: 0.06,
        glassHighlightColor: Colors.white.withValues(alpha: 0.4),
      ),
    ],
  );
}
