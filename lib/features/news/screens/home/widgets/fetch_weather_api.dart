import 'dart:convert';

import 'package:clima_news/features/news/models/current_weather_data.dart';
import 'package:clima_news/features/news/models/hourly_weather_data.dart';
import 'package:clima_news/features/news/models/weather_data.dart';
import 'package:clima_news/features/utils/constants/api_constants.dart';
import 'package:clima_news/features/utils/popups/loaders.dart';
import 'package:http/http.dart' as http;

class FetchWeatherApi {
  Future<WeatherData> processData(double lat, double long) async {
    try {
      print('1');
      var response = await http.get(Uri.parse(apiUrl(lat, long)));
      print(response.body);
      print('2');

      if (response.statusCode != 200) {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }

      var jsonString = jsonDecode(response.body);
      print(jsonString);
      print('3');

      // Create CurrentWeatherData from the JSON
      var currentWeatherData = CurrentWeatherData.fromJson(jsonString);
      var hourlyWeatherData = HourlyWeatherData.fromJson(jsonString);
      print(hourlyWeatherData.hourly.first.temp);
      print(hourlyWeatherData.hourly.first.dt);
      print('4');

      // Return WeatherData containing the CurrentWeatherData
      return WeatherData(currentWeatherData, hourlyWeatherData);
    } catch (e) {
      Loaders.errorSnackBar(title: e.toString());
      rethrow; // Re-throw the exception so the caller can handle it
    }
  }
}

String apiUrl(double lat, double long) {
  print(lat);
  print(long);
  print('5');
  return "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&appid=$weatherApiKey&units=metric&exclude=minutely";
}
