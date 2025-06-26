class HourlyWeatherData {
  final List<Hourly> hourly;

  HourlyWeatherData({required this.hourly});

  factory HourlyWeatherData.fromJson(Map<String, dynamic> json) =>
      HourlyWeatherData(
        hourly: List<Hourly>.from(
          json['hourly'].map((e) => Hourly.fromJson(e)),
        ),
      );
}

class Hourly {
  final int? dt;
  final double? temp;
  final List<Weather>? weather;

  Hourly({this.dt, this.temp, this.weather});

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
    dt: json['dt'] as int? ?? 0,
    temp: (json['temp'] as num?)?.toDouble(),
    weather:
        (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
  );
}

class Weather {
  final int? id;
  final String? icon;

  Weather({this.id, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      Weather(id: json['id'] as int? ?? 0, icon: json['icon'] as String? ?? "");
}
