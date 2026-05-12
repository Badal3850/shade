class AppConstants {
  AppConstants._();

  static const String appName = 'Digital Pet';
  static const String databaseName = 'digital_pet.db';

  // Pet state defaults
  static const int defaultStatValue = 50;
  static const int maxStatValue = 100;
  static const int minStatValue = 0;

  // Decay rates (per hour)
  static const double hungerDecayRate = 5.0;
  static const double energyDecayRate = 3.0;
  static const double moodDecayRate = 2.0;
  static const double lonelinessDecayRate = 4.0;
  static const double alertnessDecayRate = 3.0;

  // Sensor constants
  static const double phoneDropThreshold = 25.0;
  static const int batteryLowThreshold = 15;
  static const int batteryCriticalThreshold = 5;

  // Time constants
  static const int morningStartHour = 6;
  static const int morningEndHour = 8;
  static const int lateNightStartHour = 3;
}
