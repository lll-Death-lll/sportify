import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportify/features/auth/bloc/auth_repository.dart';
import 'package:sportify/features/auth/bloc/auth_bloc.dart';
import 'package:sportify/features/streak/streaks_repository.dart';
import 'package:sportify/features/weather/weather_repository.dart';
import 'package:sportify/features/workout/bloc/workout_bloc.dart';
import 'package:sportify/features/workout/bloc/workout_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// TODO Персонализированные тренировки
// TODO Выполнение целей и полосы тренеровок
// TODO Погодные данные с API
// TODO Выбор тренировки зависит от погоды

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ylydmkeeqyuloeytfyez.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlseWRta2VlcXl1bG9leXRmeWV6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA0NjQ5ODQsImV4cCI6MjA1NjA0MDk4NH0.u3Y476Ym5J_3xB7CjhTkaf_YX6WOmYK7MQ_e3tmbDio',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => AuthRepository()),
          RepositoryProvider(create: (context) => StreaksRepository()),
          RepositoryProvider(create: (context) => WeatherRepository()),
          RepositoryProvider(create: (context) => WorkoutRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (BuildContext context) {
                return AuthBloc(authRepository: context.read<AuthRepository>());
              },
            ),
            BlocProvider(
              create: (BuildContext context) {
                return WorkoutBloc(
                  authRepository: context.read<AuthRepository>(),
                  streaksRepository: context.read<StreaksRepository>(),
                  weatherRepository: context.read<WeatherRepository>(),
                  workoutRepository: context.read<WorkoutRepository>(),
                );
              },
            ),
          ],
          child: Container(),
        ),
      ),
    );
  }
}
