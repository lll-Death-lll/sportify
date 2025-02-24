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
}

class StreaksRepository {
  final SupabaseClient _client = Supabase.instance.client;
}
