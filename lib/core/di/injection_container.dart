import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shade/core/database/database.dart';
import 'package:shade/core/theme/theme_manager.dart';
import 'package:shade/features/pet/data/datasources/pet_db_datasource.dart';
import 'package:shade/features/pet/data/datasources/visit_db_datasource.dart';
import 'package:shade/features/pet/data/repositories/pet_repository_impl.dart';
import 'package:shade/features/pet/domain/repositories/pet_repository.dart';
import 'package:shade/features/pet/domain/usecases/calculate_decay.dart';
import 'package:shade/features/pet/presentation/providers/pet_state_provider.dart';
import 'package:shade/features/sensors/data/datasources/sensor_db_datasource.dart';
import 'package:shade/features/sensors/data/datasources/sensor_local_datasource.dart';
import 'package:shade/features/sensors/data/repositories/sensor_repository_impl.dart';
import 'package:shade/features/sensors/domain/repositories/sensor_repository.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // Core
  final database = AppDatabase();
  sl.registerLazySingleton<AppDatabase>(() => database);

  // Persistence
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  // Theme
  final themeManager = ThemeManager(prefs);
  await themeManager.initialize();
  sl.registerLazySingleton<ThemeManager>(() => themeManager);

  // Sensors
  sl.registerLazySingleton<SensorLocalDataSource>(() => SensorLocalDataSource());
  sl.registerLazySingleton<SensorDbDataSource>(() => SensorDbDataSource(database));
  sl.registerLazySingleton<SensorRepository>(
    () => SensorRepositoryImpl(
      sl<SensorLocalDataSource>(),
      sl<SensorDbDataSource>(),
    ),
  );

  // Pet
  sl.registerLazySingleton<PetDbDataSource>(() => PetDbDataSource(database));
  sl.registerLazySingleton<VisitDbDataSource>(() => VisitDbDataSource(database));
  sl.registerLazySingleton<CalculateDecay>(() => CalculateDecay());
  sl.registerLazySingleton<PetRepository>(
    () => PetRepositoryImpl(
      sl<PetDbDataSource>(),
      sl<CalculateDecay>(),
    ),
  );

  // Pet State Provider
  sl.registerLazySingleton<PetStateProvider>(
    () => PetStateProvider(
      petRepository: sl<PetRepository>(),
      visitDbDataSource: sl<VisitDbDataSource>(),
      sensorRepository: sl<SensorRepository>(),
    ),
  );

  // Weather
  // (to be implemented in Phase 2/3)

  // Story
  // (to be implemented in Phase 3)
}
