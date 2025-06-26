import 'package:clima_news/data/repositories/authentication/authenticaion_repository.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/sizes.dart';
import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:clima_news/features/utils/helper/helper_funtion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String image, title, subTitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.screenHeight * 0.06),
          child: Column(
            children: [
              ///--  image
              Image.asset(image),
              SizedBox(
                height: AppSizes.spaceBtwSections,
                width: AppHelperFunction.screenWidth() * 0.6,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              ///-- title and subtitle
              Text(
                AppStrings.yourAccuntCreatedTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.whiteText,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.only(top: context.screenHeight * 0.01),
                child: Text(
                  'supporting@gmail.com',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.whiteText),
                  textAlign: TextAlign.center,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                child: Text(
                  AppStrings.yourAccuntCreatedTitleSubTitle,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.whiteText,
                    fontWeight: FontWeight.w600,
                    fontSize: context.screenWidth * 0.035,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              ///-- button
              GestureDetector(
                onTap: () {
                  AuthenticationRepository.instance.screenDirect();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: context.screenHeight * 0.015,
                  ),
                  margin: EdgeInsets.only(top: context.screenHeight * 0.03),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColors.buttonColor,
                    // gradient: LinearGradient(colors: AppColors.backGroundGradient),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.continueText.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: context.screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
