import 'package:flutter/material.dart';
import 'package:shade/core/di/injection_container.dart';
import 'package:shade/core/navigation/bottom_nav_shell.dart';
import 'package:shade/features/onboarding/onboarding_screen.dart';
import 'package:shade/features/onboarding/pet_name_manager.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/onboarding':
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
          settings: settings,
        );
      case '/':
      default:
        return MaterialPageRoute(
          builder: (_) => const BottomNavShell(),
          settings: settings,
        );
    }
  }

  /// Returns the initial route: '/onboarding' on first launch, '/' otherwise.
  static String initialRoute() {
    final nameManager = sl<PetNameManager>();
    return nameManager.onboardingDone ? '/' : '/onboarding';
  }
}
