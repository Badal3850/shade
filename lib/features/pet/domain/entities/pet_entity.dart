import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
  final int hunger;
  final int energy;
  final int mood;
  final int loneliness;
  final int alertness;

  const PetEntity({
    this.hunger = 50,
    this.energy = 50,
    this.mood = 50,
    this.loneliness = 50,
    this.alertness = 50,
  });

  PetEntity copyWith({
    int? hunger,
    int? energy,
    int? mood,
    int? loneliness,
    int? alertness,
  }) {
    return PetEntity(
      hunger: hunger ?? this.hunger,
      energy: energy ?? this.energy,
      mood: mood ?? this.mood,
      loneliness: loneliness ?? this.loneliness,
      alertness: alertness ?? this.alertness,
    );
  }

  @override
  List<Object?> get props => [hunger, energy, mood, loneliness, alertness];
}
