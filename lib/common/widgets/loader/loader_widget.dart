import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AppAnimationLoaderWidget extends StatelessWidget {
  const AppAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(animation, width: context.screenWidth * 0.35),
          Text(
            text,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.screenHeight * 0.06),
          showAction
              ? SizedBox(
                width: context.screenWidth,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.dark,
                  ),
                  onPressed: onActionPressed,
                  child: Text(actionText!),
                ),
              )
              : const SizedBox(),
        ],
      ),
    );
  }

  //-- stop currently open loading
  //-- this method doesnt return anything
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
