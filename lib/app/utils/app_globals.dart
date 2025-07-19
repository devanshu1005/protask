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

  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString profileImageUrl = ''.obs;
  final RxString mobile = ''.obs;
  final RxInt age = 0.obs;

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
    name.value = prefs.getString('name') ?? '';
    email.value = prefs.getString('email') ?? '';
    profileImageUrl.value = prefs.getString('profileImageUrl') ?? '';
    mobile.value = prefs.getString('mobile') ?? '';
    age.value = prefs.getInt('age') ?? 0;
  }

  Future<void> saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    if (accessToken != null) prefs.setString('accessToken', accessToken!);
    if (refreshToken != null) prefs.setString('refreshToken', refreshToken!);
    if (userId != null) prefs.setString('userId', userId!);
    prefs.setString('name', name.value);
    prefs.setString('email', email.value);
    prefs.setString('profileImageUrl', profileImageUrl.value);
    prefs.setString('mobile', mobile.value);
    prefs.setInt('age', age.value);
  }

  Future<void> clear() async {
    accessToken = null;
    refreshToken = null;
    userId = null;

    name.value = '';
    email.value = '';
    profileImageUrl.value = '';
    mobile.value = '';
    age.value = 0;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    await prefs.remove('userId');
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('profileImageUrl');
    await prefs.remove('mobile');
    await prefs.remove('age');
  }

  Future<void> logout({String? message}) async {
    await clear();
    Get.offAllNamed(Routes.LOGIN);
    if (message != null && message.isNotEmpty) {
      DialogHelper.showError(message);
    }
  }
}
