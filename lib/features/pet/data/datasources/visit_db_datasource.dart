import 'package:drift/drift.dart';
import 'package:digital_pet/core/database/database.dart';

class VisitDbDataSource {
  final AppDatabase _db;

  VisitDbDataSource(this._db);

  Future<int> recordOpen() async {
    final id = await _db.into(_db.visitHistory).insert(
      VisitHistoryCompanion(
        openedAt: Value(DateTime.now()),
      ),
    );
    return id;
  }

  Future<void> recordClose(int visitId) async {
    await (_db.update(_db.visitHistory)
      ..where((t) => t.id.equals(visitId))
    ).write(
      VisitHistoryCompanion(closedAt: Value(DateTime.now())),
    );
  }

  Future<VisitHistoryData?> getLastVisit() async {
    final query = _db.select(_db.visitHistory)
      ..orderBy([(t) => OrderingTerm.desc(t.openedAt)])
      ..limit(1);
    final visits = await query.get();
    return visits.isEmpty ? null : visits.first;
  }
}
