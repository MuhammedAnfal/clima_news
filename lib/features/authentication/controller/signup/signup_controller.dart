import 'package:clima_news/data/repositories/authentication/authenticaion_repository.dart';
import 'package:clima_news/data/repositories/user/user_repository.dart';
import 'package:clima_news/features/authentication/screen/signup/widgets/verify_email_screen.dart';
import 'package:clima_news/features/authentication/models/user_model.dart';
import 'package:clima_news/features/utils/constants/image_constants.dart';
import 'package:clima_news/features/utils/network/network_manager.dart';
import 'package:clima_news/features/utils/popups/full_screen_loader.dart';
import 'package:clima_news/features/utils/popups/loaders.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  SignupController();

  //-- variables
  final RxBool hidepassword = true.obs;
  final RxBool hideConfirmPassword = true.obs;
  final RxBool privacyPolicy = true.obs;
  GlobalKey<FormState> singUpFormkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;

  @override
  void dispose() {
    //-- disposing the controllers
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  //-- sigup
  Future<void> signUp() async {
    try {
      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Form validation
      if (!singUpFormkey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }
      if (passwordController.text != confirmPasswordController.text) {
        isLoading.value = false;
        Loaders.errorSnackBar(
          title: "Password",
          message: "Password do not match, Please try again",
        );
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        Loaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'You must accept the Privacy Policy and Terms of Use to create an account.',
        );
        return;
      }

      // Start loading
      AppFullScreenLoader.openLoadingDialog(
        'We are processing your information',
        AppImages.loaderAnimation,
      );

      // Register user
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            emailController.text.trim(),
            passwordController.text.trim(),
          );

      // Save user data
      final newUser = UserModel(
        id: userCredential.user!.uid,
        fullName: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Show success message
      Loaders.successSnackBar(
        title: 'Congratulations',
        message:
            'Your account has been created! Verify your email to continue.',
      );

      // Navigate to verify email screen
      AppFullScreenLoader.stopLoading();
      Get.to(() => VerifyEmailScreen(email: emailController.text.trim()));

      // //--clearing the controllers after the navigation
      // emailController.clear();
      // nameController.clear();
      // passwordController.clear();
      // confirmPasswordController.clear();
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Something went wrong: ${e.toString()}',
      );
      AppFullScreenLoader.stopLoading();
    }
  }
}
