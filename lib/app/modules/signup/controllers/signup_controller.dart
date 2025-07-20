import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/routes/app_pages.dart';
import 'package:protask1/app/services/call_helper.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';
import 'package:protask1/app/utils/widgets/loader_view.dart';

class SignupController extends GetxController {
  // Form controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  // Observable variables
  final RxBool isPasswordHidden = false.obs;
  final RxBool isConfirmPasswordHidden = false.obs;
  final isTermsAccepted = false.obs;
  // final RxBool isLoading = false.obs;
  final mobileCharCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    mobileNumberController.addListener(() {
      mobileCharCount.value = mobileNumberController.text.length;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    ageController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void toggleTermsAcceptance() {
    isTermsAccepted.value = !isTermsAccepted.value;
  }

  // Validate form
  bool validateForm() {
    if (fullNameController.text.trim().isEmpty) {
      DialogHelper.showError('Please enter your full name');
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      DialogHelper.showError('Please enter your email');
      return false;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      DialogHelper.showError('Please enter a valid email');
      return false;
    }

    if (mobileNumberController.text.trim().isEmpty) {
      DialogHelper.showError('Please enter your mobile number');
      return false;
    }

    if (ageController.text.trim().isEmpty) {
      DialogHelper.showError('Please enter your age');
      return false;
    }

    if (passwordController.text.isEmpty) {
      DialogHelper.showError('Please enter a password');
      return false;
    }

    if (passwordController.text.length < 6) {
      DialogHelper.showError('Password must be at least 6 characters');
      return false;
    }

    if (confirmPasswordController.text.isEmpty) {
      DialogHelper.showError('Please confirm your password');
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      DialogHelper.showError('Passwords do not match');
      return false;
    }

    if (mobileNumberController.text.trim().length != 10) {
      DialogHelper.showError('Mobile number must be 10 digits long');
      return false;
    }

    // Validate age (between 13 and 120)
    int? age = int.tryParse(ageController.text.trim());
    if (age == null || age < 13 || age > 120) {
      DialogHelper.showError('Please enter a valid age between 13 and 120');
      return false;
    }

    if (!isTermsAccepted.value) {
      DialogHelper.showError('Please accept the terms and conditions');
      return false;
    }

    return true;
  }

  Future<void> signUp() async {
    if (!validateForm()) return;

    try {
      // isLoading.value = true;
      LoaderView.customLogoLoader();

      final email = emailController.text.trim();

      final response = await CallHelper().post(
        '/auth/request-signup-otp',
        data: {'email': email},
      );

      LoaderView.hideLoading();

      if (response != null && response['success'] != false) {
        DialogHelper.showSuccess('OTP sent to your email!');
        Get.toNamed(Routes.VERIFY_OTP, arguments: {
          'emailId': emailController.text.trim(),
          'name': fullNameController.text.trim(),
          'password': passwordController.text,
          'mobile': mobileNumberController.text.trim(),
          'age': ageController.text.trim(),
        });
      } else {
        DialogHelper.showError(response['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      DialogHelper.showError('Failed to create account. Please try again.');
    } finally {
      // isLoading.value = false;
      LoaderView.hideLoading();
    }
  }

  // Clear form
  void clearForm() {
    fullNameController.clear();
    emailController.clear();
    mobileNumberController.clear();
    ageController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    isPasswordHidden.value = true;
    isConfirmPasswordHidden.value = true;
    isTermsAccepted.value = false;
  }
}
