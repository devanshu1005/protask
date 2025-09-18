import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/themes/app_colors.dart';
import 'package:protask1/app/themes/app_fonts.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.textPrimary,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Reset Password',
          style:
              AppFonts.withColor(AppFonts.appBarTitle, AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeaderSection(),
              const SizedBox(height: 40),
              _buildResetPasswordForm(),
              const SizedBox(height: 30),
              _buildResetButton(),
              const SizedBox(height: 20),
              _buildBackToLoginLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            gradient: AppColors.primaryLinearGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.lock_reset,
            color: AppColors.white,
            size: 32,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Create New Password',
          style: AppFonts.withColor(AppFonts.heading2, AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: AppFonts.withColor(
                AppFonts.bodyMedium, AppColors.textSecondary),
            children: [
              const TextSpan(text: 'Create a new password for '),
              TextSpan(
                text: controller.emailId,
                style:
                    AppFonts.withColor(AppFonts.bodyMedium, AppColors.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResetPasswordForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPasswordField(
          label: 'New Password',
          hint: 'Enter your new password',
          isObscured: controller.isNewPasswordObscured,
          onToggleVisibility: controller.toggleNewPasswordVisibility,
          onChanged: controller.onNewPasswordChanged,
          validator: controller.validateNewPassword,
        ),
        const SizedBox(height: 20),
        _buildPasswordField(
          label: 'Confirm Password',
          hint: 'Confirm your new password',
          isObscured: controller.isConfirmPasswordObscured,
          onToggleVisibility: controller.toggleConfirmPasswordVisibility,
          onChanged: controller.onConfirmPasswordChanged,
          validator: controller.validateConfirmPassword,
        ),
        const SizedBox(height: 16),
        _buildPasswordRequirements(),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required RxBool isObscured,
    required VoidCallback onToggleVisibility,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.withColor(AppFonts.formLabel, AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Obx(() => Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                obscureText: isObscured.value,
                onChanged: onChanged,
                validator: validator,
                style: AppFonts.withColor(
                    AppFonts.formField, AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: AppFonts.withColor(
                      AppFonts.formField, AppColors.textMuted),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscured.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textMuted,
                    ),
                    onPressed: onToggleVisibility,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildPasswordRequirements() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password Requirements',
            style:
                AppFonts.withColor(AppFonts.labelMedium, AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          Obx(() => Column(
                children: [
                  _buildRequirementItem(
                    'At least 8 characters',
                    controller.hasMinLength.value,
                  ),
                  _buildRequirementItem(
                    'At least one uppercase letter',
                    controller.hasUppercase.value,
                  ),
                  _buildRequirementItem(
                    'At least one lowercase letter',
                    controller.hasLowercase.value,
                  ),
                  _buildRequirementItem(
                    'At least one number',
                    controller.hasNumber.value,
                  ),
                  _buildRequirementItem(
                    'At least one special character',
                    controller.hasSpecialChar.value,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isValid ? AppColors.success : AppColors.textMuted,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppFonts.withColor(
              AppFonts.bodySmall,
              isValid ? AppColors.success : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResetButton() {
    return Obx(() => SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed:
                controller.isFormValid.value && !controller.isLoading.value
                    ? controller.resetPassword
                    : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: AppColors.textDisabled,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: controller.isLoading.value
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  )
                : Text(
                    'Reset Password',
                    style: AppFonts.withColor(AppFonts.button, AppColors.white),
                  ),
          ),
        ));
  }

  Widget _buildBackToLoginLink() {
    return Center(
      child: TextButton(
        onPressed: () => Get.back(),
        child: RichText(
          text: TextSpan(
            style: AppFonts.withColor(
                AppFonts.bodyMedium, AppColors.textSecondary),
            children: [
              const TextSpan(text: 'Remember your password? '),
              TextSpan(
                text: 'Sign In',
                style:
                    AppFonts.withColor(AppFonts.bodyMedium, AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
