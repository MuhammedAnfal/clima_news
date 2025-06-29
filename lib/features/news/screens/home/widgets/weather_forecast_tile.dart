import 'package:clima_news/features/news/models/daily_weather_data.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ForecastDetailsTile extends StatelessWidget {
  final DailyWeatherData dailyWeatherData;
  const ForecastDetailsTile({super.key, required this.dailyWeatherData});

  String generateDate(final day) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    var formattedDate = DateFormat('EEE').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.52,
      width: context.screenWidth * 0.9,
      // color: AppColors.black,
      child: ListView.builder(
        itemCount: dailyWeatherData.daily.length,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: context.screenHeight * 0.01),
            child: Container(
              height: context.screenHeight * 0.1,
              padding: EdgeInsets.all(context.screenWidth * 0.03),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.lightBackground,
              ),
              margin: EdgeInsets.only(bottom: context.screenWidth * 0.02),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    generateDate(dailyWeatherData.daily[index].dt ?? 0),
                    style: GoogleFonts.poppins(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: context.screenWidth * 0.04,
                    ),
                  ),
                  Image.asset(
                    'assets/weather/${dailyWeatherData.daily.first.weather?.first.icon ?? ""}.png',
                    width: 40,
                    height: 40,
                  ),
                  Text(
                    '${dailyWeatherData.daily[index].temp?.max.toString() ?? ''}°C',
                    style: GoogleFonts.poppins(
                      color: AppColors.white,
                      fontSize: context.screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
