import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/themes/app_colors.dart';
import 'package:protask1/app/themes/app_fonts.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              
              // Welcome Back Title
              Text(
                'Welcome Back',
                style: AppFonts.heading1.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 36,
                  fontWeight: AppFonts.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Sign in subtitle
              Text(
                'Sign in to continue',
                style: AppFonts.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 18,
                ),
              ),
              
              const SizedBox(height: 60),
              
              // Email Label
              Text(
                'Email',
                style: AppFonts.formLabel.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: AppFonts.medium,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Email TextField
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.borderLight,
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: AppFonts.formField.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'enter your email',
                    hintStyle: AppFonts.formField.copyWith(
                      color: AppColors.textMuted,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Password Label
              Text(
                'Password',
                style: AppFonts.formLabel.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: AppFonts.medium,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Password TextField
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.borderLight,
                    width: 1,
                  ),
                ),
                child: Obx(() => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordObscured.value,
                  style: AppFonts.formField.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    hintStyle: AppFonts.formField.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 18,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordObscured.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.textMuted,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                )),
              ),
              
              const SizedBox(height: 40),
              
              // Sign In Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: controller.signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textWhite,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: AppFonts.button.copyWith(
                      color: AppColors.textWhite,
                      fontSize: 18,
                      fontWeight: AppFonts.semiBold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Forgot Password
              Center(
                child: TextButton(
                  onPressed: controller.forgotPassword,
                  child: Text(
                    'Forgot Password?',
                    style: AppFonts.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                    ),
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Sign Up Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: controller.goToSignUp,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Sign Up',
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: AppFonts.semiBold,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}