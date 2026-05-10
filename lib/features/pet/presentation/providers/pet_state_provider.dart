import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shade/features/pet/data/datasources/visit_db_datasource.dart';
import 'package:shade/features/pet/domain/entities/pet_entity.dart';
import 'package:shade/features/pet/domain/repositories/pet_repository.dart';
import 'package:shade/features/sensors/domain/entities/sensor_reading.dart';
import 'package:shade/features/sensors/domain/repositories/sensor_repository.dart';

class PetStateProvider extends ChangeNotifier {
  final PetRepository _petRepository;
  final VisitDbDataSource _visitDbDataSource;
  final SensorRepository _sensorRepository;

  PetEntity _petState = const PetEntity();
  SensorReading _sensorReading = SensorReading(timestamp: DateTime.now());
  bool _isLoading = true;
  String? _error;
  Timer? _pollTimer;
  int? _currentVisitId;

  PetStateProvider({
    required PetRepository petRepository,
    required VisitDbDataSource visitDbDataSource,
    required SensorRepository sensorRepository,
  })  : _petRepository = petRepository,
        _visitDbDataSource = visitDbDataSource,
        _sensorRepository = sensorRepository;

  PetEntity get petState => _petState;
  SensorReading get sensorReading => _sensorReading;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();
    try {
      final lastVisit = await _visitDbDataSource.getLastVisit();
      if (lastVisit != null && lastVisit.closedAt != null) {
        _petState = await _petRepository.calculateDecay(lastVisit.closedAt!);
      } else {
        _petState = await _petRepository.getCurrentState();
      }
      _currentVisitId = await _visitDbDataSource.recordOpen();
      _sensorReading = await _sensorRepository.getCurrentReading();
      _isLoading = false;
      notifyListeners();
      _startPolling();
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
      } catch (_) {}
    });
  }

  Future<void> recordClose() async {
    if (_currentVisitId != null) {
      await _visitDbDataSource.recordClose(_currentVisitId!);
      _currentVisitId = null;
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }
}
