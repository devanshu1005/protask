import 'package:get/get.dart';

import '../modules/add_edit_task/bindings/add_edit_task_binding.dart';
import '../modules/add_edit_task/views/add_edit_task_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile_screen/bindings/profile_screen_binding.dart';
import '../modules/profile_screen/views/profile_screen_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/task_detail_screen/bindings/task_detail_screen_binding.dart';
import '../modules/task_detail_screen/views/task_detail_screen_view.dart';
import '../modules/verify_otp/bindings/verify_otp_binding.dart';
import '../modules/verify_otp/views/verify_otp_view.dart';
import '../modules/verify_otp_forgot_password/bindings/verify_otp_forgot_password_binding.dart';
import '../modules/verify_otp_forgot_password/views/verify_otp_forgot_password_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EDIT_TASK,
      page: () => const AddEditTaskView(),
      binding: AddEditTaskBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SCREEN,
      page: () => const ProfileScreenView(),
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP_FORGOT_PASSWORD,
      page: () => const VerifyOtpForgotPasswordView(),
      binding: VerifyOtpForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.TASK_DETAIL_SCREEN,
      page: () => const TaskDetailScreenView(),
      binding: TaskDetailScreenBinding(),
    ),
  ];
}
