import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:clima_news/features/utils/helper/helper_funtion.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.titleStyle,
    this.subTitleStyle,
  });
  final image, title, subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.screenWidth * 0.02),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //-- onboarding image
            Lottie.asset(
              image,
              width: AppHelperFunction.screenWidth() * 0.8,
              height: AppHelperFunction.screenHeight() * 0.6,
            ),

            //-- onboarding title
            Text(title, style: titleStyle, textAlign: TextAlign.center),

            //-- onboarding subTitle
            Text(subTitle, style: subTitleStyle, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
