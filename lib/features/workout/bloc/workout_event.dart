part of 'workout_bloc.dart';

@immutable
sealed class WorkoutEvent {}

final class WorkoutInitialEvent extends WorkoutEvent {}

final class WorkoutSelectedEvent extends WorkoutEvent {
  final Workout selectedWorkout;

  WorkoutSelectedEvent({required this.selectedWorkout});
}

final class WorkoutCompletedEvent extends WorkoutEvent {}
