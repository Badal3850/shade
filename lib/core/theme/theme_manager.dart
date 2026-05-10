import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'styles/classic_theme.dart';
import 'styles/mochi_theme.dart';
import 'styles/petl_theme.dart';

class ThemeManager extends ChangeNotifier {
  static const _styleKey = 'theme_style';
  static const _modeKey = 'theme_mode';

  final SharedPreferences? _prefs;

  ThemeStyle _currentStyle = ThemeStyle.classic;
  ThemeMode _currentMode = ThemeMode.system;

  ThemeManager([this._prefs]);

  ThemeStyle get currentStyle => _currentStyle;
  ThemeMode get currentMode => _currentMode;

  ThemeData get lightTheme => _resolve(Brightness.light);
  ThemeData get darkTheme => _resolve(Brightness.dark);

  ThemeData _resolve(Brightness brightness) {
    return switch (_currentStyle) {
      ThemeStyle.classic => brightness == Brightness.light
          ? ClassicTheme.light
          : ClassicTheme.dark,
      ThemeStyle.petlExe => brightness == Brightness.light
          ? PetlTheme.light
          : PetlTheme.dark,
      ThemeStyle.mochi => brightness == Brightness.light
          ? MochiTheme.light
          : MochiTheme.dark,
    };
  }

  Future<void> initialize() async {
    if (_prefs == null) return;
    final styleStr = _prefs.getString(_styleKey);
    if (styleStr != null) {
      _currentStyle = ThemeStyle.values.firstWhere(
        (e) => e.name == styleStr,
        orElse: () => ThemeStyle.classic,
      );
    }
    final modeIndex = _prefs.getInt(_modeKey);
    if (modeIndex != null && modeIndex < ThemeMode.values.length) {
      _currentMode = ThemeMode.values[modeIndex];
    }
  }

  Future<void> setStyle(ThemeStyle style) async {
    if (style == _currentStyle) return;
    _currentStyle = style;
    await _prefs?.setString(_styleKey, style.name);
    notifyListeners();
  }

  Future<void> setMode(ThemeMode mode) async {
    if (mode == _currentMode) return;
    _currentMode = mode;
    await _prefs?.setInt(_modeKey, mode.index);
    notifyListeners();
  }
}

enum ThemeStyle {
  classic('Classic'),
  petlExe('PETL.EXE'),
  mochi('Mochi');

  final String label;
  const ThemeStyle(this.label);
}
