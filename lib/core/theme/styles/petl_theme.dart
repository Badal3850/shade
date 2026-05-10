import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_extensions.dart';

class PetlTheme {
  PetlTheme._();

  static const _cyan = Color(0xFF00ffee);
  static const _pink = Color(0xFFff2d78);
  static const _yellow = Color(0xFFffee00);
  static const _orange = Color(0xFFff6b00);
  static const _black = Color(0xFF0a0a0f);
  static const _white = Color(0xFFf0f0ff);
  static const _surface = Color(0xFF0d0d1f);

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: _cyan,
      onPrimary: _black,
      secondary: _pink,
      onSecondary: _black,
      tertiary: _yellow,
      error: _orange,
      surface: _surface,
      onSurface: _white,
      surfaceContainerHighest: const Color(0xFF1a1a3e),
    ),
    scaffoldBackgroundColor: _black,
    textTheme: GoogleFonts.vt323TextTheme(const TextTheme(
      displayLarge: TextStyle(fontSize: 22, letterSpacing: 2),
      titleLarge: TextStyle(fontSize: 11, letterSpacing: 1),
      titleMedium: TextStyle(fontSize: 8),
      bodyLarge: TextStyle(fontSize: 9),
      bodyMedium: TextStyle(fontSize: 7),
      labelSmall: TextStyle(fontSize: 5, letterSpacing: 0.5),
    )).copyWith(
      displayLarge: GoogleFonts.pressStart2p(fontSize: 22, color: _cyan),
    ).apply(
      bodyColor: _white,
      displayColor: _cyan,
    ),
    cardTheme: CardThemeData(
      color: _surface,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(2),
        side: BorderSide(color: _cyan.withValues(alpha: 0.3)),
      ),
      elevation: 0,
    ),
    dividerTheme: DividerThemeData(
      color: _cyan.withValues(alpha: 0.15),
      thickness: 1,
    ),
    extensions: [
      const PetlExtras(
        showScanlines: true,
        showPixelGrid: true,
        gridColor: Color(0x0A00ffee),
        scanlineColor: Color(0x26000000),
        glitchPrimary: _pink,
        glitchSecondary: _cyan,
      ),
    ],
  );

  static final ThemeData light = dark;
}
