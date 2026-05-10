import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:pedometer/pedometer.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorLocalDataSource {
  final Battery _battery = Battery();

  Stream<double> getAccelerometerStream() {
    return accelerometerEventStream(samplingPeriod: SensorInterval.normalInterval).map(
      (event) => (event.x * event.x + event.y * event.y + event.z * event.z),
    );
  }

  Stream<int> getBatteryStream() {
    return _battery.onBatteryStateChanged.map((_) => 0).asyncMap(
      (_) => _battery.batteryLevel,
    );
  }

  Stream<int> getStepCountStream() {
    return Pedometer.stepCountStream.map((event) => event.steps);
  }

  Future<int> getCurrentBatteryLevel() async {
    return _battery.batteryLevel;
  }
}
