import 'package:digital_pet/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getCurrentWeather(double latitude, double longitude);
}
