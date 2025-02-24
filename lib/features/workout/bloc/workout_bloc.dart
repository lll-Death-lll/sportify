import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sportify/features/auth/bloc/auth_repository.dart';
import 'package:sportify/features/streak/streaks_repository.dart';
import 'package:sportify/features/weather/weather_repository.dart';
import 'package:sportify/features/workout/bloc/workout_repository.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  AuthRepository authRepository;
  StreaksRepository streaksRepository;
  WeatherRepository weatherRepository;
  WorkoutRepository workoutRepository;

  Workout? currentWorkout;

  WorkoutBloc({
    required this.authRepository,
    required this.streaksRepository,
    required this.weatherRepository,
    required this.workoutRepository,
  }) : super(WorkoutInitial()) {
    on<WorkoutInitialEvent>((event, emit) async {
      // TODO: implement event handler
      emit(WorkoutLoadingState());

      var userId = await authRepository.userId();
      if (userId == null) {
        return;
      }

      var userRank = await streaksRepository.getRank(userId);

      var weatherCondition = await weatherRepository.getWeather();

      List<Workout> availableWorkouts = await workoutRepository.getWorkouts(
        userId,
        userRank,
        weatherCondition,
      );

      emit(WorkoutAvailableState(availableWorkouts: availableWorkouts));
    });
    on<WorkoutSelectedEvent>((event, emit) {
      // TODO add selection logic to streaks
      currentWorkout = event.selectedWorkout;

      emit(WorkoutInProgressState(workout: event.selectedWorkout));
    });
    on<WorkoutCompletedEvent>((event, emit) {
      // TODO add completion logic to streaks
      if (currentWorkout != null) {
        emit(WorkoutCompletedState(workout: currentWorkout!));
      }
    });
  }
}
