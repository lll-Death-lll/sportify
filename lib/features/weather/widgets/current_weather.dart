import 'package:flutter/material.dart';
import 'package:sportify/features/weather/open_meteo.dart';

class CurrentWeather extends StatelessWidget {
  WeatherCondition weatherCondition;

  CurrentWeather({super.key, required this.weatherCondition});

  @override
  Widget build(BuildContext context) {
    Weather weather = Weather(condition: weatherCondition);

    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(weather.getIcon()),
            title: Text(weather.getName()),
            subtitle: Text(
              weather.isGood
                  ? 'Погода хорошая, можно заниматься'
                  : "Плохая погода, останьтесь дома",
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
    switch (condition) {
      case WeatherCondition.clear:
        isGood = true;
      case WeatherCondition.cloudy:
        isGood = true;
      case WeatherCondition.fog:
        isGood = false;
      case WeatherCondition.drizzle:
        isGood = false;
      case WeatherCondition.rain:
        isGood = false;
      case WeatherCondition.snow:
        isGood = false;
      case WeatherCondition.thunderstorm:
        isGood = false;
      case WeatherCondition.unknown:
        isGood = false;
    }
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
