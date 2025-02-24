import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sportify/features/streak/streaks_repository.dart';
import 'package:sportify/features/weather/weather_repository.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  StreaksRepository streaksRepository;
  WeatherRepository weatherRepository;

  WorkoutBloc({
    required this.streaksRepository,
    required this.weatherRepository,
  }) : super(WorkoutInitial()) {
    on<WorkoutEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
