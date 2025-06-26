import 'package:clima_news/features/news/controller/home/home_controller.dart';
import 'package:clima_news/features/news/models/hourly_weather_data.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HourlyDataSection extends StatelessWidget {
  HourlyDataSection({super.key, required this.hourlyWeatherData});
  final HourlyWeatherData hourlyWeatherData;

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Container(
      margin: EdgeInsets.only(top: context.screenHeight * 0.005),
      width: context.screenWidth,
      child: Column(
        children: [
          Text(
            AppStrings.todayText,
            style: GoogleFonts.poppins(
              color: AppColors.whiteText,
              fontWeight: FontWeight.w700,
              fontSize: context.screenWidth * 0.04,
            ),
          ),
          hourlyList(context: context, controller: controller),
          // Pagination indicators
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (pageIndex) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        controller.currentPage.value == pageIndex
                            ? AppColors.white
                            : AppColors.white.withOpacity(0.4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget hourlyList({required BuildContext context, required HomeController controller}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: context.screenHeight * 0.02),
          height: context.screenHeight * 0.18,
          width: context.screenWidth * 0.9,
          child: PageView.builder(
            //-- page view
            controller: PageController(viewportFraction: 1),
            onPageChanged: (index) {
              controller.currentPage.value = index ~/ 4;
            },
            //-- 4 items per page
            itemCount: (hourlyWeatherData.hourly.length / 4).ceil(),
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * 4;
              final endIndex = startIndex + 4;
              final items = hourlyWeatherData.hourly.sublist(
                startIndex,
                endIndex > hourlyWeatherData.hourly.length
                    ? hourlyWeatherData.hourly.length
                    : endIndex,
              );

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    items.map((hourly) {
                      final index = hourlyWeatherData.hourly.indexOf(hourly);
                      return Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.currentIndex.value = index;
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: context.screenWidth * 0.04),
                            padding: EdgeInsets.symmetric(
                              horizontal: context.screenWidth * 0.02,
                              vertical: context.screenHeight * 0.001,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color:
                                  controller.currentIndex.value == index
                                      ? AppColors.white
                                      : null,
                              boxShadow: [
                                BoxShadow(offset: Offset(0.5, 0), color: Colors.white30),
                              ],
                            ),
                            child: HourlyDetails(
                              temp: hourly.temp!.toInt(),
                              timeStamp: hourly.dt ?? 0,
                              weatherIcon: hourly.weather?.first.icon ?? "",
                              currentIndex: controller.currentIndex.value,
                              index: index,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
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

  //-- format function

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String formattedTime = DateFormat('h a').format(time);
    return formattedTime;
  }

  //-- sett weather icon
  String getWeatherIcon(String? iconCode) {
    if (iconCode == null) return 'assets/weather/01d.png';
    return 'assets/weather/$iconCode.png';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(context.screenWidth * 0.02),
          width: context.screenWidth * 0.13,
          child: Column(
            children: [
              // Time display
              Text(
                getTime(timeStamp),
                style: GoogleFonts.poppins(
                  color: index == currentIndex ? Colors.black : AppColors.whiteText,
                  fontWeight: FontWeight.w500,
                  fontSize: context.screenWidth * 0.027,
                ),
              ),

              // Temperature
              Text(
                '$temp°',
                style: GoogleFonts.poppins(
                  color: index == currentIndex ? Colors.black : AppColors.whiteText,
                  fontWeight: FontWeight.bold,
                  fontSize: context.screenWidth * 0.03,
                ),
              ),

              // Weather icon
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                  child: Image.asset(
                    getWeatherIcon(weatherIcon),
                    height: context.screenHeight * 0.03,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
