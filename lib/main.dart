import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportify/features/auth/bloc/auth_repository.dart';
import 'package:sportify/features/auth/bloc/auth_bloc.dart';
import 'package:sportify/features/streak/streaks_repository.dart';
import 'package:sportify/features/weather/weather_repository.dart';
import 'package:sportify/features/workout/bloc/workout_bloc.dart';
import 'package:sportify/features/workout/bloc/workout_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

// TODO Персонализированные тренировки
// TODO Выполнение целей и полосы тренеровок
// TODO Погодные данные с API
// TODO Выбор тренировки зависит от погоды

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await supabase.Supabase.initialize(
    url: 'https://rbkuxdopyphmekasmxdh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJia3V4ZG9weXBobWVrYXNteGRoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA0Njc3MjEsImV4cCI6MjA1NjA0MzcyMX0.bZaF_wded-epNsCOFJLoe-GnXTGpK1RzVnxtBbBg0ZI',
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
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Profile();
            },
          ),
        ),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userId;
  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    supabase.Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      setState(() {
        userId = event.session?.user.id;
      });
    });

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {},
      child: Column(
        children: [
          Center(child: Text(userId ?? "")),
          Visibility(
            visible: userId == null,
            child: TextButton(
              onPressed: () {
                authBloc.add(AuthSignInEvent());
              },
              child: Text('Authenticate'),
            ),
          ),
        ],
      ),
    );
  }
}
