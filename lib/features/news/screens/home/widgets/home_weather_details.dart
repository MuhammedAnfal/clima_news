import 'package:clima_news/features/news/models/current_weather_data.dart';
import 'package:clima_news/features/news/screens/home/widgets/weather_metrics.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';

class HomeWeatherDetails extends StatelessWidget {
  const HomeWeatherDetails({
    super.key,
    required Animation<double> scaleAnimation,
    required this.currentWeatherData,
  }) : _scaleAnimation = scaleAnimation;

  final CurrentWeatherData currentWeatherData;
  final Animation<double> _scaleAnimation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.screenHeight * 0.04),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.white,
        ),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(scale: _scaleAnimation.value, child: child);
          },
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 10,

            children: [
              WeatherMetric(
                value: currentWeatherData.current.pressure!.toInt().toString(),
                label: AppStrings.pressureText,
                icon: Icons.speed,
              ),
              WeatherMetric(
                value: currentWeatherData.current.uvi!.toInt().toString(),
                label: AppStrings.uvText,
                icon: Icons.wb_sunny,
              ),
              WeatherMetric(
                value: currentWeatherData.current.humidity!.toInt().toString(),
                label: AppStrings.humidityText,
                icon: Icons.water_drop,
              ),
              WeatherMetric(
                value:
                    '${currentWeatherData.current.windSpeed!.toInt().toString()} km/h',
                label: AppStrings.windText,
                icon: Icons.air,
              ),
              WeatherMetric(
                value:
                    currentWeatherData.current.visibility!.toInt().toString(),
                label: AppStrings.visibilityText,
                icon: Icons.visibility,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
