class Workout {
  int id;
  String name;
  Difficulty difficulty;
  bool isOutside;

  Workout({
    required this.id,
    required this.name,
    required this.difficulty,
    required this.isOutside,
  });
}

enum Difficulty {
  beginner,
  intermediate,
  advanced,
  pro;

  @override
  String toString() {
    switch (this) {
      case Difficulty.beginner:
        return "Beginner";
      case Difficulty.intermediate:
        return "Intermediate";
      case Difficulty.advanced:
        return "Advanced";
      case Difficulty.pro:
        return "Pro";
    }
  }

  int toInt() {
    switch (this) {
      case Difficulty.beginner:
        return 0;
      case Difficulty.intermediate:
        return 1;
      case Difficulty.advanced:
        return 2;
      case Difficulty.pro:
        return 3;
    }
  }
}
