import 'package:clima_news/features/news/controller/home/home_controller.dart';
import 'package:clima_news/features/news/models/hourly_weather_data.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HourlyDataSection extends StatelessWidget {
  HourlyDataSection({super.key, required this.hourlyWeatherData});
  final HourlyWeatherData hourlyWeatherData;
  //--cardIndex
  RxInt cardIndex = HomeController().getIndex();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.screenHeight * 0.005),
      width: context.screenWidth,
      child: Column(
        children: [
          //-- today text
          Text(
            AppStrings.todayText,
            style: GoogleFonts.poppins(
              color: AppColors.whiteText,
              fontWeight: FontWeight.w700,
              fontSize: context.screenWidth * 0.04,
            ),
          ),
          hourlyList(context: context),
        ],
      ),
    );
  }

  Widget hourlyList({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: context.screenHeight * 0.02),
          //-- listview of the hourly weather
          height: context.screenHeight * 0.18,
          width: context.screenWidth * 0.9,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                hourlyWeatherData.hourly.length > 12
                    ? 12
                    : hourlyWeatherData.hourly.length,
            itemBuilder: (context, index) {
              return Obx(
                () => GestureDetector(
                  onTap: () {
                    cardIndex.value = index;
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: context.screenWidth * 0.03),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.02,
                      vertical: context.screenHeight * 0.001,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: cardIndex.value == index ? AppColors.white : null,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.5, 0),
                          color: Colors.white30,
                        ),
                      ],
                    ),

                    //-- seperating the hourly weather
                    child: HourlyDetails(
                      temp: hourlyWeatherData.hourly[index].temp!.toInt(),
                      timeStamp:
                          hourlyWeatherData.hourly[index].weather?.first.id ??
                          0,
                      weatherIcon:
                          hourlyWeatherData.hourly[index].weather?.first.icon ??
                          "",
                      currentIndex: cardIndex.value,
                      index: index,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class HourlyDetails extends StatelessWidget {
  final int? temp;
  final int? timeStamp;
  final String? weatherIcon;
  final int currentIndex;
  final int index;
  const HourlyDetails({
    super.key,
    this.temp,
    this.timeStamp,
    this.weatherIcon,
    required this.currentIndex,
    required this.index,
  });
  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String formattedTime = DateFormat('jm').format(time);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.screenWidth * 0.02),
      width: context.screenWidth * 0.3,
      child: Column(
        children: [
          //-- hours
          Text(
            getTime(timeStamp),
            style: GoogleFonts.poppins(
              color: index == currentIndex ? Colors.black : AppColors.whiteText,
              fontWeight: FontWeight.w500,
              fontSize: context.screenWidth * 0.04,
            ),
          ),

          //-- hourly wether visual representaition
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: context.screenHeight * 0.02),
              child: Image.asset(
                'assets/weather/$weatherIcon.png',
                height: context.screenHeight * 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
