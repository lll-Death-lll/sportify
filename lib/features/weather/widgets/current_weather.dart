import 'package:flutter/material.dart';
import 'package:sportify/features/weather/weather_repository.dart';

class CurrentWeather extends StatelessWidget {
  final WeatherCondition weatherCondition;

  const CurrentWeather({super.key, required this.weatherCondition});

  @override
  Widget build(BuildContext context) {
    final Weather weather = Weather(condition: weatherCondition);

    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(weather.getIcon()),
            title: Text(weather.getName()),
            subtitle: Text(
              weather.isGood
                  ? 'Погода хорошая, можно заниматься на улице'
                  : "Плохая погода, позанимайтесь дома",
            ),
          ),
        ],
      ),
    );
  }
}

class Weather {
  WeatherCondition condition;
  bool isGood = false;

  Weather({required this.condition}) {
    isGood = condition.isGood();
  }

  IconData getIcon() {
    switch (condition) {
      case WeatherCondition.clear:
        return Icons.sunny;
      case WeatherCondition.cloudy:
        return Icons.cloud;
      case WeatherCondition.fog:
        return Icons.filter_drama;
      case WeatherCondition.drizzle:
        return Icons.grain;
      case WeatherCondition.rain:
        return Icons.water_drop;
      case WeatherCondition.snow:
        return Icons.ac_unit;
      case WeatherCondition.thunderstorm:
        return Icons.thunderstorm;
      case WeatherCondition.unknown:
      default:
        return Icons.question_mark;
    }
  }

  String getName() {
    switch (condition) {
      case WeatherCondition.clear:
        return "Ясно";
      case WeatherCondition.cloudy:
        return "Облачно";
      case WeatherCondition.fog:
        return "Туман";
      case WeatherCondition.drizzle:
        return "Морось";
      case WeatherCondition.rain:
        return "Дождь";
      case WeatherCondition.snow:
        return "Снер";
      case WeatherCondition.thunderstorm:
        return "Гроза";
      case WeatherCondition.unknown:
      default:
        return "Неизвестно";
    }
  }
}
