import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:protask1/app/themes/app_colors.dart';
import 'package:protask1/app/themes/app_fonts.dart';
import 'package:protask1/app/utils/widgets/common_input_field.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'Create\nAccount',
                style: AppFonts.heading1.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Join ProTask today',
                style: AppFonts.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 48),
              Text('Full Name', style: AppFonts.formLabel.copyWith(color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              CommonInputField(
                icon: Icons.person_outline,
                hintText: 'Enter your full name',
                controller: controller.fullNameController,
              ),
              const SizedBox(height: 24),
              Text('Email', style: AppFonts.formLabel.copyWith(color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              CommonInputField(
                icon: Icons.email_outlined,
                hintText: 'Enter your email',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              Text('Mobile Number', style: AppFonts.formLabel.copyWith(color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              CommonInputField(
                icon: Icons.phone_outlined,
                hintText: 'Enter your mobile number',
                controller: controller.mobileNumberController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              Text('Age', style: AppFonts.formLabel.copyWith(color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              CommonInputField(
                icon: Icons.cake_outlined,
                hintText: 'Enter your age',
                controller: controller.ageController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              Text('Password', style: AppFonts.formLabel.copyWith(color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              CommonInputField(
                icon: Icons.lock_outline,
                hintText: 'Create a password',
                controller: controller.passwordController,
                isPassword: true,
                isVisibleObs: controller.isPasswordHidden,
              ),
              const SizedBox(height: 24),
              Text('Confirm Password', style: AppFonts.formLabel.copyWith(color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              CommonInputField(
                icon: Icons.lock_outline,
                hintText: 'Confirm your password',
                controller: controller.confirmPasswordController,
                isPassword: true,
                isVisibleObs: controller.isConfirmPasswordHidden,
              ),
              const SizedBox(height: 32),
              Obx(() => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: controller.isTermsAccepted.value,
                        onChanged: (value) => controller.toggleTermsAcceptance(),
                        activeColor: AppColors.primary,
                        checkColor: AppColors.white,
                        side: BorderSide(color: AppColors.border, width: 1),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: AppFonts.bodySmall.copyWith(color: AppColors.textSecondary),
                            children: [
                              const TextSpan(text: 'By creating an account, you agree to our '),
                              TextSpan(
                                text: 'Terms of Service',
                                style: AppFonts.bodySmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: AppFonts.semiBold,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: AppFonts.bodySmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: AppFonts.semiBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 32),
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: controller.isTermsAccepted.value 
                          ? controller.signUp
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isTermsAccepted.value
                            ? AppColors.primary
                            : AppColors.textDisabled,
                        foregroundColor: AppColors.textWhite,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                              'Sign Up',
                              style: AppFonts.button.copyWith(
                                color: AppColors.textWhite,
                              ),
                            ),
                    ),
                  )),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: AppFonts.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'Sign In',
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: AppFonts.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
