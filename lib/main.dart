import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportify/features/auth/bloc/auth_repository.dart';
import 'package:sportify/features/auth/bloc/auth_bloc.dart';
import 'package:sportify/features/streak/streaks_repository.dart';
import 'package:sportify/features/weather/weather_repository.dart';
import 'package:sportify/features/workout/bloc/workout_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// TODO Персонализированные тренировки
// TODO Выполнение целей и полосы тренеровок
// TODO Погодные данные с API
// TODO Выбор тренировки зависит от погоды

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO replace with an actual url and anonKey
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
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
                  streaksRepository: context.read<StreaksRepository>(),
                  weatherRepository: context.read<WeatherRepository>(),
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
