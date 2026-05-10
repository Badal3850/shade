import 'package:digital_pet/features/pet/domain/entities/pet_entity.dart';

abstract class PetRepository {
  Future<PetEntity> getCurrentState();
  Future<void> updateState(PetEntity pet);
  Future<PetEntity> calculateDecay(DateTime lastVisitTime);
}
