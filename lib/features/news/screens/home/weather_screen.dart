import 'package:clima_news/common/widgets/shimmer/weather_shimmer.dart';
import 'package:clima_news/features/news/controller/home/home_controller.dart';
import 'package:clima_news/features/news/screens/home/widgets/home_weather_details.dart';
import 'package:clima_news/features/news/screens/home/widgets/hourly_data_section.dart';
import 'package:clima_news/features/news/screens/home/widgets/weather_degree_detail.dart';
import 'package:clima_news/features/news/screens/home/widgets/weather_seraching_section.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/image_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with SingleTickerProviderStateMixin {
  //-- variables
  final HomeController homeController = Get.put(
    HomeController(),
    permanent: true,
  );
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // More reasonable duration
    );

    // Slide animation (first half)
    _slideAnimation = Tween<double>(
      begin: 200,
      end: 0,
    ).animate(_animationController);
    // Slide animation (first half)
    _fadeAnimation = Tween<double>(
      begin: 0.1,
      end: 1,
    ).animate(_animationController);

    // Scale animation (second half)
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(_animationController);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          homeController.isLoading
              ? WeatherShimmerEffect()
              : Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(context.screenWidth * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //-- location and profile avatar icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                homeController.city.value.toString(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: context.screenWidth * 0.045,
                                  color: AppColors.whiteText,
                                ),
                              ),
                            ),
                            Image.asset(
                              AppImages.avatarIcon,
                              height: context.screenHeight * 0.06,
                            ),
                          ],
                        ),
                        //-- search bar section
                        HomeSearchingSection(fadeAnimation: _fadeAnimation),
                        //-- showing the temperature and image according to it
                        WeatherDegreeDetails(
                          slideAnimation: _slideAnimation,
                          currentWeatherData:
                              homeController.getData().getCurrentWeather(),
                        ),

                        //-- showing the weather datas(humidity,uv.....)
                        HomeWeatherDetails(
                          scaleAnimation: _scaleAnimation,
                          currentWeatherData:
                              homeController.getData().getCurrentWeather(),
                        ),

                        // hourly weather data
                        HourlyDataSection(
                          hourlyWeatherData:
                              homeController.getData().getHourlytWeather(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}
