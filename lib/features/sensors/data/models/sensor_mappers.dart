import 'package:drift/drift.dart';
import 'package:shade/core/database/database.dart';
import 'package:shade/features/sensors/domain/entities/sensor_reading.dart';

SensorReading sensorLogToReading(SensorLog log) {
  return SensorReading(
    accelerometerX: log.accelerometerX,
    accelerometerY: log.accelerometerY,
    accelerometerZ: log.accelerometerZ,
    lightLevel: log.lightLevel,
    batteryLevel: log.batteryLevel,
    stepCount: log.stepCount,
    timestamp: log.timestamp,
  );
}

SensorLogsCompanion readingToCompanion(SensorReading reading) {
  return SensorLogsCompanion(
    accelerometerX: Value(reading.accelerometerX),
    accelerometerY: Value(reading.accelerometerY),
    accelerometerZ: Value(reading.accelerometerZ),
    lightLevel: Value(reading.lightLevel),
    batteryLevel: Value(reading.batteryLevel),
    stepCount: Value(reading.stepCount),
    timestamp: Value(reading.timestamp),
  );
}
