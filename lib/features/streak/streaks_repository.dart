import 'package:sportify/features/workout/bloc/workout_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum Rank {
  beginner,
  intermediate,
  advanced,
  pro;

  @override
  String toString() {
    switch (this) {
      case Rank.beginner:
        return "Beginner";
      case Rank.intermediate:
        return "Intermediate";
      case Rank.advanced:
        return "Advanced";
      case Rank.pro:
        return "Pro";
    }
  }

  int toInt() {
    switch (this) {
      case Rank.beginner:
        return 0;
      case Rank.intermediate:
        return 1;
      case Rank.advanced:
        return 2;
      case Rank.pro:
        return 3;
    }
  }

  factory Rank.fromStreak(int days) {
    switch (days) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        return Rank.beginner;
      case 8:
      case 9:
      case 10:
      case 11:
      case 12:
      case 13:
      case 14:
        return Rank.intermediate;
      case 15:
      case 16:
      case 17:
      case 18:
      case 19:
      case 20:
      case 21:
      case 22:
      case 23:
      case 24:
      case 25:
      case 26:
      case 27:
      case 28:
        return Rank.advanced;
      default:
        return Rank.pro;
    }
  }
}

class Streak {
  int id;
  int user_id;
  int workout_id;
  DateTime created_at;
  DateTime? completed_at;

  Streak({
    required this.id,
    required this.user_id,
    required this.workout_id,
    required this.created_at,
    this.completed_at,
  });
}

class StreaksRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<Rank> getRank(int userId) async {
    var response =
        await _client
            .from('streaks')
            .select('1')
            .eq('user_id', userId)
            .lte('created_at', "now() - interval '30' day")
            .count();

    return Rank.fromStreak(response.count);
  }

  Future<void> setCurrentWorkout(int userId, Workout workout) async {
    await _client.from('streaks').insert({
      'user_id': userId,
      'workout_id': workout.id,
    });
  }

  Future<Workout?> getCurrentWorkout(int userId) async {
    var streakMap = await _client.from('streaks').select().single();
    if (streakMap.isEmpty) {
      return null;
    }

    var workoutMap =
        await _client
            .from('workouts')
            .select()
            .eq('id', streakMap['id'])
            .single();

    return Workout.fromMap(workoutMap);
  }
}
