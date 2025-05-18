import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ebefa/features/authentications/screens/login/login.dart';

class OnboardingController extends GetxController {
  static OnboardingController instance = Get.find();
  final pageController = PageController();
  Rx<int> currentPage = 0.obs;
  void updatePageIndicator(index) {
    currentPage.value = index;
  }

  void dotNavigation(index) {
    currentPage.value = index;
    pageController.jumpToPage(index);
  }

  void nextPage() {
    if (currentPage.value == 2) {
      Get.to(
        () => const LoginScreen(),
      );
    } else {
      int page = currentPage.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPage.value = 2;
    pageController.jumpToPage(2);
  }
}
