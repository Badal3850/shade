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
    accelerometerX: reading.accelerometerX != null ? Value(reading.accelerometerX!) : const Value.absent(),
    accelerometerY: reading.accelerometerY != null ? Value(reading.accelerometerY!) : const Value.absent(),
    accelerometerZ: reading.accelerometerZ != null ? Value(reading.accelerometerZ!) : const Value.absent(),
    lightLevel: reading.lightLevel != null ? Value(reading.lightLevel!) : const Value.absent(),
    batteryLevel: reading.batteryLevel != null ? Value(reading.batteryLevel!) : const Value.absent(),
    stepCount: reading.stepCount != null ? Value(reading.stepCount!) : const Value.absent(),
    timestamp: Value(reading.timestamp),
  );
}
