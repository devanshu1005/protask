import 'package:get/get.dart';
import 'package:protask1/app/routes/app_pages.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppGlobals {
  AppGlobals._();

  static final AppGlobals instance = AppGlobals._();

  String? accessToken;
  String? refreshToken;
  String? userId;
  String? name;
  String? email;
  // String? role;
  String? profileImageUrl;
  // String? biometricHash;

  String baseUrl = 'https://task-backend-4ww1.onrender.com/api';

  bool get isLoggedIn =>
      accessToken != null &&
      accessToken!.isNotEmpty &&
      userId != null &&
      userId!.isNotEmpty;

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');
    refreshToken = prefs.getString('refreshToken');
    userId = prefs.getString('userId');
    name = prefs.getString('name');
    email = prefs.getString('email');
    // role = prefs.getString('role');
    profileImageUrl = prefs.getString('profileImageUrl');
    // biometricHash = prefs.getString('biometricHash');
  }

  Future<void> saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    if (accessToken != null) prefs.setString('accessToken', accessToken!);
    if (refreshToken != null) prefs.setString('refreshToken', refreshToken!);
    if (userId != null) prefs.setString('userId', userId!);
    if (name != null) prefs.setString('name', name!);
    if (email != null) prefs.setString('email', email!);
    // if (role != null) prefs.setString('role', role!);
    if (profileImageUrl != null)
      prefs.setString('profileImageUrl', profileImageUrl!);
    // if (biometricHash != null) prefs.setString('biometricHash', biometricHash!);
  }

  Future<void> clear() async {
    accessToken = null;
    refreshToken = null;
    userId = null;
    name = null;
    email = null;
    // role = null;
    profileImageUrl = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    await prefs.remove('userId');
    await prefs.remove('name');
    await prefs.remove('email');
    // await prefs.remove('role');
    await prefs.remove('profileImageUrl');
  }

  Future<void> logout(
      {String message = "Session expired. Please login again."}) async {
    await clear();
    Get.offAllNamed(Routes.LOGIN);
    DialogHelper.showError(message);
  }
}
