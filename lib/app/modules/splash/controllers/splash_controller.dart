import 'package:get/get.dart';
import 'dart:async';

import 'package:protask1/app/routes/app_pages.dart';
import 'package:protask1/app/utils/app_globals.dart';

class SplashController extends GetxController {
  final currentDotIndex = 0.obs;
  Timer? _timer;
  Timer? _navigationTimer;

  @override
  void onInit() {
    super.onInit();
    _startDotAnimation();
    _startNavigationTimer();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _navigationTimer?.cancel();
    super.onClose();
  }

  void _startDotAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      currentDotIndex.value = (currentDotIndex.value + 1) % 3;
    });
  }

  void _startNavigationTimer() {
    _navigationTimer = Timer(const Duration(seconds: 5), () {
      // print(
      //     'Access token on splash screen: ${AppGlobals.instance.accessToken}');
      if (AppGlobals.instance.accessToken != null) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }

  // void _restartAnimation() {
  //   currentDotIndex.value = 0;
  //   _timer?.cancel();
  //   _startDotAnimation();
  //   _startNavigationTimer();
  // }
}
