import 'package:clima_news/features/news/controller/home/home_controller.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HomeSearchingSection extends StatelessWidget {
  HomeSearchingSection({super.key, required Animation<double> fadeAnimation})
    : _fadeAnimation = fadeAnimation;

  final Animation<double> _fadeAnimation;
  HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
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
              onFieldSubmitted: (value) {
                print('1');
                homeController.getCurrentPosition();
              },
              controller: homeController.searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.search_normal, color: AppColors.white),
                hintText: 'Search Your City',
                hintStyle: GoogleFonts.poppins(color: AppColors.whiteText),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
