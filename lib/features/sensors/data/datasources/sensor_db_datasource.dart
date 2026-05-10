import 'package:drift/drift.dart';
import 'package:digital_pet/core/database/database.dart';

class SensorDbDataSource {
  final AppDatabase _db;

  SensorDbDataSource(this._db);

  Future<void> insertSensorLog(SensorLogsCompanion log) async {
    await _db.into(_db.sensorLogs).insert(log);
  }

  Future<List<SensorLog>> getRecentLogs({int limit = 50}) async {
    final query = _db.select(_db.sensorLogs)
      ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
      ..limit(limit);
    return query.get();
  }

  Future<SensorLog?> getLatestLog() async {
    final query = _db.select(_db.sensorLogs)
      ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
      ..limit(1);
    final logs = await query.get();
    return logs.isEmpty ? null : logs.first;
  }
}
