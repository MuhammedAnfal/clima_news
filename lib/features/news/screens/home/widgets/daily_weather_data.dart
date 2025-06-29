import 'package:clima_news/features/news/models/daily_weather_data.dart';
import 'package:clima_news/features/news/screens/home/widgets/weather_forecast_tile.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForecastTile extends StatelessWidget {
  const ForecastTile({super.key, required this.dailyWeatherData});
  final DailyWeatherData dailyWeatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.screenWidth * 0.03),
      margin: EdgeInsets.only(top: context.screenHeight * 0.02),
      height: context.screenHeight * 0.6,
      width: context.screenWidth * 0.9,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Next 7 Days',
            style: GoogleFonts.poppins(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: context.screenWidth * 0.04,
            ),
          ),

          //-- list tile of forecast weather
          ForecastDetailsTile(dailyWeatherData: dailyWeatherData),
        ],
      ),
    );
  }
}
