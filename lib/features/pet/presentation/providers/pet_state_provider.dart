import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shade/features/pet/data/datasources/visit_db_datasource.dart';
import 'package:shade/features/pet/domain/entities/pet_entity.dart';
import 'package:shade/features/pet/domain/repositories/pet_repository.dart';
import 'package:shade/features/sensors/domain/entities/sensor_reading.dart';
import 'package:shade/features/sensors/domain/repositories/sensor_repository.dart';
import 'package:shade/features/weather/domain/repositories/weather_repository.dart';
import 'package:shade/core/notifications/notification_service.dart';

class PetStateProvider extends ChangeNotifier {
  final PetRepository _petRepository;
  final VisitDbDataSource _visitDbDataSource;
  final SensorRepository _sensorRepository;
  final WeatherRepository _weatherRepository;

  PetEntity _petState = const PetEntity();
  SensorReading _sensorReading = SensorReading(timestamp: DateTime.now());
  bool _isLoading = true;
  String? _error;
  StreamSubscription<SensorReading>? _sensorSubscription;
  Timer? _pollTimer;
  Timer? _logTimer;
  Timer? _batteryStepsTimer;
  Timer? _weatherTimer;
  int? _cachedBatteryLevel;
  int? _cachedStepCount;
  int _lastKnownStepCount = 0;

  int? _currentVisitId;
  DateTime? _lastShakeTime;
  bool _isPetJumping = false;
  static const double _shakeThreshold = 15.0;

  PetStateProvider({
    required PetRepository petRepository,
    required VisitDbDataSource visitDbDataSource,
    required SensorRepository sensorRepository,
    required WeatherRepository weatherRepository,
  })  : _petRepository = petRepository,
        _visitDbDataSource = visitDbDataSource,
        _sensorRepository = sensorRepository,
        _weatherRepository = weatherRepository;

