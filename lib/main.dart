import 'package:flutter/material.dart';
import 'package:flutter_gemma/core/api/flutter_gemma.dart';
import 'app.dart';
import 'core/di/injection_container.dart';
import 'core/notifications/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterGemma.initialize();
  await configureDependencies();
  await NotificationService.initialize();
  runApp(const ShadeApp());
}
