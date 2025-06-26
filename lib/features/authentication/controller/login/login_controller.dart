import 'package:clima_news/data/repositories/authentication/authenticaion_repository.dart';
import 'package:clima_news/features/utils/constants/image_constants.dart';
import 'package:clima_news/features/utils/network/network_manager.dart';
import 'package:clima_news/features/utils/popups/full_screen_loader.dart';
import 'package:clima_news/features/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //-- variables
  final rememberMe = false.obs;
  final RxBool hidePassword = true.obs;
  final localStorage = GetStorage();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    emailController.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    passwordController.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
  }

  @override
  void dispose() {
    //-- disposing the controllers
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  //-- email and password sign in
  Future<void> emailAndPasswordSignIn() async {
    try {
      isLoading.value = true;

      AppFullScreenLoader.openLoadingDialog(
        'Logging you in....',
        AppImages.loaderAnimation,
      );

      //-- check the internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      //-- form validation
      if (!loginFormKey.currentState!.validate()) {
        isLoading.value = false;
        AppFullScreenLoader.stopLoading();
        return;
      }

      //-- save the data if the remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', emailController.text.trim());
        localStorage.write(
          'REMEMBER_ME_PASSWORD',
          passwordController.text.trim(),
        );
      }

      //-- log in user using email and password authentication
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(
            emailController.text.trim(),
            passwordController.text.trim(),
          );

      isLoading.value = false;
      //-- remove loader
      AppFullScreenLoader.stopLoading();

      //-- redirect
      AuthenticationRepository.instance.screenDirect();

      //--clearing the controllers after navigation
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      //-- remove loader
      isLoading.value == false;
      AppFullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

      return;
    } finally {
      isLoading.value = false;
      return;
    }
  }
}
