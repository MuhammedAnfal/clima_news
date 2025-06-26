import 'package:clima_news/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import '../../../../utils/device/device_utility.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: context.screenWidth * 0.04,
      bottom: AppDeviceUtility.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          shadowColor: Colors.black,
          animationDuration: Duration(seconds: 1),
          fixedSize: Size(
            context.screenWidth * 0.08,
            context.screenHeight * 0.08,
          ),
          shape: const CircleBorder(),
          backgroundColor: AppColors.primaryColor,
        ),
        onPressed: () {
          //-- jumping to next page while tap
          OnboardingController.instance.nextPage();
        },

        //-- arrow icon
        child: Icon(
          Iconsax.arrow_right_3,
          color: AppColors.white,
          blendMode: BlendMode.dstOut,

          size: context.screenWidth * 0.05,
        ),
      ),
    );
  }
}
