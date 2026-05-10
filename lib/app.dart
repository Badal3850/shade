import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

class ShadeApp extends StatelessWidget {
  const ShadeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shade',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return null;
      },
      home: const _AppHome(),
    );
  }
}

class _AppHome extends StatelessWidget {
  const _AppHome();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('shade'),
      ),
    );
  }
}
