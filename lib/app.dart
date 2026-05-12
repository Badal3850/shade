import 'package:flutter/material.dart';
import 'core/di/injection_container.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/theme_manager.dart';

import 'package:provider/provider.dart';

import 'package:shade/features/pet/presentation/providers/pet_state_provider.dart';
import 'package:shade/features/onboarding/pet_name_manager.dart';

class ShadeApp extends StatefulWidget {
  final ThemeManager? themeManager;

  const ShadeApp({super.key, this.themeManager});

  @override
  State<ShadeApp> createState() => _ShadeAppState();
}

class _ShadeAppState extends State<ShadeApp> {
  late final ThemeManager _themeManager;
  late final PetStateProvider _petProvider;

  @override
  void initState() {
    super.initState();
    _themeManager = widget.themeManager ?? sl<ThemeManager>();
    _petProvider = sl<PetStateProvider>();
    _themeManager.addListener(_onThemeChanged);
    _petProvider.initialize();
  }

  @override
  void dispose() {
    _themeManager.removeListener(_onThemeChanged);
    _petProvider.recordClose();
    super.dispose();
  }

  void _onThemeChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeManager>.value(value: _themeManager),
        ChangeNotifierProvider<PetStateProvider>.value(value: _petProvider),
        ChangeNotifierProvider<PetNameManager>.value(value: sl<PetNameManager>()),
      ],
      child: MaterialApp(
        title: 'shade',
        debugShowCheckedModeBanner: false,
        theme: _themeManager.lightTheme,
        darkTheme: _themeManager.darkTheme,
        themeMode: _themeManager.currentMode,
        initialRoute: AppRouter.initialRoute(),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
