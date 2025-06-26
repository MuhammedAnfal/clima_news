import 'dart:async';
import 'package:clima_news/common/style/success_screen.dart';
import 'package:clima_news/data/repositories/authentication/authenticaion_repository.dart';
import 'package:clima_news/features/utils/constants/image_constants.dart';
import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  //-- send email whenever verify screen appears & set timer for auto direct

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    sendEmailVerification();
    setTimerForAutoRedirect();
  }

  //-- send email verification link
  sendEmailVerification() {
    try {
      AuthenticationRepository.instance.sendEmailVerification();
      Loaders.successSnackBar(
        title: 'Oh Snap!',
        message: 'Please check your inbox to verify your email.',
      );
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //-- timer automatically redirect to on email verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
            image: AppImages.staticSuccessIllustration,
            title: AppStrings.yourAccuntCreatedTitle,
            subTitle: AppStrings.yourAccuntCreatedTitleSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenDirect(),
          ),
        );
      }
    });
  }

  //-- manually check if the email is verified
  checkTheEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: AppImages.staticSuccessIllustration,
          title: AppStrings.yourAccuntCreatedTitle,
          subTitle: AppStrings.yourAccuntCreatedTitleSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenDirect(),
        ),
      );
    } else {
      Loaders.warningSnackBar(
        title: "Oh Snap!",
        message: 'Email ID Is Not Verified',
      );
    }
  }
}
