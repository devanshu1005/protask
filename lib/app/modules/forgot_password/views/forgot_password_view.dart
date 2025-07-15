import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/themes/app_colors.dart';
import 'package:protask1/app/themes/app_fonts.dart';
import 'package:protask1/app/utils/widgets/common_input_field.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              // Illustration Container
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryLinearGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.lock_reset,
                    size: 60,
                    color: AppColors.textWhite,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Title
              Center(
                child: Text(
                  'Forgot Password?',
                  style: AppFonts.heading1.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 28,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              Center(
                child: Text(
                  'Don\'t worry! Enter your email address and we\'ll send you a otp to reset your password.',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 48),

              // Email Field
              Text(
                'Email Address',
                style: AppFonts.formLabel.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              CommonInputField(
                icon: Icons.email_outlined,
                hintText: 'Enter your email address',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 32),

              // Reset Password Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: controller.sendOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textWhite,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: AppColors.textMuted,
                  ),
                  child: Text(
                    'Send OTP',
                    style: AppFonts.button.copyWith(
                      color: AppColors.textWhite,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Spacer(),

              // Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.divider,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: AppFonts.caption.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.divider,
                      thickness: 1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Back to Login Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(
                      color: AppColors.primary,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Back to Login',
                        style: AppFonts.button.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
