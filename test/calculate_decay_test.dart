import 'package:flutter_test/flutter_test.dart';
import 'package:shade/features/pet/domain/entities/pet_entity.dart';
import 'package:shade/features/pet/domain/usecases/calculate_decay.dart';

void main() {
  late CalculateDecay calculateDecay;

  setUp(() {
    calculateDecay = CalculateDecay();
  });

  group('CalculateDecay', () {
    test('returns unchanged state when no time has elapsed', () {
      final pet = const PetEntity(hunger: 50, energy: 80, mood: 70);
      final result = calculateDecay(pet, DateTime.now());
      expect(result, equals(pet));
    });

    test('hunger increases over time', () {
      final pet = const PetEntity(hunger: 50);
      final past = DateTime.now().subtract(const Duration(hours: 2));
      final result = calculateDecay(pet, past);
      expect(result.hunger, greaterThan(50));
    });

    test('energy decreases over time', () {
      final pet = const PetEntity(energy: 80);
      final past = DateTime.now().subtract(const Duration(hours: 2));
      final result = calculateDecay(pet, past);
      expect(result.energy, lessThan(80));
    });

    // mood may get a +2 morning-rush boost, so we use lessThanOrEqualTo
    test('mood decreases over time', () {
      final pet = const PetEntity(mood: 80);
      final past = DateTime.now().subtract(const Duration(hours: 2));
      final result = calculateDecay(pet, past);
      expect(result.mood, lessThanOrEqualTo(80));
    });

    test('loneliness increases over time', () {
      final pet = const PetEntity(loneliness: 30);
      final past = DateTime.now().subtract(const Duration(hours: 2));
      final result = calculateDecay(pet, past);
      expect(result.loneliness, greaterThan(30));
    });

    test('alertness decreases over time', () {
      final pet = const PetEntity(alertness: 80);
      final past = DateTime.now().subtract(const Duration(hours: 2));
      final result = calculateDecay(pet, past);
      expect(result.alertness, lessThan(80));
    });

    test('hunger clamps at 100', () {
      final pet = const PetEntity(hunger: 95);
      final past = DateTime.now().subtract(const Duration(hours: 24));
      final result = calculateDecay(pet, past);
      expect(result.hunger, equals(100));
    });

    test('energy clamps at 0', () {
      final pet = const PetEntity(energy: 5);
      final past = DateTime.now().subtract(const Duration(hours: 24));
      final result = calculateDecay(pet, past);
      expect(result.energy, equals(0));
    });

    test('health decays when hunger is critically high', () {
      // hunger >= 90 increments neglectCount, triggering health decay
      final pet = const PetEntity(hunger: 95, health: 100);
      final past = DateTime.now().subtract(const Duration(hours: 2));
      final result = calculateDecay(pet, past);
      expect(result.health, lessThan(100));
    });

    test('health decays when energy is critically low', () {
      // energy <= 10 increments neglectCount, triggering health decay
      final pet = const PetEntity(energy: 5, health: 100);
      final past = DateTime.now().subtract(const Duration(hours: 2));
      final result = calculateDecay(pet, past);
      expect(result.health, lessThan(100));
    });

    test('health stays at 100 when all stats are healthy', () {
      // neglectCount = 0 → health decay rate = 0 * 5.0 = 0
      final pet = const PetEntity(
        hunger: 30,
        energy: 80,
        mood: 70,
        loneliness: 30,
        alertness: 70,
        health: 100,
      );
      final past = DateTime.now().subtract(const Duration(minutes: 30));
      final result = calculateDecay(pet, past);
      expect(result.health, equals(100));
    });

    test('health clamps at 0', () {
      // hunger=100 (neglect) + energy=0 (neglect) + mood=0 (neglect) → neglectCount=3
      final pet = const PetEntity(hunger: 100, energy: 0, mood: 0, health: 5);
      final past = DateTime.now().subtract(const Duration(hours: 24));
      final result = calculateDecay(pet, past);
      expect(result.health, equals(0));
    });
  });
}
