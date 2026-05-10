import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shade/features/sensors/data/datasources/sensor_db_datasource.dart';
import 'package:shade/features/sensors/data/datasources/sensor_local_datasource.dart';
import 'package:shade/features/sensors/data/models/sensor_mappers.dart';
import 'package:shade/features/sensors/domain/entities/sensor_reading.dart';
import 'package:shade/features/sensors/domain/repositories/sensor_repository.dart';

class SensorRepositoryImpl implements SensorRepository {
  final SensorLocalDataSource _localDataSource;
  final SensorDbDataSource _dbDataSource;

  SensorRepositoryImpl(this._localDataSource, this._dbDataSource);

  @override
  Future<SensorReading> getCurrentReading() async {
    int? batteryLevel;
    try {
      batteryLevel = await _localDataSource.getCurrentBatteryLevel();
    } catch (e) {
      debugPrint('[SensorRepo] Battery read failed: $e');
    }

    final reading = SensorReading(
      batteryLevel: batteryLevel,
      timestamp: DateTime.now(),
    );

    try {
      await _dbDataSource.insertSensorLog(readingToCompanion(reading));
    } catch (e) {
      debugPrint('[SensorRepo] DB insert failed: $e');
    }

    return reading;
  }

  @override
  Stream<SensorReading> getSensorStream() {
    // We listen to userAccelerometerEventStream which excludes gravity for easier tilt detection
    return userAccelerometerEventStream(samplingPeriod: SensorInterval.uiInterval).map((event) {
      return SensorReading(
        accelerometerX: event.x,
        accelerometerY: event.y,
        accelerometerZ: event.z,
        timestamp: DateTime.now(),
      );
    });
  }

  @override
  Future<int> getDailyStepCount() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final logs = await _dbDataSource.getRecentLogs(limit: 1000);
    int total = 0;
    for (final log in logs) {
      if (log.timestamp.isAfter(startOfDay)) {
        total += log.stepCount ?? 0;
      }
    }
    return total;
  }
}

