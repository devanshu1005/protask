import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:protask1/app/routes/app_pages.dart';
import 'package:protask1/app/services/call_helper.dart';
import 'package:protask1/app/themes/app_colors.dart';
import 'package:protask1/app/themes/app_fonts.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';
import 'package:protask1/app/utils/widgets/loader_view.dart';

class ResetPasswordController extends GetxController {
  final String emailId = Get.arguments['emailId'] ?? '';

  // Form fields
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable states
  final isNewPasswordObscured = true.obs;
  final isConfirmPasswordObscured = true.obs;
  final isLoading = false.obs;

  // Password validation states
  final hasMinLength = false.obs;
  final hasUppercase = false.obs;
  final hasLowercase = false.obs;
  final hasNumber = false.obs;
  final hasSpecialChar = false.obs;
  final passwordsMatch = false.obs;

  // Form validation
  final isFormValid = false.obs;

  // Error messages
  final newPasswordError = ''.obs;
  final confirmPasswordError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to form changes to update validation
    ever(hasMinLength, (_) => _updateFormValidation());
    ever(hasUppercase, (_) => _updateFormValidation());
    ever(hasLowercase, (_) => _updateFormValidation());
    ever(hasNumber, (_) => _updateFormValidation());
    ever(hasSpecialChar, (_) => _updateFormValidation());
    ever(passwordsMatch, (_) => _updateFormValidation());
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void toggleNewPasswordVisibility() {
    isNewPasswordObscured.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured.toggle();
  }

  // Password validation methods
  void onNewPasswordChanged(String value) {
    newPasswordController.text = value;
    _validatePassword(value);
    _checkPasswordsMatch();
  }

  void onConfirmPasswordChanged(String value) {
    confirmPasswordController.text = value;
    _checkPasswordsMatch();
  }

  void _validatePassword(String password) {
    hasMinLength.value = password.length >= 8;
    hasUppercase.value = password.contains(RegExp(r'[A-Z]'));
    hasLowercase.value = password.contains(RegExp(r'[a-z]'));
    hasNumber.value = password.contains(RegExp(r'[0-9]'));
    hasSpecialChar.value = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  void _checkPasswordsMatch() {
    passwordsMatch.value = newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        newPasswordController.text == confirmPasswordController.text;
  }

  void _updateFormValidation() {
    isFormValid.value = hasMinLength.value &&
        hasUppercase.value &&
        hasLowercase.value &&
        hasNumber.value &&
        hasSpecialChar.value &&
        passwordsMatch.value;
  }

  // Form validation methods for TextFormField
  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!hasMinLength.value) {
      return 'Password must be at least 8 characters';
    }
    if (!hasUppercase.value) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!hasLowercase.value) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!hasNumber.value) {
      return 'Password must contain at least one number';
    }
    if (!hasSpecialChar.value) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (!passwordsMatch.value) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> resetPassword() async {
    if (!isFormValid.value) return;

    try {
      LoaderView.customLogoLoader();

      final response = await CallHelper().post(
        '/auth/reset-password',
        data: {
          'email': emailId.trim(),
          'newPassword': newPasswordController.text.trim(),
        },
      );

      LoaderView.hideLoading();

      if (response != null && response['success'] == true) {
        DialogHelper.showSuccess(
          response['message'] ?? 'Password has been reset successfully!',
        );

        Get.offAllNamed(Routes.LOGIN);
      } else {
        DialogHelper.showError(
          response['message'] ?? 'Failed to reset password',
        );
      }
    } catch (e) {
      LoaderView.hideLoading();
      DialogHelper.showError('Something went wrong. Please try again.');
    } finally {
      LoaderView.hideLoading();
    }
  }

  // Additional utility methods
  void clearForm() {
    newPasswordController.clear();
    confirmPasswordController.clear();
    hasMinLength.value = false;
    hasUppercase.value = false;
    hasLowercase.value = false;
    hasNumber.value = false;
    hasSpecialChar.value = false;
    passwordsMatch.value = false;
    isFormValid.value = false;
  }

  void showPasswordTips() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Password Tips',
          style: AppFonts.withColor(AppFonts.heading3, AppColors.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create a strong password by including:',
              style: AppFonts.withColor(
                  AppFonts.bodyMedium, AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            _buildTipItem('Mix of uppercase and lowercase letters'),
            _buildTipItem('Numbers and special characters'),
            _buildTipItem('At least 8 characters long'),
            _buildTipItem('Avoid common words or patterns'),
            _buildTipItem('Don\'t reuse old passwords'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Got it',
              style: AppFonts.withColor(AppFonts.button, AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16,
            color: AppColors.success,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style:
                  AppFonts.withColor(AppFonts.bodySmall, AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
