import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/modules/login/controllers/login_controller.dart';
import 'package:protask1/app/routes/app_pages.dart';
import 'package:protask1/app/services/call_helper.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';
import 'package:protask1/app/utils/widgets/loader_view.dart';

class VerifyOtpController extends GetxController {
  // OTP related variables
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> otpFocusNodes =
      List.generate(6, (index) => FocusNode());

  // Reactive variables
  final otpCode = ''.obs;
  // final isLoading = false.obs;
  final canResend = false.obs;
  final remainingTime = 60.obs;
  final String emailId = Get.arguments['emailId'];
  final String name = Get.arguments['name'];
  final String password = Get.arguments['password'];
  final String mobile = Get.arguments['mobile'];
  final String age = Get.arguments['age'];

  // Timer for resend functionality
  Timer? _resendTimer;

  @override
  void onInit() {
    super.onInit();
    _startResendTimer();

    // Add listeners to all OTP controllers
    for (int i = 0; i < otpControllers.length; i++) {
      otpControllers[i].addListener(() {
        _updateOtpCode();
      });
    }
  }

  @override
  void onClose() {
    // Dispose controllers and focus nodes
    for (int i = 0; i < otpControllers.length; i++) {
      otpControllers[i].dispose();
      otpFocusNodes[i].dispose();
    }
    _resendTimer?.cancel();
    super.onClose();
  }

  /// Handle OTP input change
  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next field if not the last field
      if (index < 5) {
        otpFocusNodes[index + 1].requestFocus();
      } else {
        // Last field, remove focus
        otpFocusNodes[index].unfocus();
      }
    } else {
      // Move to previous field if not the first field
      if (index > 0) {
        otpFocusNodes[index - 1].requestFocus();
      }
    }

    _updateOtpCode();
  }

  /// Update the complete OTP code
  void _updateOtpCode() {
    String code = '';
    for (var controller in otpControllers) {
      code += controller.text;
    }
    otpCode.value = code;
  }

  /// Start the resend timer
  void _startResendTimer() {
    remainingTime.value = 60;
    canResend.value = false;

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  /// Verify OTP
  Future<void> verifyOtp() async {
    if (otpCode.value.length != 6) {
      DialogHelper.showError('Please enter a valid 6-digit code');
      return;
    }

    try {
      // isLoading.value = true;
      LoaderView.customLogoLoader();

      final response = await CallHelper().post(
        '/auth/verify-signup-otp',
        data: {
          'email': emailId,
          'otp': int.tryParse(otpCode.value),
        },
      );

      LoaderView.hideLoading();

      if (response != null && response['success'] == true) {
        DialogHelper.showSuccess('OTP verified successfully!');
        createUser();
      } else {
        _clearOtpFields();
        DialogHelper.showError(
            response['message'] ?? 'OTP verification failed');
      }
    } catch (e) {
      DialogHelper.showError('Verification failed. Please try again.');
    } finally {
      // isLoading.value = false;
      LoaderView.hideLoading();
    }
  }

  Future<void> createUser() async {
    try {
      LoaderView.customLogoLoader();

      final response = await CallHelper().post(
        '/auth/signup',
        data: {
          "name": name,
          "password": password,
          "age": int.tryParse(age),
          "mobileNumber": mobile,
          "email": emailId,
        },
      );

      if (response != null && response['success'] == true) {
        DialogHelper.showSuccess(
          'Account created successfully!',
          title: 'Welcome',
          backgroundColor: Colors.green,
        );

        await Future.delayed(const Duration(milliseconds: 300));
        Get.offAllNamed(Routes.LOGIN);
      } else {
        DialogHelper.showError(
          response?['message'] ?? 'Account creation failed.',
        );
      }
    } catch (e) {
      DialogHelper.showError('Something went wrong. Please try again.');
    } finally {
      await LoaderView.hideLoading();
    }
  }

  Future<void> resendOtp() async {
    try {
      LoaderView.customLogoLoader();

      final response = await CallHelper().post(
        '/auth/request-signup-otp',
        data: {'email': emailId},
      );

      LoaderView.hideLoading();

      if (response != null && response['success'] != false) {
        DialogHelper.showSuccess('OTP sent to your email!');
        _clearOtpFields();
        _startResendTimer();
      } else {
        DialogHelper.showError(response?['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      LoaderView.hideLoading();
      DialogHelper.showError('Failed to resend OTP. Please try again.');
    }
  }

  void _clearOtpFields() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    otpCode.value = '';
    otpFocusNodes[0].requestFocus();
  }
}
