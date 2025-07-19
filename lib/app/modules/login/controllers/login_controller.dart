import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/routes/app_pages.dart';
import 'package:protask1/app/services/call_helper.dart';
import 'package:protask1/app/utils/app_globals.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';
import 'package:protask1/app/utils/widgets/loader_view.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordObscured = true.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    emailController.text = '';
    passwordController.text = '';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void signIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      DialogHelper.showError('Please fill in all fields');
      return;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      DialogHelper.showError('Please enter a valid email address');
      return;
    }

    try {
      LoaderView.customLogoLoader();

      final response = await CallHelper().post(
        '/auth/login',
        data: {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );

      LoaderView.hideLoading();
      if (response != null && response['suucess'] == true) {
        final token = response['token'];
        final user = response['data'];

        AppGlobals.instance.accessToken = token;
        AppGlobals.instance.userId = user['_id'];
        AppGlobals.instance.name.value = user['name'];
        AppGlobals.instance.email.value = user['email'];
        AppGlobals.instance.age.value = user['age'];
        AppGlobals.instance.mobile.value = user['mobileNumber'];

        await AppGlobals.instance.saveToStorage();

        DialogHelper.showSuccess(response['message'] ?? 'Login successful!');

        Get.offAllNamed(Routes.HOME);
      } else {
        DialogHelper.showError(response['message'] ?? 'Login failed');
      }
    } catch (e) {
      DialogHelper.showError('Login failed: ${e.toString()}');
    } finally {
      LoaderView.hideLoading();
    }
  }

  void forgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  void goToSignUp() {
    Get.toNamed(Routes.SIGNUP);
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
  }

  bool validateForm() {
    return emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        GetUtils.isEmail(emailController.text.trim());
  }
}
