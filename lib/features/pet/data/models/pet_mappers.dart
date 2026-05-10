import 'package:drift/drift.dart';
import 'package:digital_pet/core/database/database.dart';
import 'package:digital_pet/features/pet/domain/entities/pet_entity.dart';

PetEntity petStateDataToEntity(PetStateData data) {
  return PetEntity(
    hunger: data.hunger,
    energy: data.energy,
    mood: data.mood,
    loneliness: data.loneliness,
    alertness: data.alertness,
  );
}

PetStateCompanion entityToCompanion(PetEntity entity, DateTime now) {
  return PetStateCompanion(
    id: const Value(1),
    hunger: Value(entity.hunger.clamp(0, 100)),
    energy: Value(entity.energy.clamp(0, 100)),
    mood: Value(entity.mood.clamp(0, 100)),
    loneliness: Value(entity.loneliness.clamp(0, 100)),
    alertness: Value(entity.alertness.clamp(0, 100)),
    lastUpdated: Value(now),
  );
}
