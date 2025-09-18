import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:protask1/app/themes/app_colors.dart';

class LoaderView {
  static void customLogoLoader() {
    if (Get.isDialogOpen == false) {
      Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: Get.context!.width * 0.18,
              height: Get.context!.width * 0.18,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.white, blurRadius: 0.15)
                ],
              ),
              child: SpinKitCircle(color: AppColors.primary),
            ).marginSymmetric(horizontal: Get.context!.width * 0.25),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  static Future<void> hideLoading() async {
    if (Get.isDialogOpen == true) {
      Get.back(closeOverlays: true);
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}

class _LogoLoaderDialog extends StatefulWidget {
  @override
  State<_LogoLoaderDialog> createState() => __LogoLoaderDialogState();
}

class __LogoLoaderDialogState extends State<_LogoLoaderDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: Get.context!.width * 0.01,
        height: Get.context!.width * 0.18,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.white, blurRadius: 0.15)],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(100),
            //   child: ScaleTransition(
            //     scale: _animation, // Apply the scaling animation here
            //     child: Assets.imagesSvgAppLogo.svg(
            //       height: 32,
            //       width: 32,
            //     ),
            //   ),
            // ),
            const SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(strokeWidth: 4),
            ).paddingSymmetric(horizontal: 8, vertical: 8),
          ],
        ),
      ).marginSymmetric(horizontal: Get.context!.width * 0.25),
    );
  }
}
