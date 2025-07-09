import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // Form controller
  final TextEditingController emailController = TextEditingController();
  
  // Observable variables
  final RxBool isLoading = false.obs;
  final RxString message = ''.obs;
  final RxBool isSuccess = false.obs;
  final RxBool isEmailSent = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Clear message when email changes
    emailController.addListener(() {
      if (message.value.isNotEmpty) {
        message.value = '';
      }
    });
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

  // Validate email
  bool validateEmail() {
    final email = emailController.text.trim();
    
    if (email.isEmpty) {
      showMessage('Please enter your email address', false);
      return false;
    }
    
    if (!GetUtils.isEmail(email)) {
      showMessage('Please enter a valid email address', false);
      return false;
    }
    
    return true;
  }
  
  // Show message
  void showMessage(String msg, bool success) {
    message.value = msg;
    isSuccess.value = success;
  }
  
  // Clear message
  void clearMessage() {
    message.value = '';
  }
  
  // Reset password function
  Future<void> resetPassword() async {
    if (!validateEmail()) return;
    
    try {
      isLoading.value = true;
      clearMessage();
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Implement your forgot password logic here
      // Example: await AuthService.sendPasswordResetEmail(
      //   email: emailController.text.trim(),
      // );
      
      // Simulate successful response
      final email = emailController.text.trim();
      isEmailSent.value = true;
      
      showMessage(
        'Password reset link has been sent to $email. Please check your inbox and follow the instructions.',
        true,
      );
      
      // Auto-hide success message after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (message.value.isNotEmpty && isSuccess.value) {
          clearMessage();
        }
      });
      
    } catch (e) {
      showMessage(
        'Failed to send reset link. Please try again later.',
        false,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Resend email
  Future<void> resendEmail() async {
    if (isEmailSent.value) {
      await resetPassword();
    }
  }
  
  // Navigate back to login
  void backToLogin() {
    Get.back();
  }
  
  // Clear form
  void clearForm() {
    emailController.clear();
    clearMessage();
    isEmailSent.value = false;
  }
  
  // Check if email was sent
  bool get emailWasSent => isEmailSent.value;
  
  // Get email for display
  String get currentEmail => emailController.text.trim();
}