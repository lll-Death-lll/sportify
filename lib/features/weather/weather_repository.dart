import 'package:requests/requests.dart';

class WeatherRepository {
  static const String _apiURL =
      'https://api.open-meteo.com/v1/forecast?latitude=53.2001&longitude=50.15&current=weather_code&timezone=auto&forecast_days=1';

  Future<WeatherCondition> getWeather() async {
    var response = await Requests.get(_apiURL);

    int code = response.json()['current']['weather_code'];

    return WeatherCondition.fromWMOCode(code);
  }
}

enum WeatherCondition {
  clear,
  cloudy,
  fog,
  drizzle,
  rain,
  snow,
  thunderstorm,
  unknown;

  bool isGood() {
    switch (this) {
      case WeatherCondition.clear:
      case WeatherCondition.cloudy:
        return true;
      case WeatherCondition.fog:
      case WeatherCondition.drizzle:
      case WeatherCondition.rain:
      case WeatherCondition.snow:
      case WeatherCondition.thunderstorm:
      case WeatherCondition.unknown:
        return false;
    }
  }

  factory WeatherCondition.fromWMOCode(int code) {
    switch (code) {
      case 0:
        return WeatherCondition.clear;
      case 1:
      case 2:
      case 3:
        return WeatherCondition.cloudy;
      case 45:
      case 48:
        return WeatherCondition.fog;
      case 51:
      case 52:
      case 53:
      case 54:
      case 55:
      case 56:
      case 57:
        return WeatherCondition.drizzle;
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
        return WeatherCondition.rain;
      case 71:
      case 73:
      case 75:
      case 77:
        return WeatherCondition.snow;
      case 80:
      case 81:
      case 82:
        return WeatherCondition.rain;
      case 85:
      case 86:
        return WeatherCondition.snow;
      case 95:
      case 96:
      case 99:
        return WeatherCondition.thunderstorm;
      default:
        return WeatherCondition.unknown;
    }
  }
}
