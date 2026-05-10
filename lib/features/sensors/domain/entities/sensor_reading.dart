import 'package:equatable/equatable.dart';

class SensorReading extends Equatable {
  final double? accelerometerX;
  final double? accelerometerY;
  final double? accelerometerZ;
  final double? lightLevel;
  final int? batteryLevel;
  final int? stepCount;
  final DateTime timestamp;

  const SensorReading({
    this.accelerometerX,
    this.accelerometerY,
    this.accelerometerZ,
    this.lightLevel,
    this.batteryLevel,
    this.stepCount,
    required this.timestamp,
  });

  double get totalAcceleration {
    final x = accelerometerX ?? 0;
    final y = accelerometerY ?? 0;
    final z = accelerometerZ ?? 0;
    return (x * x + y * y + z * z).clamp(0, double.infinity);
  }

  bool get isPhoneDrop {
    const threshold = 25.0;
    return totalAcceleration > threshold;
  }

  @override
  List<Object?> get props => [
        accelerometerX,
        accelerometerY,
        accelerometerZ,
        lightLevel,
        batteryLevel,
        stepCount,
        timestamp,
      ];
}
