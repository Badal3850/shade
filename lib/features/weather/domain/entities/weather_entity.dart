import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final double temperatureCelsius;
  final String weatherCode;
  final bool isRaining;
  final bool isSunny;

  const WeatherEntity({
    required this.temperatureCelsius,
    required this.weatherCode,
    this.isRaining = false,
    this.isSunny = false,
  });

  @override
  List<Object?> get props => [temperatureCelsius, weatherCode, isRaining, isSunny];
}
