import 'package:clima_news/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:clima_news/features/authentication/screen/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:clima_news/features/authentication/screen/onboarding/widgets/onboarding_next_button.dart';
import 'package:clima_news/features/authentication/screen/onboarding/widgets/onboarding_page.dart';
import 'package:clima_news/features/authentication/screen/onboarding/widgets/onboarding_skip.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/image_constants.dart';
import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  final controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // horizontal scrollbar page
          PageView(
            onPageChanged: controller.currentPageIndex.call,
            controller: controller.controller,
            children: [
              //-- onboarding news page
              OnBoardingPage(
                title: AppStrings.onBoardingTitle,
                image: AppImages.onBoardingimage,
                subTitle: AppStrings.onBoardingSubTitle,
                titleStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,

                  color: AppColors.whiteText,
                  fontSize: context.screenWidth * 0.07,
                ),
                subTitleStyle: GoogleFonts.poppins(
                  color: AppColors.whiteText,
                  fontWeight: FontWeight.w300,
                  fontSize: context.screenWidth * 0.04,
                ),
              ),

              //-- onboarding weather page
              OnBoardingPage(
                title: AppStrings.onBoardingTitle2,
                image: AppImages.onBoardingimage2,
                subTitle: AppStrings.onBoardingSubTitle2,
                titleStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,

                  fontSize: context.screenWidth * 0.07,
                  color: AppColors.whiteText,
                ),
                subTitleStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,

                  color: AppColors.whiteText,
                ),
              ),

              //-- onboarding app based page
              OnBoardingPage(
                title: AppStrings.onBoardingTitle3,
                image: AppImages.onBoardingimage3,
                subTitle: AppStrings.onBoardingSubTitle3,
                titleStyle: GoogleFonts.poppins(
                  color: AppColors.whiteText,
                  fontWeight: FontWeight.w600,
                  fontSize: context.screenWidth * 0.07,
                ),
                subTitleStyle: GoogleFonts.poppins(
                  color: AppColors.whiteText,
                  fontWeight: FontWeight.w300,
                  fontSize: context.screenWidth * 0.04,
                ),
              ),
            ],
          ),

          // skip button
          const OnBoardingSkip(),

          // dot navigation  smooth page indicator
          const OnBoardingDotNavigation(),

          // circular button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
