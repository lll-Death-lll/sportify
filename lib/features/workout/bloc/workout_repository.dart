import 'package:sportify/features/streak/streaks_repository.dart';
import 'package:sportify/features/weather/weather_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Workout {
  int id;
  String name;
  Rank rank;
  bool isOutside;

  Workout({
    required this.id,
    required this.name,
    required this.rank,
    required this.isOutside,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rank': rank.toInt(),
      'is_outside': isOutside,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      name: map['name'],
      rank: Rank.values[map['rank']],
      isOutside: map['is_outside'],
    );
  }
}

class WorkoutRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Workout>> getWorkouts(
    int userId,
    Rank rank,
    WeatherCondition condition,
  ) async {
    List<Map<String, dynamic>> workoutMaps = await _client
        .from('workouts')
        .select('*')
        .lte('rank', rank.toInt() + 1)
        .eq('is_outside', condition.isGood());

    List<Workout> workouts = [];

    for (var workoutMap in workoutMaps) {
      workouts.add(Workout.fromMap(workoutMap));
    }

    return workouts;
  }
}
