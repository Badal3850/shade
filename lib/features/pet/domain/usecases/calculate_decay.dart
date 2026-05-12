import 'package:shade/core/constants/app_constants.dart';
import 'package:shade/core/utils/date_time_utils.dart';
import 'package:shade/features/pet/domain/entities/pet_entity.dart';

class CalculateDecay {
  PetEntity call(PetEntity current, DateTime lastVisitTime) {
    final hoursElapsed = DateTime.now().difference(lastVisitTime).inMinutes / 60.0;
    if (hoursElapsed <= 0) return current;

    final now = DateTime.now();
    final isLateNight = DateTimeUtils.isLateNight(now);
    final isMorningRush = DateTimeUtils.isMorningRush(now);

    final energyRate = isLateNight
        ? AppConstants.energyDecayRate * 0.3
        : AppConstants.energyDecayRate;
    final alertnessRate = isLateNight
        ? AppConstants.alertnessDecayRate * 2.0
        : AppConstants.alertnessDecayRate;

    final newHunger = _incStat(current.hunger, AppConstants.hungerDecayRate, hoursElapsed);
    final newEnergy = _decayStat(current.energy, energyRate, hoursElapsed);
    final newMood = _decayStat(current.mood, AppConstants.moodDecayRate, hoursElapsed);
    final moodWithBoost = isMorningRush ? (newMood + 2).clamp(0, 100) : newMood;
    final newLoneliness = _incStat(current.loneliness, AppConstants.lonelinessDecayRate, hoursElapsed);
    final newAlertness = _decayStat(current.alertness, alertnessRate, hoursElapsed);

    // Health decays when critical stats are neglected
    int neglectCount = 0;
    if (newHunger >= 90) neglectCount++;
    if (newEnergy <= 10) neglectCount++;
    if (newMood <= 10) neglectCount++;
    final newHealth = _decayStat(current.health, neglectCount * 5.0, hoursElapsed);

    return PetEntity(
      hunger: newHunger,
      energy: newEnergy,
      mood: moodWithBoost,
      loneliness: newLoneliness,
      alertness: newAlertness,
      health: newHealth,
    );
  }

  int _decayStat(int value, double ratePerHour, double hours) {
    return (value - (ratePerHour * hours)).round().clamp(0, 100);
  }

  int _incStat(int value, double ratePerHour, double hours) {
    return (value + (ratePerHour * hours)).round().clamp(0, 100);
  }
}
