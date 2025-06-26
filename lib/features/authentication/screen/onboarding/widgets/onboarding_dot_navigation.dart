import 'package:clima_news/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:clima_news/features/utils/device/device_utility.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Positioned(
      left: context.screenWidth * 0.38,
      bottom:
          AppDeviceUtility.getBottomNavigationBarHeight() +
          AppDeviceUtility.getScreenHeight() * 0.14,
      child: SmoothPageIndicator(
        onDotClicked: controller.dotNavigationClick,
        controller: controller.controller,
        count: 3,
        effect: ExpandingDotsEffect(
          dotHeight: AppDeviceUtility.getScreenHeight() * 0.01,
        ),
      ),
    );
  }
}
