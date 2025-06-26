import 'package:clima_news/common/widgets/custom_appbar.dart';
import 'package:clima_news/features/authentication/controller/signup/verify_email_controller.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/image_constants.dart';
import 'package:clima_news/features/utils/constants/sizes.dart';
import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmailScreen extends StatelessWidget {
  String? email;
  VerifyEmailScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.lightBackground,
        leading: SizedBox(),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: context.screenWidth * 0.05),
            child: Icon(Icons.clear, color: AppColors.white),
          ),
        ],
      ),
      body: Container(
        height: context.screenHeight,
        color: AppColors.lightBackground,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(context.screenWidth * 0.06),
            child: Column(
              children: [
                //--images
                Image.asset(
                  AppImages.deliveredEmailIllustration,
                  height: context.screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),

                ///-- title and subtitle
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.08),
                  child: Text(
                    AppStrings.confirmEmail,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.03),
                  child: Text(
                    email ?? '',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // const SizedBox(height: AppSizes.spaceBtwItems),
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.03),
                  child: Text(
                    AppStrings.confirmEmailSubTitle,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                //-- continue button
                Container(
                  margin: EdgeInsets.only(top: context.screenHeight * 0.03),
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 8,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () => controller.checkTheEmailVerificationStatus(),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: double.infinity,
                        height: context.screenHeight * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.buttonColor,
                        ),
                        child: Center(
                          child: Text(
                            AppStrings.continueText.toUpperCase(),
                            style: GoogleFonts.poppins(
                              color: AppColors.black,
                              fontSize: context.screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSizes.spaceBtwItems),

                //-- resent emailbutton
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => controller.sendEmailVerification(),
                    child: Text(
                      AppStrings.resendEmail,
                      style: GoogleFonts.poppins(color: AppColors.whiteText),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
