import 'package:flutter/material.dart';
import 'core/di/injection_container.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/theme_manager.dart';

import 'package:provider/provider.dart';

class ShadeApp extends StatefulWidget {
  final ThemeManager? themeManager;

  const ShadeApp({super.key, this.themeManager});

  @override
  State<ShadeApp> createState() => _ShadeAppState();
}

class _ShadeAppState extends State<ShadeApp> {
  late final ThemeManager _themeManager;

  @override
  void initState() {
    super.initState();
    _themeManager = widget.themeManager ?? sl<ThemeManager>();
    _themeManager.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    _themeManager.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeManager>.value(
      value: _themeManager,
      child: MaterialApp(
        title: 'shade',
        debugShowCheckedModeBanner: false,
        theme: _themeManager.lightTheme,
        darkTheme: _themeManager.darkTheme,
        themeMode: _themeManager.currentMode,
        initialRoute: '/',
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
