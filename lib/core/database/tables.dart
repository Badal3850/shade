import 'package:drift/drift.dart';

class SensorLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get accelerometerX => real().nullable()();
  RealColumn get accelerometerY => real().nullable()();
  RealColumn get accelerometerZ => real().nullable()();
  RealColumn get lightLevel => real().nullable()();
  IntColumn get batteryLevel => integer().nullable()();
  IntColumn get stepCount => integer().nullable()();
  DateTimeColumn get timestamp => dateTime()();
}

class PetState extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get hunger => integer().withDefault(const Constant(50))();
  IntColumn get energy => integer().withDefault(const Constant(50))();
  IntColumn get mood => integer().withDefault(const Constant(50))();
  IntColumn get loneliness => integer().withDefault(const Constant(50))();
  IntColumn get alertness => integer().withDefault(const Constant(50))();
  IntColumn get health => integer().withDefault(const Constant(100))();
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class VisitHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get openedAt => dateTime()();
  DateTimeColumn get closedAt => dateTime().nullable()();
}
