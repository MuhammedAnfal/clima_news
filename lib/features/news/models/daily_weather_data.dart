class DailyWeatherData {
  List<Daily> daily;

  DailyWeatherData({required this.daily});

  factory DailyWeatherData.fromJson(Map<String, dynamic> json) => DailyWeatherData(
    daily: (List<Daily>.from(json['daily'].map((e) => Daily.fromJson(e)).toList())),
  );
}

class Daily {
  int? dt;
  String? summary;
  Temp? temp;
  List<Weather>? weather;

  Daily({this.dt, this.summary, this.temp, this.weather});

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    dt: json['dt'] as int?,
    summary: json['summary'] as String?,
    temp: json['temp'] == null ? null : Temp.fromJson(json['temp'] as Map<String, dynamic>),
    weather:
        (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'summary': summary,
    'temp': temp?.toJson(),
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

class Temp {
  double? day;
  int? min;
  int? max;
  double? night;
  double? eve;
  double? morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
    day: (json['day'] as num?)?.toDouble(),
    min: (json['min'] as num?)?.round(),
    max: (json['max'] as num?)?.round(),
    night: (json['night'] as num?)?.toDouble(),
    eve: (json['eve'] as num?)?.toDouble(),
    morn: (json['morn'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'day': day,
    'min': min,
    'max': max,
    'night': night,
    'eve': eve,
    'morn': morn,
  };
}
