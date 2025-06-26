import 'package:clima_news/features/news/controller/home/home_controller.dart';
import 'package:clima_news/features/news/models/current_weather_data.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/image_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WeatherDegreeDetails extends StatelessWidget {
  const WeatherDegreeDetails({
    super.key,
    required Animation<double> slideAnimation,
    required this.currentWeatherData,
  }) : _slideAnimation = slideAnimation;

  final Animation<double> _slideAnimation;
  final CurrentWeatherData currentWeatherData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.screenHeight * 0.02),
      child: AnimatedBuilder(
        animation: _slideAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: child,
          );
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                AppImages.rainyIcon,
                height: context.screenHeight * 0.15,
              ),
              Column(
                children: [
                  Text(
                    currentWeatherData.current.weather!.first.description
                        .toString(),
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${currentWeatherData.current.temp!.toInt().toString()}°' ??
                        "",
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteText,
                      fontWeight: FontWeight.w700,
                      fontSize: context.screenHeight * 0.06,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMd().format(HomeController.instance.now),
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
