import 'package:shade/features/pet/data/datasources/pet_db_datasource.dart';
import 'package:shade/features/pet/data/models/pet_mappers.dart';
import 'package:shade/features/pet/domain/entities/pet_entity.dart';
import 'package:shade/features/pet/domain/repositories/pet_repository.dart';
import 'package:shade/features/pet/domain/usecases/calculate_decay.dart';

class PetRepositoryImpl implements PetRepository {
  final PetDbDataSource _dbDataSource;
  final CalculateDecay _calculateDecay;

  PetRepositoryImpl(this._dbDataSource, this._calculateDecay);

  @override
  Future<PetEntity> getCurrentState() async {
    final data = await _dbDataSource.getCurrentState();
    if (data == null) {
      return const PetEntity();
    }
    return petStateDataToEntity(data);
  }

  @override
  Future<PetEntity> calculateDecay(DateTime lastVisitTime) async {
    final current = await getCurrentState();
    final decayed = _calculateDecay(current, lastVisitTime);
    await _dbDataSource.upsertState(entityToCompanion(decayed, DateTime.now()));
    return decayed;
  }

  @override
  Future<void> updateState(PetEntity pet) async {
    await _dbDataSource.upsertState(entityToCompanion(pet, DateTime.now()));
  }
}
