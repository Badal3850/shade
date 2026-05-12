// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SensorLogsTable extends SensorLogs
    with TableInfo<$SensorLogsTable, SensorLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SensorLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _accelerometerXMeta = const VerificationMeta(
    'accelerometerX',
  );
  @override
  late final GeneratedColumn<double> accelerometerX = GeneratedColumn<double>(
    'accelerometer_x',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accelerometerYMeta = const VerificationMeta(
    'accelerometerY',
  );
  @override
  late final GeneratedColumn<double> accelerometerY = GeneratedColumn<double>(
    'accelerometer_y',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accelerometerZMeta = const VerificationMeta(
    'accelerometerZ',
  );
  @override
  late final GeneratedColumn<double> accelerometerZ = GeneratedColumn<double>(
    'accelerometer_z',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lightLevelMeta = const VerificationMeta(
    'lightLevel',
  );
  @override
  late final GeneratedColumn<double> lightLevel = GeneratedColumn<double>(
    'light_level',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _batteryLevelMeta = const VerificationMeta(
    'batteryLevel',
  );
  @override
  late final GeneratedColumn<int> batteryLevel = GeneratedColumn<int>(
    'battery_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stepCountMeta = const VerificationMeta(
    'stepCount',
  );
  @override
  late final GeneratedColumn<int> stepCount = GeneratedColumn<int>(
    'step_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accelerometerX,
    accelerometerY,
    accelerometerZ,
    lightLevel,
    batteryLevel,
    stepCount,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sensor_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SensorLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('accelerometer_x')) {
      context.handle(
        _accelerometerXMeta,
        accelerometerX.isAcceptableOrUnknown(
          data['accelerometer_x']!,
          _accelerometerXMeta,
        ),
      );
    }
    if (data.containsKey('accelerometer_y')) {
      context.handle(
        _accelerometerYMeta,
        accelerometerY.isAcceptableOrUnknown(
          data['accelerometer_y']!,
          _accelerometerYMeta,
        ),
      );
    }
    if (data.containsKey('accelerometer_z')) {
      context.handle(
        _accelerometerZMeta,
        accelerometerZ.isAcceptableOrUnknown(
          data['accelerometer_z']!,
          _accelerometerZMeta,
        ),
      );
    }
    if (data.containsKey('light_level')) {
      context.handle(
        _lightLevelMeta,
        lightLevel.isAcceptableOrUnknown(data['light_level']!, _lightLevelMeta),
      );
    }
    if (data.containsKey('battery_level')) {
      context.handle(
        _batteryLevelMeta,
        batteryLevel.isAcceptableOrUnknown(
          data['battery_level']!,
          _batteryLevelMeta,
        ),
      );
    }
    if (data.containsKey('step_count')) {
      context.handle(
        _stepCountMeta,
        stepCount.isAcceptableOrUnknown(data['step_count']!, _stepCountMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SensorLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SensorLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accelerometerX: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accelerometer_x'],
      ),
      accelerometerY: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accelerometer_y'],
      ),
      accelerometerZ: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accelerometer_z'],
      ),
      lightLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}light_level'],
      ),
      batteryLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}battery_level'],
      ),
      stepCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_count'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $SensorLogsTable createAlias(String alias) {
    return $SensorLogsTable(attachedDatabase, alias);
  }
}

