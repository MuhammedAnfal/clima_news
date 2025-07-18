import 'package:clima_news/features/news/models/current_weather_data.dart';
import 'package:clima_news/features/news/models/daily_weather_data.dart';
import 'package:clima_news/features/news/models/hourly_weather_data.dart';

class WeatherData {
  final CurrentWeatherData? current;
  final HourlyWeatherData? hourly;
  final DailyWeatherData? daily;
  // final SearchWeatherModel? serach;

  WeatherData([this.current, this.hourly, this.daily]);

  //-- creating function to fetching values
  CurrentWeatherData getCurrentWeather() => current!;
  HourlyWeatherData getHourlytWeather() => hourly!;
  DailyWeatherData getDailyWeather() => daily!;
}
