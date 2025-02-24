part of 'workout_bloc.dart';

@immutable
sealed class WorkoutState {}

@immutable
sealed class WorkoutActionState extends WorkoutState {}

final class WorkoutInitial extends WorkoutState {}

final class WorkoutLoadingState extends WorkoutState {}

final class WorkoutAvailableState extends WorkoutState {
  List<Workout> availableWorkouts;

  WorkoutAvailableState({required this.availableWorkouts});
}

final class WorkoutInProgressState extends WorkoutState {
  Workout workout;

  WorkoutInProgressState({required this.workout});
}

final class WorkoutCompletedState extends WorkoutState {
  Workout workout;

  WorkoutCompletedState({required this.workout});
}
