import 'package:sportify/features/streak/streaks_repository.dart';

class Workout {
  int id;
  String name;
  Rank difficulty;
  bool isOutside;

  Workout({
    required this.id,
    required this.name,
    required this.difficulty,
    required this.isOutside,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'difficulty': difficulty.toInt(),
      'is_outside': isOutside,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      name: map['name'],
      difficulty: Rank.values[map['difficulty']],
      isOutside: map['is_outside'],
    );
  }
}
