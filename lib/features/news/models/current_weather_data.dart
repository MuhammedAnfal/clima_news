//-- creating for getting api response
class CurrentWeatherData {
  final Current current;
  CurrentWeatherData({required this.current});
  factory CurrentWeatherData.fromJson(Map<String, dynamic> json) =>
      CurrentWeatherData(current: Current.fromJson(json['current']));
}

class Current {
  int? dt;
  int? sunrise;
  int? sunset;
  double? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? uvi;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  double? windGust;
  List<Weather>? weather;

  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    dt: json['dt'] as int?,
    sunrise: json['sunrise'] as int?,
    sunset: json['sunset'] as int?,
    temp: (json['temp'] as num?)?.toDouble(),
    feelsLike: (json['feels_like'] as num?)?.toDouble(),
    pressure: json['pressure'] as int?,
    humidity: json['humidity'] as int?,
    dewPoint: (json['dew_point'] as num?)?.toDouble(),
    uvi: (json['uvi'] as num?)?.toDouble(),
    clouds: json['clouds'] as int?,
    visibility: json['visibility'] as int?,
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    windDeg: json['wind_deg'] as int?,
    windGust: (json['wind_gust'] as num?)?.toDouble(),
    weather:
        (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  static Current empty() => Current(
    clouds: 0,
    dewPoint: 0.0,
    dt: 0,
    feelsLike: 0.0,
    humidity: 0,
    pressure: 0,
    sunrise: 0,
    sunset: 0,
    temp: 0.0,
    uvi: 0.0,
    visibility: 0,
    weather: [],
    windDeg: 0,
    windGust: 0.0,
    windSpeed: 0.0,
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'sunrise': sunrise,
    'sunset': sunset,
    'temp': temp,
    'feels_like': feelsLike,
    'pressure': pressure,
    'humidity': humidity,
    'dew_point': dewPoint,
    'uvi': uvi,
    'clouds': clouds,
    'visibility': visibility,
    'wind_speed': windSpeed,
    'wind_deg': windDeg,
    'wind_gust': windGust,
    'weather': weather?.map((e) => e.toJson()).toList(),
  };
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json['id'] as int,
    main: json['main'] as String,
    description: json['description'] as String?,
    icon: json['icon'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };
}
