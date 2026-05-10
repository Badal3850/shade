import 'package:digital_pet/core/database/database.dart';

class PetDbDataSource {
  final AppDatabase _db;

  PetDbDataSource(this._db);

  Future<PetStateData?> getCurrentState() async {
    final states = await _db.select(_db.petState).get();
    return states.isEmpty ? null : states.first;
  }

  Future<void> upsertState(PetStateCompanion state) async {
    await _db.into(_db.petState).insertOnConflictUpdate(state);
  }
}
