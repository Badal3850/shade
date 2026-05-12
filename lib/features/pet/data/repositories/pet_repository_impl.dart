import 'package:shade/core/errors/failures.dart';
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
    try {
      final data = await _dbDataSource.getCurrentState();
      if (data == null) {
        return const PetEntity();
      }
      return petStateDataToEntity(data);
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<PetEntity> calculateDecay(DateTime lastVisitTime) async {
    try {
      final current = await getCurrentState();
      final decayed = _calculateDecay(current, lastVisitTime);
      await _dbDataSource.upsertState(entityToCompanion(decayed, DateTime.now()));
      return decayed;
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<void> updateState(PetEntity pet) async {
    try {
      await _dbDataSource.upsertState(entityToCompanion(pet, DateTime.now()));
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }
}
