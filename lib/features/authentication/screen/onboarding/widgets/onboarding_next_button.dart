import 'package:clima_news/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import '../../../../utils/device/device_utility.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingNextButton extends StatefulWidget {
  const OnBoardingNextButton({super.key});

  @override
  State<OnBoardingNextButton> createState() => _OnBoardingNextButtonState();
}

class _OnBoardingNextButtonState extends State<OnBoardingNextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: context.screenWidth * 0.04,
      bottom: AppDeviceUtility.getBottomNavigationBarHeight(),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              //-- Outer pulsing ring
              Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: context.screenWidth * 0.2,
                  height: context.screenWidth * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(
                          0.3 * _glowAnimation.value,
                        ),
                        Colors.pinkAccent.withOpacity(
                          0.2 * _glowAnimation.value,
                        ),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),

              //-- Main button with gradient
              Container(
                width: context.screenWidth * 0.16,
                height: context.screenWidth * 0.16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      Colors.deepOrange,
                      Colors.pinkAccent.shade200,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.pinkAccent.withOpacity(
                        0.4 * _glowAnimation.value,
                      ),
                      blurRadius: 30,
                      spreadRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      //-- jumping to next page while tap
                      OnboardingController.instance.nextPage();
                    },
                    borderRadius: BorderRadius.circular(100),
                    splashColor: Colors.white.withOpacity(0.3),
                    highlightColor: Colors.white.withOpacity(0.1),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Iconsax.arrow_right_3,
                          color: AppColors.white,
                          size: context.screenWidth * 0.06,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
