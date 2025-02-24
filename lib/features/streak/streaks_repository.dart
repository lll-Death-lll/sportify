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
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        return Rank.intermediate;
      case 8:
      case 9:
      case 10:
      case 11:
      case 12:
      case 13:
      case 14:
      case 15:
      case 16:
      case 17:
      case 18:
      case 19:
      case 20:
      case 21:
        return Rank.advanced;
      default:
        return Rank.pro;
    }
  }
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
}
