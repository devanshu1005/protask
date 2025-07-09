import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  // Form controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  // Observable variables
  final RxBool isPasswordHidden = true.obs;
  final RxBool isConfirmPasswordHidden = true.obs;
  final RxBool isLoading = false.obs;
  
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
    // Dispose controllers
    fullNameController.dispose();
    emailController.dispose();
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
  
  // Validate form
  bool validateForm() {
    if (fullNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your full name',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    
    if (passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    
    if (passwordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    
    if (confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please confirm your password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    
    return true;
  }
  
  // Sign up function
  Future<void> signUp() async {
    if (!validateForm()) return;
    
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Implement your signup logic here
      // Example: await AuthService.signUp(
      //   name: fullNameController.text.trim(),
      //   email: emailController.text.trim(),
      //   password: passwordController.text,
      // );
      
      Get.snackbar(
        'Success',
        'Account created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // Navigate to dashboard or login
      // Get.offAllNamed('/dashboard');
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create account. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Clear form
  void clearForm() {
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}