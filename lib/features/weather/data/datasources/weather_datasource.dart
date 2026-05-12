import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shade/features/weather/domain/entities/weather_entity.dart';

class WeatherDataSource {
  static const _defaultLat = 12.9716;
  static const _defaultLon = 77.5946;

  Future<WeatherEntity> getCurrentWeather({
    double lat = _defaultLat,
    double lon = _defaultLon,
  }) async {
    final uri = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$lat&longitude=$lon'
      '&current=temperature_2m,weather_code'
      '&forecast_days=1',
    );
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) {
      throw Exception('Weather fetch failed: ${response.statusCode}');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final current = json['current'] as Map<String, dynamic>;
    final temp = (current['temperature_2m'] as num).toDouble();
    final code = (current['weather_code'] as num).toInt();
    return WeatherEntity(
      temperatureCelsius: temp,
      weatherCode: code.toString(),
      isRaining: code >= 51 && code <= 99,
      isSunny: code <= 3,
    );
  }
}
