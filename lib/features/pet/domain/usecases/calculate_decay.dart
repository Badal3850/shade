import 'package:shade/core/constants/app_constants.dart';
import 'package:shade/features/pet/domain/entities/pet_entity.dart';

class CalculateDecay {
  PetEntity call(PetEntity current, DateTime lastVisitTime, {List<String>? triggers}) {
    final hoursElapsed = DateTime.now().difference(lastVisitTime).inMinutes / 60.0;
    if (hoursElapsed <= 0) return current;

    return PetEntity(
      hunger: _decayStat(current.hunger, AppConstants.hungerDecayRate, hoursElapsed),
      energy: _decayStat(current.energy, AppConstants.energyDecayRate, hoursElapsed),
      mood: _decayStat(current.mood, AppConstants.moodDecayRate, hoursElapsed),
      loneliness: _incStat(current.loneliness, AppConstants.lonelinessDecayRate, hoursElapsed),
      alertness: _decayStat(current.alertness, AppConstants.alertnessDecayRate, hoursElapsed),
    );
  }

  int _decayStat(int value, double ratePerHour, double hours) {
    return (value - (ratePerHour * hours)).round().clamp(0, 100);
  }

  int _incStat(int value, double ratePerHour, double hours) {
    return (value + (ratePerHour * hours)).round().clamp(0, 100);
  }
}
