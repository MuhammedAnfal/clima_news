import 'package:clima_news/features/news/models/current_weather_data.dart';
import 'package:clima_news/features/news/models/hourly_weather_data.dart';
import 'package:clima_news/features/news/models/search_weather_model.dart';

class WeatherData {
  final CurrentWeatherData? current;
  final HourlyWeatherData? hourly;
  // final SearchWeatherModel? serach;

  WeatherData([this.current, this.hourly]);

  //-- creating function to fetching values
  CurrentWeatherData getCurrentWeather() => current!;
  HourlyWeatherData getHourlytWeather() => hourly!;
}
