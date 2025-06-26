import 'package:clima_news/features/news/controller/home/home_controller.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HomeSearchingSection extends StatelessWidget {
  const HomeSearchingSection({super.key, required Animation<double> fadeAnimation})
    : _fadeAnimation = fadeAnimation;

  final Animation<double> _fadeAnimation;

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _fadeAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              borderRadius: BorderRadius.circular(40),
            ),
            margin: EdgeInsets.only(top: context.screenHeight * 0.03),
            child: TextFormField(
              style: GoogleFonts.poppins(color: AppColors.whiteText),
              cursorColor: AppColors.white,
              controller: controller.searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),

                //-- Border when enabled but not focused
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(color: Colors.white),
                ),
                prefixIcon: Icon(Iconsax.search_normal, color: AppColors.white),
                hintText: 'Search Your City',
                hintStyle: GoogleFonts.poppins(color: AppColors.whiteText),

                suffixIcon: IconButton(
                  icon: Icon(Iconsax.close_circle, color: AppColors.white),
                  onPressed: () => controller.clearSearch(),
                ),
              ),
              onFieldSubmitted: (value) => _performSearch(controller),
            ),
          ),
        );
      },
    );
  }

  void _performSearch(HomeController controller) {
    if (controller.searchController.text.isNotEmpty) {
      controller.searchWeatherByCity(controller.searchController.text);
    }
  }
}
