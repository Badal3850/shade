import 'package:flutter/foundation.dart';
import 'package:shade/core/errors/failures.dart';
import 'package:shade/features/weather/data/datasources/weather_datasource.dart';
import 'package:shade/features/weather/domain/entities/weather_entity.dart';
import 'package:shade/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataSource _dataSource;
  WeatherRepositoryImpl(this._dataSource);

  @override
  Future<WeatherEntity> getCurrentWeather(double latitude, double longitude) async {
    try {
      return await _dataSource.getCurrentWeather(lat: latitude, lon: longitude);
    } catch (e) {
      debugPrint('[WeatherRepo] fetch failed: $e');
      throw NetworkFailure(e.toString());
    }
  }
}
