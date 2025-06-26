import 'package:clima_news/features/authentication/screen/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  /// variables
  final controller = PageController();
  Rx<int> currentPageIndex = 0.obs;

  /// update current index when page scroll
  void updatePageIndicator(index) {
    currentPageIndex = index;
  }

  /// jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    controller.jumpToPage(index);
  }

  /// update the current index and jump to the next page
  void nextPage() {
    if (currentPageIndex == 2) {
      final storage = GetStorage();
      storage.write('isFirstTime', false);

      Get.offAll(LoginPage());
    } else {
      currentPageIndex.value = currentPageIndex.value + 1;
      controller.jumpToPage(currentPageIndex.value);
    }
  }

  /// update the current index and jump to the last page
  void skipPage() {
    currentPageIndex.value = 2;
    controller.jumpToPage(2);
  }
}
