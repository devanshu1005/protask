import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/routes/app_pages.dart';

class LoginController extends GetxController {
  // Form Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // Observable variables
  final isPasswordObscured = true.obs;
  final isLoading = false.obs;
  
  // Form key for validation
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Pre-fill email for demo (optional)
    // emailController.text = 'john@example.com';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  /// Handle sign in
  void signIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validate email format
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Implement actual authentication logic here
      // Example: await AuthService.signIn(email, password);
      Get.toNamed(Routes.HOME);
      
      // For demo purposes, just show success message
      Get.snackbar(
        'Success',
        'Login successful!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // Navigate to home screen
      // Get.offAllNamed('/home');
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Handle forgot password
  void forgotPassword() {
    // Navigate to forgot password screen
    // Get.toNamed('/forgot-password');
    
    // For demo purposes, just show message
    Get.snackbar(
      'Info',
      'Forgot password functionality will be implemented',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  /// Navigate to sign up screen
  void goToSignUp() {
    // Navigate to sign up screen
    // Get.toNamed('/sign-up');
    
    // For demo purposes, just show message
    Get.snackbar(
      'Info',
      'Sign up screen will be implemented',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  /// Clear form fields
  void clearForm() {
    emailController.clear();
    passwordController.clear();
  }

  /// Validate form
  bool validateForm() {
    return emailController.text.trim().isNotEmpty &&
           passwordController.text.trim().isNotEmpty &&
           GetUtils.isEmail(emailController.text.trim());
  }
}