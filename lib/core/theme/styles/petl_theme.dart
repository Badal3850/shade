import 'package:flutter/material.dart';

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
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 22,
        color: _cyan,
        letterSpacing: 2,
      ),
      titleLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: _cyan,
        letterSpacing: 1,
      ),
      titleMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 8,
        color: _white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 9,
        color: _white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 7,
        color: _white,
      ),
      labelSmall: TextStyle(
        fontFamily: 'monospace',
        fontSize: 5,
        color: _yellow,
        letterSpacing: 0.5,
      ),
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

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: _cyan.withValues(alpha: 0.8),
      onPrimary: _black,
      secondary: _pink.withValues(alpha: 0.7),
      onSecondary: _black,
      tertiary: _yellow.withValues(alpha: 0.7),
      error: _orange,
      surface: const Color(0xFFf5f0e8),
      onSurface: const Color(0xFF1a1a2e),
      surfaceContainerHighest: const Color(0xFFe8e0d0),
    ),
    scaffoldBackgroundColor: const Color(0xFFf5f0e8),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 22,
        color: Color(0xFF1a1a2e),
        letterSpacing: 2,
      ),
      titleLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Color(0xFF1a1a2e),
        letterSpacing: 1,
      ),
      titleMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 8,
        color: Color(0xFF1a1a2e),
      ),
      bodyLarge: TextStyle(
        fontFamily: 'monospace',
        fontSize: 9,
        color: Color(0xFF1a1a2e),
      ),
      bodyMedium: TextStyle(
        fontFamily: 'monospace',
        fontSize: 7,
        color: Color(0xFF1a1a2e),
      ),
      labelSmall: TextStyle(
        fontFamily: 'monospace',
        fontSize: 5,
        color: Color(0xFF776040),
        letterSpacing: 0.5,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(2),
        side: BorderSide(color: _cyan.withValues(alpha: 0.2)),
      ),
      elevation: 0,
    ),
    dividerTheme: DividerThemeData(
      color: const Color(0xFF1a1a2e).withValues(alpha: 0.1),
      thickness: 1,
    ),
    extensions: [
      const PetlExtras(
        showScanlines: false,
        showPixelGrid: true,
        gridColor: Color(0x081a1a2e),
        scanlineColor: Color(0x00000000),
        glitchPrimary: _pink,
        glitchSecondary: _cyan,
      ),
    ],
  );
}
