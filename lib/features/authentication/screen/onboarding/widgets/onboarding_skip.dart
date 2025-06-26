import 'package:clima_news/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.screenHeight * 0.07,
      right: context.screenWidth * 0.07,
      child: GestureDetector(
        onTap: () => OnboardingController.instance.skipPage(),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: context.screenHeight * 0.01,
            horizontal: context.screenWidth * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.buttonColor,
          ),
          child: Text(
            "Skip",
            style: GoogleFonts.poppins(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