  PetEntity get petState => _petState;
  SensorReading get sensorReading => _sensorReading;
  bool get isLoading => _isLoading;
  bool get isPetJumping => _isPetJumping;
  String? get error => _error;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();
    try {
      // Request permissions
      await [
        Permission.activityRecognition,
        Permission.sensors,
      ].request();

      final lastVisit = await _visitDbDataSource.getLastVisit();
      if (lastVisit != null && lastVisit.closedAt != null) {
        _petState = await _petRepository.calculateDecay(lastVisit.closedAt!);
      } else {
        _petState = await _petRepository.getCurrentState();
      }
      _currentVisitId = await _visitDbDataSource.recordOpen();
      _sensorReading = await _sensorRepository.getCurrentReading();
      _cachedBatteryLevel = _sensorReading.batteryLevel;
      _cachedStepCount = await _sensorRepository.getDailyStepCount();
      _lastKnownStepCount = _cachedStepCount ?? 0;

      _isLoading = false;
      notifyListeners();
      _startPolling();
      _startSensorSubscription();
      _startBackgroundLogging();
      _startBatteryStepsPolling();
      _startWeatherPolling();

    } catch (e, stack) {
      debugPrint('[PetStateProvider] initialize error: $e');
      debugPrint('[PetStateProvider] stack: $stack');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void _startPolling() {
    _pollTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      try {
        _petState = await _petRepository.getCurrentState();
        notifyListeners();
        // Notify if pet is critically neglected
        if (_petState.hunger >= 90 || _petState.health <= 20) {
          NotificationService.showNeglectReminder('');
        }
      } catch (_) {}
    });
  }

  void _startSensorSubscription() {
    _sensorSubscription?.cancel();
    _sensorSubscription = _sensorRepository.getSensorStream().listen(
      (reading) {
        // Detect shake
        final accelX = reading.accelerometerX ?? 0;
        final accelY = reading.accelerometerY ?? 0;
        final accelZ = reading.accelerometerZ ?? 0;
        final magnitude = accelX.abs() + accelY.abs() + accelZ.abs();

        if (magnitude > _shakeThreshold) {
          final now = DateTime.now();
          if (_lastShakeTime == null ||
              now.difference(_lastShakeTime!) > const Duration(seconds: 1)) {
            _lastShakeTime = now;
            _handleShake();
          }
        }

        // Merge stream accelerometer data with periodically cached battery/steps
        _sensorReading = SensorReading(
          accelerometerX: reading.accelerometerX,
          accelerometerY: reading.accelerometerY,
          accelerometerZ: reading.accelerometerZ,
          batteryLevel: _cachedBatteryLevel,
          stepCount: _cachedStepCount,
          lightLevel: _sensorReading.lightLevel,
          timestamp: reading.timestamp,
        );
        notifyListeners();
      },
      onError: (e) {
        debugPrint('[PetStateProvider] sensor stream error: $e');
      },
    );
  }

  void _handleShake() async {
    HapticFeedback.mediumImpact();
    _isPetJumping = true;
    // Increase mood/energy slightly when played with via shake
    _petState = _petState.copyWith(
      mood: (_petState.mood + 5).clamp(0, 100),
      energy: (_petState.energy - 2).clamp(0, 100),
    );
    notifyListeners();
    await _petRepository.updateState(_petState);
  }

  void _startBatteryStepsPolling() {
    _batteryStepsTimer?.cancel();
    // Refresh battery and step count every 60 seconds
    _batteryStepsTimer = Timer.periodic(const Duration(seconds: 60), (_) async {
      try {
        final reading = await _sensorRepository.getCurrentReading();
        _cachedBatteryLevel = reading.batteryLevel;
        _cachedStepCount = await _sensorRepository.getDailyStepCount();
        // Energy regeneration: every 1000 steps = +5 energy
        final newSteps = (_cachedStepCount ?? 0) - _lastKnownStepCount;
        if (newSteps > 0) {
          final energyGain = (newSteps ~/ 1000) * 5;
          if (energyGain > 0) {
            _petState = _petState.copyWith(
              energy: (_petState.energy + energyGain).clamp(0, 100),
            );
            await _petRepository.updateState(_petState);
            notifyListeners();
          }
          _lastKnownStepCount = _cachedStepCount ?? 0;
        }
      } catch (_) {}
    });
  }

  void setPetJumping(bool value) {
    _isPetJumping = value;
    notifyListeners();
  }

  void _startBackgroundLogging() {
    _logTimer?.cancel();
    // Log state every 5 minutes (logging only, does not overwrite live sensor data)
    _logTimer = Timer.periodic(const Duration(minutes: 5), (_) async {
      try {
        await _sensorRepository.getCurrentReading();
      } catch (_) {}
    });
  }

  Future<void> recordClose() async {
    if (_currentVisitId != null) {
      await _visitDbDataSource.recordClose(_currentVisitId!);
      _currentVisitId = null;
    }
  }

  Future<void> feed() async {
    HapticFeedback.lightImpact();
    _petState = _petState.copyWith(
      hunger: (_petState.hunger - 30).clamp(0, 100),
      mood: (_petState.mood + 5).clamp(0, 100),
    );
    notifyListeners();
    await _petRepository.updateState(_petState);
  }

  Future<void> pet() async {
    HapticFeedback.lightImpact();
    _isPetJumping = true;
    _petState = _petState.copyWith(
      mood: (_petState.mood + 10).clamp(0, 100),
      loneliness: (_petState.loneliness - 15).clamp(0, 100),
    );
    notifyListeners();
    await _petRepository.updateState(_petState);
  }

  void _startWeatherPolling() {
    _weatherTimer?.cancel();
    _applyWeatherEffect();
    _weatherTimer = Timer.periodic(const Duration(minutes: 30), (_) => _applyWeatherEffect());
  }

  Future<void> _applyWeatherEffect() async {
    try {
      final weather = await _weatherRepository.getCurrentWeather(12.9716, 77.5946);
      int moodDelta = 0;
      if (weather.isSunny) moodDelta = 5;
      if (weather.isRaining) moodDelta = -3;
      if (weather.temperatureCelsius > 35) moodDelta -= 3;
      if (weather.temperatureCelsius < 10) moodDelta -= 2;
      if (moodDelta != 0) {
        _petState = _petState.copyWith(
          mood: (_petState.mood + moodDelta).clamp(0, 100),
        );
        await _petRepository.updateState(_petState);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('[PetStateProvider] weather effect error: $e');
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _sensorSubscription?.cancel();
    _logTimer?.cancel();
    _batteryStepsTimer?.cancel();
    _weatherTimer?.cancel();
    super.dispose();
  }
}
