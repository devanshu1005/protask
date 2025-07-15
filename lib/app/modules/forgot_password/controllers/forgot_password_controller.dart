import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/routes/app_pages.dart';
import 'package:protask1/app/services/call_helper.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';
import 'package:protask1/app/utils/widgets/loader_view.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  bool validateEmail() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      DialogHelper.showError('Please enter your email address');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      DialogHelper.showError('Please enter a valid email address');
      return false;
    }

    return true;
  }

  Future<void> sendOtp() async {
    if (!validateEmail()) return;
    if (emailController.text.trim().isEmpty) {
      DialogHelper.showError('Please enter your email');
      return;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      DialogHelper.showError('Please enter a valid email address');
      return;
    }

    try {
      LoaderView.customLogoLoader();
      final response = await CallHelper().post(
        '/auth/send-otp',
        data: {
          "email": emailController.text.trim(),
        },
      );

      LoaderView.hideLoading();

      if (response != null && response['success'] == true) {
        DialogHelper.showSuccess('OTP sent successfully!');
        Get.toNamed(Routes.VERIFY_OTP_FORGOT_PASSWORD, arguments: {'emailId': emailController.text.trim(),});
      } else {
        DialogHelper.showError(response['message'] ?? 'Failed to send OTP');
      }
    } catch (e) {
      DialogHelper.showError('Something went wrong. Please try again.');
    } finally {
      LoaderView.hideLoading();
    }
  }

  void backToLogin() {
    Get.back();
  }

  void clearForm() {
    emailController.clear();
  }

  String get currentEmail => emailController.text.trim();
}
