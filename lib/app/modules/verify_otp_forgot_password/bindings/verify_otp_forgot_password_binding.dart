import 'package:get/get.dart';

import '../controllers/verify_otp_forgot_password_controller.dart';

class VerifyOtpForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyOtpForgotPasswordController>(
      () => VerifyOtpForgotPasswordController(),
    );
  }
}