class SensorLog extends DataClass implements Insertable<SensorLog> {
  final int id;
  final double? accelerometerX;
  final double? accelerometerY;
  final double? accelerometerZ;
  final double? lightLevel;
  final int? batteryLevel;
  final int? stepCount;
  final DateTime timestamp;
  const SensorLog({
    required this.id,
    this.accelerometerX,
    this.accelerometerY,
    this.accelerometerZ,
    this.lightLevel,
    this.batteryLevel,
    this.stepCount,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || accelerometerX != null) {
      map['accelerometer_x'] = Variable<double>(accelerometerX);
    }
    if (!nullToAbsent || accelerometerY != null) {
      map['accelerometer_y'] = Variable<double>(accelerometerY);
    }
    if (!nullToAbsent || accelerometerZ != null) {
      map['accelerometer_z'] = Variable<double>(accelerometerZ);
    }
    if (!nullToAbsent || lightLevel != null) {
      map['light_level'] = Variable<double>(lightLevel);
    }
    if (!nullToAbsent || batteryLevel != null) {
      map['battery_level'] = Variable<int>(batteryLevel);
    }
    if (!nullToAbsent || stepCount != null) {
      map['step_count'] = Variable<int>(stepCount);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  SensorLogsCompanion toCompanion(bool nullToAbsent) {
    return SensorLogsCompanion(
      id: Value(id),
      accelerometerX: accelerometerX == null && nullToAbsent
          ? const Value.absent()
          : Value(accelerometerX),
      accelerometerY: accelerometerY == null && nullToAbsent
          ? const Value.absent()
          : Value(accelerometerY),
      accelerometerZ: accelerometerZ == null && nullToAbsent
          ? const Value.absent()
          : Value(accelerometerZ),
      lightLevel: lightLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(lightLevel),
      batteryLevel: batteryLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(batteryLevel),
      stepCount: stepCount == null && nullToAbsent
          ? const Value.absent()
          : Value(stepCount),
      timestamp: Value(timestamp),
    );
  }

  factory SensorLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SensorLog(
      id: serializer.fromJson<int>(json['id']),
      accelerometerX: serializer.fromJson<double?>(json['accelerometerX']),
      accelerometerY: serializer.fromJson<double?>(json['accelerometerY']),
      accelerometerZ: serializer.fromJson<double?>(json['accelerometerZ']),
      lightLevel: serializer.fromJson<double?>(json['lightLevel']),
      batteryLevel: serializer.fromJson<int?>(json['batteryLevel']),
      stepCount: serializer.fromJson<int?>(json['stepCount']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accelerometerX': serializer.toJson<double?>(accelerometerX),
      'accelerometerY': serializer.toJson<double?>(accelerometerY),
      'accelerometerZ': serializer.toJson<double?>(accelerometerZ),
      'lightLevel': serializer.toJson<double?>(lightLevel),
      'batteryLevel': serializer.toJson<int?>(batteryLevel),
      'stepCount': serializer.toJson<int?>(stepCount),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  SensorLog copyWith({
    int? id,
    Value<double?> accelerometerX = const Value.absent(),
    Value<double?> accelerometerY = const Value.absent(),
    Value<double?> accelerometerZ = const Value.absent(),
    Value<double?> lightLevel = const Value.absent(),
    Value<int?> batteryLevel = const Value.absent(),
    Value<int?> stepCount = const Value.absent(),
    DateTime? timestamp,
  }) => SensorLog(
    id: id ?? this.id,
    accelerometerX: accelerometerX.present
        ? accelerometerX.value
        : this.accelerometerX,
    accelerometerY: accelerometerY.present
        ? accelerometerY.value
        : this.accelerometerY,
    accelerometerZ: accelerometerZ.present
        ? accelerometerZ.value
        : this.accelerometerZ,
    lightLevel: lightLevel.present ? lightLevel.value : this.lightLevel,
    batteryLevel: batteryLevel.present ? batteryLevel.value : this.batteryLevel,
    stepCount: stepCount.present ? stepCount.value : this.stepCount,
    timestamp: timestamp ?? this.timestamp,
  );
  SensorLog copyWithCompanion(SensorLogsCompanion data) {
    return SensorLog(
      id: data.id.present ? data.id.value : this.id,
      accelerometerX: data.accelerometerX.present
          ? data.accelerometerX.value
          : this.accelerometerX,
      accelerometerY: data.accelerometerY.present
          ? data.accelerometerY.value
          : this.accelerometerY,
      accelerometerZ: data.accelerometerZ.present
          ? data.accelerometerZ.value
          : this.accelerometerZ,
      lightLevel: data.lightLevel.present
          ? data.lightLevel.value
          : this.lightLevel,
      batteryLevel: data.batteryLevel.present
          ? data.batteryLevel.value
          : this.batteryLevel,
      stepCount: data.stepCount.present ? data.stepCount.value : this.stepCount,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SensorLog(')
          ..write('id: $id, ')
          ..write('accelerometerX: $accelerometerX, ')
          ..write('accelerometerY: $accelerometerY, ')
          ..write('accelerometerZ: $accelerometerZ, ')
          ..write('lightLevel: $lightLevel, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('stepCount: $stepCount, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accelerometerX,
    accelerometerY,
    accelerometerZ,
    lightLevel,
    batteryLevel,
    stepCount,
    timestamp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SensorLog &&
          other.id == this.id &&
          other.accelerometerX == this.accelerometerX &&
          other.accelerometerY == this.accelerometerY &&
          other.accelerometerZ == this.accelerometerZ &&
          other.lightLevel == this.lightLevel &&
          other.batteryLevel == this.batteryLevel &&
          other.stepCount == this.stepCount &&
          other.timestamp == this.timestamp);
}

class SensorLogsCompanion extends UpdateCompanion<SensorLog> {
  final Value<int> id;
  final Value<double?> accelerometerX;
  final Value<double?> accelerometerY;
  final Value<double?> accelerometerZ;
  final Value<double?> lightLevel;
  final Value<int?> batteryLevel;
  final Value<int?> stepCount;
  final Value<DateTime> timestamp;
  const SensorLogsCompanion({
    this.id = const Value.absent(),
    this.accelerometerX = const Value.absent(),
    this.accelerometerY = const Value.absent(),
    this.accelerometerZ = const Value.absent(),
    this.lightLevel = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    this.stepCount = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  SensorLogsCompanion.insert({
    this.id = const Value.absent(),
    this.accelerometerX = const Value.absent(),
    this.accelerometerY = const Value.absent(),
    this.accelerometerZ = const Value.absent(),
    this.lightLevel = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    this.stepCount = const Value.absent(),
    required DateTime timestamp,
  }) : timestamp = Value(timestamp);
  static Insertable<SensorLog> custom({
    Expression<int>? id,
    Expression<double>? accelerometerX,
    Expression<double>? accelerometerY,
    Expression<double>? accelerometerZ,
    Expression<double>? lightLevel,
    Expression<int>? batteryLevel,
    Expression<int>? stepCount,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accelerometerX != null) 'accelerometer_x': accelerometerX,
      if (accelerometerY != null) 'accelerometer_y': accelerometerY,
      if (accelerometerZ != null) 'accelerometer_z': accelerometerZ,
      if (lightLevel != null) 'light_level': lightLevel,
      if (batteryLevel != null) 'battery_level': batteryLevel,
      if (stepCount != null) 'step_count': stepCount,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  SensorLogsCompanion copyWith({
    Value<int>? id,
    Value<double?>? accelerometerX,
    Value<double?>? accelerometerY,
    Value<double?>? accelerometerZ,
    Value<double?>? lightLevel,
    Value<int?>? batteryLevel,
    Value<int?>? stepCount,
    Value<DateTime>? timestamp,
  }) {
    return SensorLogsCompanion(
      id: id ?? this.id,
      accelerometerX: accelerometerX ?? this.accelerometerX,
      accelerometerY: accelerometerY ?? this.accelerometerY,
      accelerometerZ: accelerometerZ ?? this.accelerometerZ,
      lightLevel: lightLevel ?? this.lightLevel,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      stepCount: stepCount ?? this.stepCount,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accelerometerX.present) {
      map['accelerometer_x'] = Variable<double>(accelerometerX.value);
    }
    if (accelerometerY.present) {
      map['accelerometer_y'] = Variable<double>(accelerometerY.value);
    }
    if (accelerometerZ.present) {
      map['accelerometer_z'] = Variable<double>(accelerometerZ.value);
    }
    if (lightLevel.present) {
      map['light_level'] = Variable<double>(lightLevel.value);
    }
    if (batteryLevel.present) {
      map['battery_level'] = Variable<int>(batteryLevel.value);
    }
    if (stepCount.present) {
      map['step_count'] = Variable<int>(stepCount.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SensorLogsCompanion(')
          ..write('id: $id, ')
          ..write('accelerometerX: $accelerometerX, ')
          ..write('accelerometerY: $accelerometerY, ')
          ..write('accelerometerZ: $accelerometerZ, ')
          ..write('lightLevel: $lightLevel, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('stepCount: $stepCount, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $PetStateTable extends PetState
    with TableInfo<$PetStateTable, PetStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _hungerMeta = const VerificationMeta('hunger');
  @override
  late final GeneratedColumn<int> hunger = GeneratedColumn<int>(
    'hunger',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _energyMeta = const VerificationMeta('energy');
  @override
  late final GeneratedColumn<int> energy = GeneratedColumn<int>(
    'energy',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<int> mood = GeneratedColumn<int>(
    'mood',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _lonelinessMeta = const VerificationMeta(
    'loneliness',
  );
  @override
  late final GeneratedColumn<int> loneliness = GeneratedColumn<int>(
    'loneliness',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _alertnessMeta = const VerificationMeta(
    'alertness',
  );
  @override
  late final GeneratedColumn<int> alertness = GeneratedColumn<int>(
    'alertness',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _healthMeta = const VerificationMeta('health');
  @override
  late final GeneratedColumn<int> health = GeneratedColumn<int>(
    'health',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(100),
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    hunger,
    energy,
    mood,
    loneliness,
    alertness,
    health,
    lastUpdated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pet_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<PetStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hunger')) {
      context.handle(
        _hungerMeta,
        hunger.isAcceptableOrUnknown(data['hunger']!, _hungerMeta),
      );
    }
    if (data.containsKey('energy')) {
      context.handle(
        _energyMeta,
        energy.isAcceptableOrUnknown(data['energy']!, _energyMeta),
      );
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    }
    if (data.containsKey('loneliness')) {
      context.handle(
        _lonelinessMeta,
        loneliness.isAcceptableOrUnknown(data['loneliness']!, _lonelinessMeta),
      );
    }
    if (data.containsKey('alertness')) {
      context.handle(
        _alertnessMeta,
        alertness.isAcceptableOrUnknown(data['alertness']!, _alertnessMeta),
      );
    }
    if (data.containsKey('health')) {
      context.handle(
        _healthMeta,
        health.isAcceptableOrUnknown(data['health']!, _healthMeta),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PetStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PetStateData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      hunger: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hunger'],
      )!,
      energy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy'],
      )!,
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood'],
      )!,
      loneliness: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}loneliness'],
      )!,
      alertness: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alertness'],
      )!,
      health: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}health'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
    );
  }

  @override
  $PetStateTable createAlias(String alias) {
    return $PetStateTable(attachedDatabase, alias);
  }
}

class PetStateData extends DataClass implements Insertable<PetStateData> {
  final int id;
  final int hunger;
  final int energy;
  final int mood;
  final int loneliness;
  final int alertness;
  final int health;
  final DateTime lastUpdated;
  const PetStateData({
    required this.id,
    required this.hunger,
    required this.energy,
    required this.mood,
    required this.loneliness,
    required this.alertness,
    required this.health,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['hunger'] = Variable<int>(hunger);
    map['energy'] = Variable<int>(energy);
    map['mood'] = Variable<int>(mood);
    map['loneliness'] = Variable<int>(loneliness);
    map['alertness'] = Variable<int>(alertness);
    map['health'] = Variable<int>(health);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  PetStateCompanion toCompanion(bool nullToAbsent) {
    return PetStateCompanion(
      id: Value(id),
      hunger: Value(hunger),
      energy: Value(energy),
      mood: Value(mood),
      loneliness: Value(loneliness),
      alertness: Value(alertness),
      health: Value(health),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory PetStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PetStateData(
      id: serializer.fromJson<int>(json['id']),
      hunger: serializer.fromJson<int>(json['hunger']),
      energy: serializer.fromJson<int>(json['energy']),
      mood: serializer.fromJson<int>(json['mood']),
      loneliness: serializer.fromJson<int>(json['loneliness']),
      alertness: serializer.fromJson<int>(json['alertness']),
      health: serializer.fromJson<int>(json['health']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hunger': serializer.toJson<int>(hunger),
      'energy': serializer.toJson<int>(energy),
      'mood': serializer.toJson<int>(mood),
      'loneliness': serializer.toJson<int>(loneliness),
      'alertness': serializer.toJson<int>(alertness),
      'health': serializer.toJson<int>(health),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  PetStateData copyWith({
    int? id,
    int? hunger,
    int? energy,
    int? mood,
    int? loneliness,
    int? alertness,
    int? health,
    DateTime? lastUpdated,
  }) => PetStateData(
    id: id ?? this.id,
    hunger: hunger ?? this.hunger,
    energy: energy ?? this.energy,
    mood: mood ?? this.mood,
    loneliness: loneliness ?? this.loneliness,
    alertness: alertness ?? this.alertness,
    health: health ?? this.health,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  PetStateData copyWithCompanion(PetStateCompanion data) {
    return PetStateData(
      id: data.id.present ? data.id.value : this.id,
      hunger: data.hunger.present ? data.hunger.value : this.hunger,
      energy: data.energy.present ? data.energy.value : this.energy,
      mood: data.mood.present ? data.mood.value : this.mood,
      loneliness: data.loneliness.present
          ? data.loneliness.value
          : this.loneliness,
      alertness: data.alertness.present ? data.alertness.value : this.alertness,
      health: data.health.present ? data.health.value : this.health,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PetStateData(')
          ..write('id: $id, ')
          ..write('hunger: $hunger, ')
          ..write('energy: $energy, ')
          ..write('mood: $mood, ')
          ..write('loneliness: $loneliness, ')
          ..write('alertness: $alertness, ')
          ..write('health: $health, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    hunger,
    energy,
    mood,
    loneliness,
    alertness,
    health,
    lastUpdated,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PetStateData &&
          other.id == this.id &&
          other.hunger == this.hunger &&
          other.energy == this.energy &&
          other.mood == this.mood &&
          other.loneliness == this.loneliness &&
          other.alertness == this.alertness &&
          other.health == this.health &&
          other.lastUpdated == this.lastUpdated);
}

class PetStateCompanion extends UpdateCompanion<PetStateData> {
  final Value<int> id;
  final Value<int> hunger;
  final Value<int> energy;
  final Value<int> mood;
  final Value<int> loneliness;
  final Value<int> alertness;
  final Value<int> health;
  final Value<DateTime> lastUpdated;
  const PetStateCompanion({
    this.id = const Value.absent(),
    this.hunger = const Value.absent(),
    this.energy = const Value.absent(),
    this.mood = const Value.absent(),
    this.loneliness = const Value.absent(),
    this.alertness = const Value.absent(),
    this.health = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  PetStateCompanion.insert({
    this.id = const Value.absent(),
    this.hunger = const Value.absent(),
    this.energy = const Value.absent(),
    this.mood = const Value.absent(),
    this.loneliness = const Value.absent(),
    this.alertness = const Value.absent(),
    this.health = const Value.absent(),
    required DateTime lastUpdated,
  }) : lastUpdated = Value(lastUpdated);
  static Insertable<PetStateData> custom({
    Expression<int>? id,
    Expression<int>? hunger,
    Expression<int>? energy,
    Expression<int>? mood,
    Expression<int>? loneliness,
    Expression<int>? alertness,
    Expression<int>? health,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hunger != null) 'hunger': hunger,
      if (energy != null) 'energy': energy,
      if (mood != null) 'mood': mood,
      if (loneliness != null) 'loneliness': loneliness,
      if (alertness != null) 'alertness': alertness,
      if (health != null) 'health': health,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  PetStateCompanion copyWith({
    Value<int>? id,
    Value<int>? hunger,
    Value<int>? energy,
    Value<int>? mood,
    Value<int>? loneliness,
    Value<int>? alertness,
    Value<int>? health,
    Value<DateTime>? lastUpdated,
  }) {
    return PetStateCompanion(
      id: id ?? this.id,
      hunger: hunger ?? this.hunger,
      energy: energy ?? this.energy,
      mood: mood ?? this.mood,
      loneliness: loneliness ?? this.loneliness,
      alertness: alertness ?? this.alertness,
      health: health ?? this.health,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hunger.present) {
      map['hunger'] = Variable<int>(hunger.value);
    }
    if (energy.present) {
      map['energy'] = Variable<int>(energy.value);
    }
    if (mood.present) {
      map['mood'] = Variable<int>(mood.value);
    }
    if (loneliness.present) {
      map['loneliness'] = Variable<int>(loneliness.value);
    }
    if (alertness.present) {
      map['alertness'] = Variable<int>(alertness.value);
    }
    if (health.present) {
      map['health'] = Variable<int>(health.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetStateCompanion(')
          ..write('id: $id, ')
          ..write('hunger: $hunger, ')
          ..write('energy: $energy, ')
          ..write('mood: $mood, ')
          ..write('loneliness: $loneliness, ')
          ..write('alertness: $alertness, ')
          ..write('health: $health, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $VisitHistoryTable extends VisitHistory
    with TableInfo<$VisitHistoryTable, VisitHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VisitHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _openedAtMeta = const VerificationMeta(
    'openedAt',
  );
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
    'opened_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _closedAtMeta = const VerificationMeta(
    'closedAt',
  );
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
    'closed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, openedAt, closedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'visit_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<VisitHistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('opened_at')) {
      context.handle(
        _openedAtMeta,
        openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_openedAtMeta);
    }
    if (data.containsKey('closed_at')) {
      context.handle(
        _closedAtMeta,
        closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisitHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VisitHistoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      openedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opened_at'],
      )!,
      closedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}closed_at'],
      ),
    );
  }

  @override
  $VisitHistoryTable createAlias(String alias) {
    return $VisitHistoryTable(attachedDatabase, alias);
  }
}

class VisitHistoryData extends DataClass
    implements Insertable<VisitHistoryData> {
  final int id;
  final DateTime openedAt;
  final DateTime? closedAt;
  const VisitHistoryData({
    required this.id,
    required this.openedAt,
    this.closedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['opened_at'] = Variable<DateTime>(openedAt);
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    return map;
  }

  VisitHistoryCompanion toCompanion(bool nullToAbsent) {
    return VisitHistoryCompanion(
      id: Value(id),
      openedAt: Value(openedAt),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
    );
  }

  factory VisitHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VisitHistoryData(
      id: serializer.fromJson<int>(json['id']),
      openedAt: serializer.fromJson<DateTime>(json['openedAt']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'openedAt': serializer.toJson<DateTime>(openedAt),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
    };
  }

  VisitHistoryData copyWith({
    int? id,
    DateTime? openedAt,
    Value<DateTime?> closedAt = const Value.absent(),
  }) => VisitHistoryData(
    id: id ?? this.id,
    openedAt: openedAt ?? this.openedAt,
    closedAt: closedAt.present ? closedAt.value : this.closedAt,
  );
  VisitHistoryData copyWithCompanion(VisitHistoryCompanion data) {
    return VisitHistoryData(
      id: data.id.present ? data.id.value : this.id,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VisitHistoryData(')
          ..write('id: $id, ')
          ..write('openedAt: $openedAt, ')
          ..write('closedAt: $closedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, openedAt, closedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VisitHistoryData &&
          other.id == this.id &&
          other.openedAt == this.openedAt &&
          other.closedAt == this.closedAt);
}

class VisitHistoryCompanion extends UpdateCompanion<VisitHistoryData> {
  final Value<int> id;
  final Value<DateTime> openedAt;
  final Value<DateTime?> closedAt;
  const VisitHistoryCompanion({
    this.id = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.closedAt = const Value.absent(),
  });
  VisitHistoryCompanion.insert({
    this.id = const Value.absent(),
    required DateTime openedAt,
    this.closedAt = const Value.absent(),
  }) : openedAt = Value(openedAt);
  static Insertable<VisitHistoryData> custom({
    Expression<int>? id,
    Expression<DateTime>? openedAt,
    Expression<DateTime>? closedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (openedAt != null) 'opened_at': openedAt,
      if (closedAt != null) 'closed_at': closedAt,
    });
  }

  VisitHistoryCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? openedAt,
    Value<DateTime?>? closedAt,
  }) {
    return VisitHistoryCompanion(
      id: id ?? this.id,
      openedAt: openedAt ?? this.openedAt,
      closedAt: closedAt ?? this.closedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitHistoryCompanion(')
          ..write('id: $id, ')
          ..write('openedAt: $openedAt, ')
          ..write('closedAt: $closedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SensorLogsTable sensorLogs = $SensorLogsTable(this);
  late final $PetStateTable petState = $PetStateTable(this);
  late final $VisitHistoryTable visitHistory = $VisitHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sensorLogs,
    petState,
    visitHistory,
  ];
}

typedef $$SensorLogsTableCreateCompanionBuilder =
    SensorLogsCompanion Function({
      Value<int> id,
      Value<double?> accelerometerX,
      Value<double?> accelerometerY,
      Value<double?> accelerometerZ,
      Value<double?> lightLevel,
      Value<int?> batteryLevel,
      Value<int?> stepCount,
      required DateTime timestamp,
    });
typedef $$SensorLogsTableUpdateCompanionBuilder =
    SensorLogsCompanion Function({
      Value<int> id,
      Value<double?> accelerometerX,
      Value<double?> accelerometerY,
      Value<double?> accelerometerZ,
      Value<double?> lightLevel,
      Value<int?> batteryLevel,
      Value<int?> stepCount,
      Value<DateTime> timestamp,
    });

class $$SensorLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SensorLogsTable> {
  $$SensorLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accelerometerX => $composableBuilder(
    column: $table.accelerometerX,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accelerometerY => $composableBuilder(
    column: $table.accelerometerY,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accelerometerZ => $composableBuilder(
    column: $table.accelerometerZ,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lightLevel => $composableBuilder(
    column: $table.lightLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepCount => $composableBuilder(
    column: $table.stepCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SensorLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SensorLogsTable> {
  $$SensorLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accelerometerX => $composableBuilder(
    column: $table.accelerometerX,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accelerometerY => $composableBuilder(
    column: $table.accelerometerY,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accelerometerZ => $composableBuilder(
    column: $table.accelerometerZ,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lightLevel => $composableBuilder(
    column: $table.lightLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepCount => $composableBuilder(
    column: $table.stepCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SensorLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SensorLogsTable> {
  $$SensorLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get accelerometerX => $composableBuilder(
    column: $table.accelerometerX,
    builder: (column) => column,
  );

  GeneratedColumn<double> get accelerometerY => $composableBuilder(
    column: $table.accelerometerY,
    builder: (column) => column,
  );

  GeneratedColumn<double> get accelerometerZ => $composableBuilder(
    column: $table.accelerometerZ,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lightLevel => $composableBuilder(
    column: $table.lightLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stepCount =>
      $composableBuilder(column: $table.stepCount, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$SensorLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SensorLogsTable,
          SensorLog,
          $$SensorLogsTableFilterComposer,
          $$SensorLogsTableOrderingComposer,
          $$SensorLogsTableAnnotationComposer,
          $$SensorLogsTableCreateCompanionBuilder,
          $$SensorLogsTableUpdateCompanionBuilder,
          (
            SensorLog,
            BaseReferences<_$AppDatabase, $SensorLogsTable, SensorLog>,
          ),
          SensorLog,
          PrefetchHooks Function()
        > {
  $$SensorLogsTableTableManager(_$AppDatabase db, $SensorLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SensorLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SensorLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SensorLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double?> accelerometerX = const Value.absent(),
                Value<double?> accelerometerY = const Value.absent(),
                Value<double?> accelerometerZ = const Value.absent(),
                Value<double?> lightLevel = const Value.absent(),
                Value<int?> batteryLevel = const Value.absent(),
                Value<int?> stepCount = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
              }) => SensorLogsCompanion(
                id: id,
                accelerometerX: accelerometerX,
                accelerometerY: accelerometerY,
                accelerometerZ: accelerometerZ,
                lightLevel: lightLevel,
                batteryLevel: batteryLevel,
                stepCount: stepCount,
                timestamp: timestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double?> accelerometerX = const Value.absent(),
                Value<double?> accelerometerY = const Value.absent(),
                Value<double?> accelerometerZ = const Value.absent(),
                Value<double?> lightLevel = const Value.absent(),
                Value<int?> batteryLevel = const Value.absent(),
                Value<int?> stepCount = const Value.absent(),
                required DateTime timestamp,
              }) => SensorLogsCompanion.insert(
                id: id,
                accelerometerX: accelerometerX,
                accelerometerY: accelerometerY,
                accelerometerZ: accelerometerZ,
                lightLevel: lightLevel,
                batteryLevel: batteryLevel,
                stepCount: stepCount,
                timestamp: timestamp,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SensorLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SensorLogsTable,
      SensorLog,
      $$SensorLogsTableFilterComposer,
      $$SensorLogsTableOrderingComposer,
      $$SensorLogsTableAnnotationComposer,
      $$SensorLogsTableCreateCompanionBuilder,
      $$SensorLogsTableUpdateCompanionBuilder,
      (SensorLog, BaseReferences<_$AppDatabase, $SensorLogsTable, SensorLog>),
      SensorLog,
      PrefetchHooks Function()
    >;
typedef $$PetStateTableCreateCompanionBuilder =
    PetStateCompanion Function({
      Value<int> id,
      Value<int> hunger,
      Value<int> energy,
      Value<int> mood,
      Value<int> loneliness,
      Value<int> alertness,
      Value<int> health,
      required DateTime lastUpdated,
    });
typedef $$PetStateTableUpdateCompanionBuilder =
    PetStateCompanion Function({
      Value<int> id,
      Value<int> hunger,
      Value<int> energy,
      Value<int> mood,
      Value<int> loneliness,
      Value<int> alertness,
      Value<int> health,
      Value<DateTime> lastUpdated,
    });

class $$PetStateTableFilterComposer
    extends Composer<_$AppDatabase, $PetStateTable> {
  $$PetStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hunger => $composableBuilder(
    column: $table.hunger,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energy => $composableBuilder(
    column: $table.energy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get loneliness => $composableBuilder(
    column: $table.loneliness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alertness => $composableBuilder(
    column: $table.alertness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get health => $composableBuilder(
    column: $table.health,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PetStateTableOrderingComposer
    extends Composer<_$AppDatabase, $PetStateTable> {
  $$PetStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hunger => $composableBuilder(
    column: $table.hunger,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energy => $composableBuilder(
    column: $table.energy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get loneliness => $composableBuilder(
    column: $table.loneliness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alertness => $composableBuilder(
    column: $table.alertness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get health => $composableBuilder(
    column: $table.health,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PetStateTableAnnotationComposer
    extends Composer<_$AppDatabase, $PetStateTable> {
  $$PetStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get hunger =>
      $composableBuilder(column: $table.hunger, builder: (column) => column);

  GeneratedColumn<int> get energy =>
      $composableBuilder(column: $table.energy, builder: (column) => column);

  GeneratedColumn<int> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<int> get loneliness => $composableBuilder(
    column: $table.loneliness,
    builder: (column) => column,
  );

  GeneratedColumn<int> get alertness =>
      $composableBuilder(column: $table.alertness, builder: (column) => column);

  GeneratedColumn<int> get health =>
      $composableBuilder(column: $table.health, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$PetStateTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PetStateTable,
          PetStateData,
          $$PetStateTableFilterComposer,
          $$PetStateTableOrderingComposer,
          $$PetStateTableAnnotationComposer,
          $$PetStateTableCreateCompanionBuilder,
          $$PetStateTableUpdateCompanionBuilder,
          (
            PetStateData,
            BaseReferences<_$AppDatabase, $PetStateTable, PetStateData>,
          ),
          PetStateData,
          PrefetchHooks Function()
        > {
  $$PetStateTableTableManager(_$AppDatabase db, $PetStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> hunger = const Value.absent(),
                Value<int> energy = const Value.absent(),
                Value<int> mood = const Value.absent(),
                Value<int> loneliness = const Value.absent(),
                Value<int> alertness = const Value.absent(),
                Value<int> health = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
              }) => PetStateCompanion(
                id: id,
                hunger: hunger,
                energy: energy,
                mood: mood,
                loneliness: loneliness,
                alertness: alertness,
                health: health,
                lastUpdated: lastUpdated,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> hunger = const Value.absent(),
                Value<int> energy = const Value.absent(),
                Value<int> mood = const Value.absent(),
                Value<int> loneliness = const Value.absent(),
                Value<int> alertness = const Value.absent(),
                Value<int> health = const Value.absent(),
                required DateTime lastUpdated,
              }) => PetStateCompanion.insert(
                id: id,
                hunger: hunger,
                energy: energy,
                mood: mood,
                loneliness: loneliness,
                alertness: alertness,
                health: health,
                lastUpdated: lastUpdated,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PetStateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PetStateTable,
      PetStateData,
      $$PetStateTableFilterComposer,
      $$PetStateTableOrderingComposer,
      $$PetStateTableAnnotationComposer,
      $$PetStateTableCreateCompanionBuilder,
      $$PetStateTableUpdateCompanionBuilder,
      (
        PetStateData,
        BaseReferences<_$AppDatabase, $PetStateTable, PetStateData>,
      ),
      PetStateData,
      PrefetchHooks Function()
    >;
typedef $$VisitHistoryTableCreateCompanionBuilder =
    VisitHistoryCompanion Function({
      Value<int> id,
      required DateTime openedAt,
      Value<DateTime?> closedAt,
    });
typedef $$VisitHistoryTableUpdateCompanionBuilder =
    VisitHistoryCompanion Function({
      Value<int> id,
      Value<DateTime> openedAt,
      Value<DateTime?> closedAt,
    });

class $$VisitHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $VisitHistoryTable> {
  $$VisitHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VisitHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $VisitHistoryTable> {
  $$VisitHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VisitHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $VisitHistoryTable> {
  $$VisitHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);
}

class $$VisitHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VisitHistoryTable,
          VisitHistoryData,
          $$VisitHistoryTableFilterComposer,
          $$VisitHistoryTableOrderingComposer,
          $$VisitHistoryTableAnnotationComposer,
          $$VisitHistoryTableCreateCompanionBuilder,
          $$VisitHistoryTableUpdateCompanionBuilder,
          (
            VisitHistoryData,
            BaseReferences<_$AppDatabase, $VisitHistoryTable, VisitHistoryData>,
          ),
          VisitHistoryData,
          PrefetchHooks Function()
        > {
  $$VisitHistoryTableTableManager(_$AppDatabase db, $VisitHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VisitHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VisitHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VisitHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> openedAt = const Value.absent(),
                Value<DateTime?> closedAt = const Value.absent(),
              }) => VisitHistoryCompanion(
                id: id,
                openedAt: openedAt,
                closedAt: closedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime openedAt,
                Value<DateTime?> closedAt = const Value.absent(),
              }) => VisitHistoryCompanion.insert(
                id: id,
                openedAt: openedAt,
                closedAt: closedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VisitHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VisitHistoryTable,
      VisitHistoryData,
      $$VisitHistoryTableFilterComposer,
      $$VisitHistoryTableOrderingComposer,
      $$VisitHistoryTableAnnotationComposer,
      $$VisitHistoryTableCreateCompanionBuilder,
      $$VisitHistoryTableUpdateCompanionBuilder,
      (
        VisitHistoryData,
        BaseReferences<_$AppDatabase, $VisitHistoryTable, VisitHistoryData>,
      ),
      VisitHistoryData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SensorLogsTableTableManager get sensorLogs =>
      $$SensorLogsTableTableManager(_db, _db.sensorLogs);
  $$PetStateTableTableManager get petState =>
      $$PetStateTableTableManager(_db, _db.petState);
  $$VisitHistoryTableTableManager get visitHistory =>
      $$VisitHistoryTableTableManager(_db, _db.visitHistory);
}
