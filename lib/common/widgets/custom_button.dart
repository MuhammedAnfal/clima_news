import 'package:clima_news/features/authentication/controller/login/login_controller.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.loginTextStyle,
    this.margin,
    required this.onTap,
  });
  final String text;
  final EdgeInsetsGeometry? margin;
  final TextStyle loginTextStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 8,
        child: Obx(
          () => InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onTap,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width:
                  loginController.isLoading.value
                      ? context.screenWidth * 0.06
                      : context.screenWidth,
              height: context.screenHeight * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(colors: AppColors.buttonGradient),
              ),
              child: Center(
                child:
                    loginController.isLoading.value == true
                        ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                        : Text(text.toUpperCase(), style: loginTextStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
