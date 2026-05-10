import 'package:flutter/material.dart';
import 'package:shade/core/navigation/bottom_nav_shell.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      default:
        return MaterialPageRoute(
          builder: (_) => const BottomNavShell(),
          settings: settings,
        );
    }
  }
}
