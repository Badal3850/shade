import 'package:digital_pet/features/sensors/domain/entities/sensor_reading.dart';

abstract class SensorRepository {
  Stream<SensorReading> getSensorStream();
  Future<SensorReading> getCurrentReading();
  Future<int> getDailyStepCount();
}
