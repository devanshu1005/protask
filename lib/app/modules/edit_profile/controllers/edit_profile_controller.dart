import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protask1/app/services/call_helper.dart';
import 'package:protask1/app/utils/app_globals.dart';
import 'package:protask1/app/utils/widgets/dialogue_helper.dart';
import 'package:protask1/app/utils/widgets/loader_view.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final mobileController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController.text = AppGlobals.instance.name.value ?? '';
    ageController.text = AppGlobals.instance.age?.toString() ?? '';
    mobileController.text = AppGlobals.instance.mobile.value ?? '';
  }

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    mobileController.dispose();
    super.onClose();
  }

  Future<void> updateProfile() async {
    final name = nameController.text.trim();
    final age = int.tryParse(ageController.text.trim());
    final mobile = mobileController.text.trim();

    if (name.isEmpty || age == null || mobile.isEmpty) {
      DialogHelper.showInfo("All fields are required");
      return;
    }

    isLoading.value = true;
    LoaderView.customLogoLoader();

    try {
      final result = await CallHelper().patch('/user/update', data: {
        "userData": {
          "name": name,
          "age": age,
          "mobileNumber": mobile,
        }
      });

      if (result is Map && result['success'] == false) {
        DialogHelper.showError(result['message'] ?? "Update failed");
      } else {
        // Update local globals
        AppGlobals.instance.name.value = name;
        AppGlobals.instance.age.value = age;
        AppGlobals.instance.mobile.value = mobile;
        await AppGlobals.instance.saveToStorage();

        DialogHelper.showSuccess("Profile updated successfully");

// Wait a moment to let snackbar show before navigating back
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back();
      }
    } catch (e) {
      DialogHelper.showError("Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
      await LoaderView.hideLoading();
    }
  }
}
